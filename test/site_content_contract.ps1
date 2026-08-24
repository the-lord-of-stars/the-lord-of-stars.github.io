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
Require-Text '_pages/about.md' '(?m)^title: about\r?$' 'About page'
Require-Text '_pages/publications.md' '(?m)^nav_order: 2\r?$' 'Publications navigation'
Require-Text '_pages/experience.md' '(?m)^nav_order: 3\r?$' 'Experience navigation'
Require-Text '_pages/projects.md' '(?m)^nav_order: 4\r?$' 'Projects navigation'
Require-Text '_pages/cv.md' '(?m)^nav_order: 5\r?$' 'CV navigation'
Require-Text '_pages/personal-site.md' 'https://www\.zefei\.site' 'Personal Site link'
Require-Text '_projects/awesomelit.md' 'AwesomeLit' 'AwesomeLit project'
Require-Text '_bibliography/papers.bib' 'What Happened to Automated Visualization\?' 'Agentic visualization publication'
Require-Text '_pages/experience.md' 'Zhejiang Dahua Technology' 'Dahua experience'
Require-Text '_pages/experience.md' 'NetEase Hangzhou Research Institute' 'NetEase experience'
Require-Text '_projects/ibm-watsonx-assistant.md' 'IBM Watsonx' 'IBM Watsonx project'
Require-Text '_pages/experience.md' '70%' 'GPU memory result'
Require-Text '_projects/ibm-watsonx-assistant.md' '67 peak concurrent users' 'concurrency result'
Require-Text '_projects/agentic-insight.md' 'Top 5' 'challenge result'
Require-Text '_pages/about.md' 'prof_pic\.jpg' 'profile portrait reference'
Require-Text '_pages/cv.md' '/assets/pdf/Zefei_Xie_CV\.pdf' 'CV asset reference'
Require-Text '_config.yml' '(?m)^serve_og_meta: true\r?$' 'Open Graph metadata'
Require-Text '_config.yml' '(?m)^serve_schema_org: true\r?$' 'Schema.org metadata'
$portraitPath = Join-Path $repoRoot 'assets/img/prof_pic.jpg'
$cvPath = Join-Path $repoRoot 'assets/pdf/Zefei_Xie_CV.pdf'
if (-not (Test-Path $portraitPath)) { $failures.Add('Missing portrait asset') }
if (-not (Test-Path $cvPath)) { $failures.Add('Missing CV asset') }
$publishedFiles = Get-ChildItem $repoRoot -Recurse -File | Where-Object {
  $_.FullName -notmatch '[\\/]\.git[\\/]' -and
  $_.FullName -notmatch '[\\/]docs[\\/]superpowers[\\/]' -and
  $_.FullName -notmatch '[\\/]test[\\/]'
}
$privatePhone = '(626)' + ' 944' + '-1861'
if ($publishedFiles | Select-String -SimpleMatch $privatePhone) { $failures.Add('Phone number appears in published files') }
if ($failures.Count -gt 0) { $failures | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host 'Site content contract passed.'
