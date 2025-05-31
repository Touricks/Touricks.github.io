# PowerShell script for complete lowercase migration
# This script will rename files and update all links

# Phase 1: Create mapping of old names to new names
function Get-FileNameMapping {
    param ([string]$Directory)
    
    $mapping = @{}
    Get-ChildItem "$Directory\*.md" | ForEach-Object {
        $oldName = $_.BaseName
        $newName = $oldName.ToLower() -replace '[^a-z0-9\-]', '-' -replace '--+', '-' -replace '^-|-$', ''
        if ($oldName -ne $newName) {
            $mapping[$oldName] = $newName
        }
    }
    return $mapping
}

# Phase 2: Rename files
function Rename-FilesToLowercase {
    param ([string]$Directory, [hashtable]$Mapping)
    
    Write-Host "Renaming files in $Directory..."
    
    foreach ($oldName in $Mapping.Keys) {
        $newName = $Mapping[$oldName]
        $oldPath = Join-Path $Directory "$oldName.md"
        $newPath = Join-Path $Directory "$newName.md"
        
        if (Test-Path $oldPath) {
            Write-Host "Renaming: $oldName.md -> $newName.md"
            Move-Item $oldPath $newPath -Force
        }
    }
}

# Phase 3: Update all links in all files
function Update-LinksInFile {
    param ([string]$FilePath, [hashtable]$AlgorithmMapping, [hashtable]$CursorMapping)
    
    $content = Get-Content $FilePath -Raw -Encoding UTF8
    $originalContent = $content
    
    # Extract filename for title
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
    $title = $filename
    
    # Add front matter if missing
    if (-not $content.StartsWith("---")) {
        $frontMatter = @"
---
layout: default
title: $title
narrow: true
---

"@
        $content = $frontMatter + $content
    }
    
    # Update algorithm links
    foreach ($oldName in $AlgorithmMapping.Keys) {
        $newName = $AlgorithmMapping[$oldName]
        # Fix both [text](/algorithmn-notes/oldname.html) and [[oldname]] formats
        $content = $content -replace "\(/algorithmn-notes/$oldName\.html\)", "(/algorithmn-notes/$newName.html)"
        $content = $content -replace "\[\[$oldName\]\]", "[$oldName](/algorithmn-notes/$newName.html)"
    }
    
    # Update cursor links  
    foreach ($oldName in $CursorMapping.Keys) {
        $newName = $CursorMapping[$oldName]
        $content = $content -replace "\(/algorithmn-notes/$oldName\.html\)", "(/algorithmn-notes/$newName.html)"
        $content = $content -replace "\[\[$oldName\]\]", "[$oldName](/algorithmn-notes/$newName.html)"
    }
    
    # Fix any remaining [[]] links (convert to proper format)
    $lines = $content -split "`n"
    $processedLines = @()
    
    foreach ($line in $lines) {
        $processedLine = $line
        
        # Skip lines that contain input/output data
        if (-not ($line -match '\*\*Input:\*\*' -or $line -match '\*\*Output:\*\*' -or 
                  $line -match 'intervals\s*=' -or $line -match 'grid\s*=' -or
                  $line -match '\[\[.*,.*\]\]')) {
            
            # Convert remaining [[]] to proper links
            $processedLine = $processedLine -replace '\[\[([^\]]+)\]\]', {
                param($match)
                $linkText = $match.Groups[1].Value
                $linkUrl = $linkText.ToLower() -replace '[^a-z0-9\-]', '-' -replace '--+', '-' -replace '^-|-$', ''
                return "[$linkText](/algorithmn-notes/$linkUrl.html)"
            }
        }
        
        $processedLines += $processedLine
    }
    
    $content = $processedLines -join "`n"
    
    # Only write if content changed
    if ($content -ne $originalContent) {
        Write-Host "Updating links in: $FilePath"
        $content | Set-Content $FilePath -Encoding UTF8 -NoNewline
    }
}

# Main execution
Write-Host "Starting lowercase migration..."

# Create mappings
$algorithmMapping = Get-FileNameMapping "_blog_algorithm"
$cursorMapping = Get-FileNameMapping "_blog_cursor"

Write-Host "Algorithm files to rename: $($algorithmMapping.Count)"
Write-Host "Cursor files to rename: $($cursorMapping.Count)"

# Show what will be renamed
Write-Host "`nAlgorithm file renames:"
$algorithmMapping.GetEnumerator() | ForEach-Object { Write-Host "  $($_.Key) -> $($_.Value)" }

Write-Host "`nCursor file renames:"
$cursorMapping.GetEnumerator() | ForEach-Object { Write-Host "  $($_.Key) -> $($_.Value)" }

# Confirm before proceeding
$confirm = Read-Host "`nDo you want to proceed with the migration? (y/N)"
if ($confirm -eq 'y' -or $confirm -eq 'Y') {
    
    # Phase 1: Rename files
    Rename-FilesToLowercase "_blog_algorithm" $algorithmMapping
    Rename-FilesToLowercase "_blog_cursor" $cursorMapping
    
    # Phase 2: Update all links in all files
    Write-Host "`nUpdating links in all files..."
    
    Get-ChildItem "_blog_algorithm\*.md" | ForEach-Object {
        Update-LinksInFile $_.FullName $algorithmMapping $cursorMapping
    }
    
    Get-ChildItem "_blog_cursor\*.md" | ForEach-Object {
        Update-LinksInFile $_.FullName $algorithmMapping $cursorMapping
    }
    
    Write-Host "`nMigration completed successfully!"
    Write-Host "All files have been renamed to lowercase and all links have been updated."
    
} else {
    Write-Host "Migration cancelled."
} 