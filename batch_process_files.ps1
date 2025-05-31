# PowerShell script to process all markdown files
# Add front matter and fix [[]] links

function Process-MarkdownFile {
    param (
        [string]$FilePath
    )
    
    Write-Host "Processing: $FilePath"
    
    # Read file content
    $content = Get-Content $FilePath -Raw -Encoding UTF8
    
    # Extract filename without extension for title
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
    $title = $filename
    
    # Check if front matter already exists
    if (-not $content.StartsWith("---")) {
        # Add front matter
        $frontMatter = @"
---
layout: default
title: $title
narrow: true
---

"@
        $content = $frontMatter + $content
    }
    
    # Fix [[]] links to [filename](/algorithmn-notes/filename.html) format
    # But exclude patterns that look like JSON arrays or input/output data
    $lines = $content -split "`n"
    $processedLines = @()
    
    foreach ($line in $lines) {
        $processedLine = $line
        
        # Skip lines that contain input/output data (JSON-like arrays)
        if (-not ($line -match '\*\*Input:\*\*' -or $line -match '\*\*Output:\*\*' -or $line -match 'intervals\s*=' -or $line -match 'grid\s*=')) {
            # Process [[]] links that are not data
            $processedLine = $processedLine -replace '\[\[([^\]]+)\]\]', '[${1}](/algorithmn-notes/${1}.html)'
        }
        
        $processedLines += $processedLine
    }
    
    $content = $processedLines -join "`n"
    
    # Write back to file with UTF8 encoding
    $content | Set-Content $FilePath -Encoding UTF8 -NoNewline
}

# Get all markdown files in both directories that don't already have proper front matter
$filesToProcess = @()

# Check blog_algorithm files
Get-ChildItem "blog_algorithm\*.md" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
    if ($content -and (-not $content.StartsWith("---") -or $content -match '\[\[.*\]\]')) {
        $filesToProcess += $_.FullName
    }
}

# Check blog_cursor files  
Get-ChildItem "blog_cursor\*.md" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
    if ($content -and (-not $content.StartsWith("---") -or $content -match '\[\[.*\]\]')) {
        $filesToProcess += $_.FullName
    }
}

Write-Host "Found $($filesToProcess.Count) files to process"

foreach ($file in $filesToProcess) {
    Process-MarkdownFile $file
}

Write-Host "Processing complete!" 