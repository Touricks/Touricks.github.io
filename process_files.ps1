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
    $content = $content -replace '\[\[([^\]]+)\]\]', '[${1}](/algorithmn-notes/${1}.html)'
    
    # Convert spaces and special characters in link URLs to lowercase and hyphens
    $content = $content -replace '\(/algorithmn-notes/([^.]+)\.html\)', {
        $linkText = $_.Groups[1].Value
        $cleanLink = $linkText -replace '[^a-zA-Z0-9]', '-' -replace '-+', '-' -replace '^-|-$', ''
        "(/algorithmn-notes/$($cleanLink.ToLower()).html)"
    }
    
    # Write back to file with UTF8 encoding
    $content | Set-Content $FilePath -Encoding UTF8
}

# Process all files in blog_algorithm directory
Write-Host "Processing blog_algorithm files..."
Get-ChildItem "blog_algorithm\*.md" | ForEach-Object {
    Process-MarkdownFile $_.FullName
}

# Process all files in blog_cursor directory
Write-Host "Processing blog_cursor files..."
Get-ChildItem "blog_cursor\*.md" | ForEach-Object {
    Process-MarkdownFile $_.FullName
}

Write-Host "Processing complete!" 