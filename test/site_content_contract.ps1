$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$failures = [System.Collections.Generic.List[string]]::new()
function Require-Text([string]$Path, [string]$Pattern, [string]$Label) {
  $content = Get-Content -Raw (Join-Path $repoRoot $Path)
  if ($content -notmatch $Pattern) { $failures.Add("Missing: $Label") }
}
Require-Text '_config.yml' '(?m)^first_name: Zefei$' 'first name'
Require-Text '_config.yml' '(?m)^last_name: Xie$' 'last name'
Require-Text '_config.yml' '(?m)^url: https://the-lord-of-stars\.github\.io$' 'root URL'
Require-Text '_config.yml' '(?m)^baseurl:\s*$' 'blank baseurl'
Require-Text '_pages/about.md' '(?m)^nav_order: 1$' 'About navigation'
Require-Text '_pages/publications.md' '(?m)^nav_order: 2$' 'Publications navigation'
Require-Text '_pages/experience.md' '(?m)^nav_order: 3$' 'Experience navigation'
Require-Text '_pages/projects.md' '(?m)^nav_order: 4$' 'Projects navigation'
Require-Text '_pages/cv.md' '(?m)^nav_order: 5$' 'CV navigation'
Require-Text '_pages/personal-site.md' 'https://www\.zefei\.site' 'Personal Site link'
$publishedFiles = Get-ChildItem $repoRoot -Recurse -File | Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' -and $_.FullName -notmatch '[\\/]docs[\\/]superpowers[\\/]' }
if ($publishedFiles | Select-String -SimpleMatch '(626) 944-1861') { $failures.Add('Phone number appears in published files') }
if ($failures.Count -gt 0) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host 'Site content contract passed.'
