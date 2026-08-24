$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$failures = [System.Collections.Generic.List[string]]::new()
function Require-Text([string]$Path, [string]$Pattern, [string]$Label) {
  $content = Get-Content -Raw (Join-Path $repoRoot $Path)
  if ($content -notmatch $Pattern) { $failures.Add("Missing: $Label") }
}
Require-Text '_config.yml' '(?m)^first_name: Zefei\r?$' 'first name'
Require-Text '_config.yml' '(?m)^last_name: Xie\r?$' 'last name'
Require-Text '_config.yml' '(?m)^url: https://the-lord-of-stars\.github\.io\r?$' 'root URL'
Require-Text '_config.yml' '(?m)^baseurl:\s*\r?$' 'blank baseurl'
Require-Text '_pages/about.md' '(?m)^nav_order: 1\r?$' 'About navigation'
Require-Text '_pages/publications.md' '(?m)^nav_order: 2\r?$' 'Publications navigation'
Require-Text '_pages/experience.md' '(?m)^nav_order: 3\r?$' 'Experience navigation'
Require-Text '_pages/projects.md' '(?m)^nav_order: 4\r?$' 'Projects navigation'
Require-Text '_pages/cv.md' '(?m)^nav_order: 5\r?$' 'CV navigation'
Require-Text '_pages/personal-site.md' 'https://www\.zefei\.site' 'Personal Site link'
$publishedFiles = Get-ChildItem $repoRoot -Recurse -File | Where-Object {
  $_.FullName -notmatch '[\\/]\.git[\\/]' -and
  $_.FullName -notmatch '[\\/]docs[\\/]superpowers[\\/]' -and
  $_.FullName -notmatch '[\\/]test[\\/]'
}
$privatePhone = '(626)' + ' 944' + '-1861'
if ($publishedFiles | Select-String -SimpleMatch $privatePhone) { $failures.Add('Phone number appears in published files') }
if ($failures.Count -gt 0) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host 'Site content contract passed.'
