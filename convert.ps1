param (
    [string]$filePath,
    [string]$fontName
)

# Check if filePath was provided
if (-not $filePath) {
    Write-Host "Error: You must provide the font file path as the first argument."
    exit 1
}

# Check if fontName was provided, if not use the file name
if (-not $fontName) {
    $fontName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
}

# Normalize file path (convert backslashes to slashes)
$filePath = $filePath -replace "\\", "/"

# Get the script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define paths relative to script location
$toolsDir = Join-Path -Path $scriptDir -ChildPath "tools"
$inputXmlPath = Join-Path -Path $toolsDir -ChildPath "input.xml"
$outputDir = Join-Path -Path $scriptDir -ChildPath "output"

# Ensure tools and output directories exist
if (!(Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir | Out-Null
}
if (!(Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Load XML
$inputXml = [xml](Get-Content $inputXmlPath)

# Edit font attributes
$inputXml.movie.frame.library.font.SetAttribute("id", $fontName)
$inputXml.movie.frame.library.font.SetAttribute("name", $fontName)
$inputXml.movie.frame.library.font.SetAttribute("import", $filePath)

# Save the modified XML
$inputXml.Save($inputXmlPath)

# Convert the font to GFX
Set-Location $toolsDir
./swfmill.exe simple input.xml output.swf
./gfxexport.exe output.swf | Out-Null

# Clean up and move the result
Remove-Item "output.swf"
Move-Item -Path "output.gfx" -Destination (Join-Path -Path $outputDir -ChildPath "output.gfx")
Rename-Item -Path (Join-Path -Path $outputDir -ChildPath "output.gfx") -NewName "$fontName.gfx"

# Finished
Write-Host "`nConversion complete! The exported font is now available in the output folder."