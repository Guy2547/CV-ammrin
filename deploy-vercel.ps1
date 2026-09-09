# Republishes the Flutter web app to the `vercel-static` branch.
# Run from the repo root (on `main`) after changing the app:
#   .\deploy-vercel.ps1
# Then Vercel (Production Branch = vercel-static) redeploys automatically.
$ErrorActionPreference = "Stop"

$root = $PSScriptRoot
Set-Location $root

# flutter writes warnings to stderr; keep them non-terminating, fail on exit code instead.
$ErrorActionPreference = "Continue"
flutter build web --release --base-href "/"
if ($LASTEXITCODE -ne 0) { throw "flutter build failed with exit code $LASTEXITCODE" }
$ErrorActionPreference = "Stop"

$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("cv-deploy-" + [System.Guid]::NewGuid().ToString("N"))
git worktree add --detach $tmp | Out-Null
try {
  Set-Location $tmp
  git checkout -B vercel-static origin/vercel-static | Out-Null
  git rm -rf --quiet . | Out-Null
  Get-ChildItem -Force -Exclude ".git" | Remove-Item -Recurse -Force
  Copy-Item -Path (Join-Path $root "build\web\*") -Destination . -Recurse -Force -Exclude ".vercel", ".env.local", ".gitignore"
  # Never publish local Vercel CLI state/secrets even if `vercel link` created them inside build/web.
  Remove-Item -Recurse -Force ".vercel", ".env.local", ".gitignore" -ErrorAction SilentlyContinue
  Copy-Item -Path (Join-Path $root "deploy-vercel-note.md") -Destination (Join-Path $tmp "README_DEPLOY.md") -Force
  git add -A
  if (git status --porcelain) {
    git commit -m "Deploy web build $(Get-Date -Format 'yyyy-MM-dd HH:mm')" | Out-Null
    git push origin vercel-static | Out-Null
    "Pushed vercel-static."
  } else {
    "No changes to deploy."
  }
} finally {
  Set-Location $root
  git worktree remove --force $tmp
}
