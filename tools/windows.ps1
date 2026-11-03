param(
    [ValidateSet('build','test','layout','workflow')][string]$Action='test',
    [string]$Python
)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$taskPython=$Python
if (-not $taskPython) {
    $bundledPython=Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
    if (Test-Path -LiteralPath $bundledPython) { $taskPython=$bundledPython }
    else {
        $pythonCommand=Get-Command python.exe -ErrorAction SilentlyContinue
        if ($pythonCommand -and $pythonCommand.Source -notlike '*WindowsApps*') { $taskPython=$pythonCommand.Source }
        else { throw 'Pass -Python with the full path to Python 3.11 or newer.' }
    }
}
$previousUtf8=$env:PYTHONUTF8
Push-Location $projectRoot
try {
    $env:PYTHONUTF8='1'
    switch ($Action) {
        'build' { & $taskPython -X utf8 tools/project.py build }
        'test' { & $taskPython -X utf8 tests/refactor.py }
        'layout' { & $taskPython -X utf8 tests/layout_baseline.py }
        'workflow' { & $taskPython -X utf8 tests/workflow.py }
    }
    if ($LASTEXITCODE -ne 0) { throw "Forest $Action failed (exit $LASTEXITCODE)." }
} finally {
    $env:PYTHONUTF8=$previousUtf8
    Pop-Location
}
