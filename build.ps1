$releaseInfo = Invoke-RestMethod https://api.github.com/repos/PowerShell/PowerShellEditorServices/releases/latest -ErrorAction Stop
$version = $releaseInfo.name.Substring(1)

if (Test-Path $PSScriptRoot/plugin/PowerShellEditorServices) {
    $localVersion = (Get-Module $PSScriptRoot/plugin/PowerShellEditorServices/PowerShellEditorServices/PowerShellEditorServices.psd1 -ListAvailable).Version
    if ($localVersion -ge $version) {
        return
    }
}

$assetsInfo = Invoke-RestMethod $releaseInfo.assets_url
Remove-Item PowerShellEditorServices.zip -Force -ErrorAction SilentlyContinue
Remove-Item PowerShellEditorServices -Recurse -Force -ErrorAction SilentlyContinue

Invoke-RestMethod $assetsInfo.browser_download_url -OutFile PowerShellEditorServices.zip
Expand-Archive PowerShellEditorServices.zip $PSScriptRoot/plugin

Remove-Item PowerShellEditorServices.zip -ErrorAction SilentlyContinue
