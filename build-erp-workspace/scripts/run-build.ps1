param(
    [string]$RepoPath = (Get-Location).Path,
    [string]$Target,
    [switch]$Clean,
    [string]$CleanAuthorizedByUser,
    [switch]$WhatWouldRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoConfigs = @(
    [pscustomobject]@{
        Name = 'erp-financas-servicos'
        RepoRoot = 'C:\@work\erp-financas-servicos'
        BuildDir = 'C:\@work\erp-financas-servicos\build'
        Mode = 'nsbuild'
        DefaultTarget = 'nsjfinancas'
        AllowedTargets = @('nsjfinancas', 'nsjservicos')
        AllowAnyTarget = $true
    },
    [pscustomobject]@{
        Name = 'erp-admin'
        RepoRoot = 'C:\@work\erp-admin'
        BuildDir = 'C:\@work\erp-admin\build'
        Mode = 'nsbuild'
        DefaultTarget = 'nsjadmin'
        AllowedTargets = @('nsjadmin')
        AllowAnyTarget = $false
    },
    [pscustomobject]@{
        Name = 'erp-persona'
        RepoRoot = 'C:\@work\erp-persona'
        BuildDir = 'C:\@work\erp-persona\build'
        Mode = 'nsbuild'
        DefaultTarget = 'nsjpersona'
        AllowedTargets = @('nsjpersona')
        AllowAnyTarget = $false
    },
    [pscustomobject]@{
        Name = 'erp-utils'
        RepoRoot = 'C:\@work\erp-utils'
        BuildDir = 'C:\@work\erp-utils\build'
        Mode = 'batch'
        DefaultCommand = 'build_all_debug.bat'
        AllowedTargets = @()
        AllowAnyTarget = $false
    },
    [pscustomobject]@{
        Name = 'erp-libraries'
        RepoRoot = 'C:\@work\erp-libraries'
        BuildDir = 'C:\@work\erp-utils\build'
        Mode = 'batch'
        DefaultCommand = 'build_all_debug.bat'
        AllowedTargets = @()
        AllowAnyTarget = $false
    }
)

function Resolve-RepoConfig {
    param(
        [string]$InputPath,
        [object[]]$Configs
    )

    $resolvedInput = [IO.Path]::GetFullPath($InputPath)
    $match = $Configs |
        Where-Object { $resolvedInput.StartsWith($_.RepoRoot, [System.StringComparison]::OrdinalIgnoreCase) } |
        Sort-Object { $_.RepoRoot.Length } -Descending |
        Select-Object -First 1

    if ($null -eq $match) {
        throw "Nao foi possivel resolver um repo ERP suportado a partir de '$resolvedInput'."
    }

    return $match
}

function Get-ErrorHintFromLog {
    param(
        [string]$BuildDir,
        [string]$Target
    )

    $logCandidates = @()
    if (-not [string]::IsNullOrWhiteSpace($Target)) {
        $logCandidates += (Join-Path $BuildDir ("logs\{0}.log" -f $Target))
    }

    $logsDir = Join-Path $BuildDir 'logs'
    if (Test-Path -LiteralPath $logsDir) {
        $recentLogs = Get-ChildItem -LiteralPath $logsDir -File -Filter *.log |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 5
        foreach ($log in $recentLogs) {
            if ($logCandidates -notcontains $log.FullName) {
                $logCandidates += $log.FullName
            }
        }
    }

    foreach ($logPath in $logCandidates) {
        if (-not (Test-Path -LiteralPath $logPath)) {
            continue
        }

        $line = Get-Content -LiteralPath $logPath -ErrorAction SilentlyContinue |
            Where-Object {
                $_ -match '(?i)\berror\s+F\d{4}\b' -or
                $_ -match '(?i)\bfatal\b' -or
                $_ -match '(?i)erro de compila' -or
                $_ -match '(?i)build com falhas'
            } |
            Select-Object -First 1

        if (-not [string]::IsNullOrWhiteSpace($line)) {
            return [pscustomobject]@{
                LogPath = $logPath
                ErrorLine = $line.Trim()
            }
        }
    }

    return $null
}

function Invoke-NsBuild {
    param(
        [string]$BuildDir,
        [string[]]$Arguments
    )

    $nsbuildCommand = Get-Command -Name nsbuild -ErrorAction SilentlyContinue
    if ($null -ne $nsbuildCommand) {
        & nsbuild @Arguments
        return $LASTEXITCODE
    }

    $quotedArgs = @()
    foreach ($arg in $Arguments) {
        $quotedArgs += ('"{0}"' -f $arg.Replace('"', '""'))
    }

    $cmdLine = 'cd /d "{0}" && nsbuild.bat {1}' -f $BuildDir, ($quotedArgs -join ' ')
    & cmd /c $cmdLine
    return $LASTEXITCODE
}

$config = Resolve-RepoConfig -InputPath $RepoPath -Configs $repoConfigs

if ($Clean -and [string]::IsNullOrWhiteSpace($CleanAuthorizedByUser)) {
    throw "Clean bloqueado: informe -CleanAuthorizedByUser com a confirmacao textual do usuario no mesmo turno."
}

if ($config.Mode -eq 'nsbuild') {
    $resolvedTarget = if ([string]::IsNullOrWhiteSpace($Target)) { $config.DefaultTarget } else { $Target.Trim() }
    if (-not $config.AllowAnyTarget -and $config.AllowedTargets -notcontains $resolvedTarget) {
        throw "Alvo '$resolvedTarget' nao e valido para '$($config.Name)'. Alvos permitidos: $($config.AllowedTargets -join ', ')."
    }

    $summary = [pscustomobject]@{
        Repo = $config.Name
        BuildDir = $config.BuildDir
        Clean = [bool]$Clean
        Target = $resolvedTarget
        Command = "nsbuild $resolvedTarget"
    }
}
else {
    if (-not [string]::IsNullOrWhiteSpace($Target)) {
        throw "O repo '$($config.Name)' nao usa alvo via nsbuild. Nao informe -Target."
    }

    if ($Clean) {
        throw "O repo '$($config.Name)' nao possui fluxo de clean padrao nesta skill."
    }

    $summary = [pscustomobject]@{
        Repo = $config.Name
        BuildDir = $config.BuildDir
        Clean = $false
        Target = ''
        Command = $config.DefaultCommand
    }
}

Write-Output ("Repo: {0}" -f $summary.Repo)
Write-Output ("BuildDir: {0}" -f $summary.BuildDir)
Write-Output ("Clean: {0}" -f $summary.Clean)
if ($summary.Target) {
    Write-Output ("Target: {0}" -f $summary.Target)
}
Write-Output ("Command: {0}" -f $summary.Command)

if ($WhatWouldRun) {
    exit 0
}

$exitCode = 0
Push-Location -LiteralPath $summary.BuildDir
try {
    if ($config.Mode -eq 'nsbuild') {
        $runTarget = $true
        if ($Clean) {
            $exitCode = Invoke-NsBuild -BuildDir $summary.BuildDir -Arguments @('clean')
            if ($exitCode -ne 0) {
                $runTarget = $false
            }
        }

        if ($runTarget) {
            $exitCode = Invoke-NsBuild -BuildDir $summary.BuildDir -Arguments @($summary.Target)
            if ($exitCode -ne 0) {
                $hint = Get-ErrorHintFromLog -BuildDir $summary.BuildDir -Target $summary.Target
                if ($null -ne $hint) {
                    Write-Output ("FailureLog: {0}" -f $hint.LogPath)
                    Write-Output ("FailureHint: {0}" -f $hint.ErrorLine)
                }
            }
        }
    }
    else {
        & (Join-Path $summary.BuildDir $summary.Command)
        $exitCode = $LASTEXITCODE
    }
}
finally {
    Pop-Location
}

exit $exitCode
