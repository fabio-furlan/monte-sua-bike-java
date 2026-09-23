# Sobe o MySQL (portatil) e o Tomcat (via Maven/Cargo) para o projeto monte-sua-bike-java.
# Uso: powershell -ExecutionPolicy Bypass -File .\start-dev.ps1

$ErrorActionPreference = "Stop"

$mysqlBaseDir = "C:\Program Files\MySQL\MySQL Server 8.4"
$mysqlBin     = "$mysqlBaseDir\bin"
$mysqlData    = "C:\dev\tools\mysql-data"
$mavenBin     = "C:\dev\tools\apache-maven-3.9.9\bin"
$javaHome     = "C:\dev\java\openjdk\jdk-19.0.2"
$projectDir   = "C:\dev\projetos\projetos\monte-sua-bike-java"

function Test-PortListening($port) {
    return [bool](Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue)
}

# 1. MySQL
if (Test-PortListening 3306) {
    Write-Host "MySQL ja esta rodando na porta 3306."
} else {
    Write-Host "Iniciando MySQL..."
    Start-Process -FilePath "$mysqlBin\mysqld.exe" `
        -ArgumentList @("--datadir=$mysqlData", "--basedir=$mysqlBaseDir", "--port=3306") `
        -WindowStyle Hidden `
        -RedirectStandardOutput "$mysqlData\mysqld-stdout.log" `
        -RedirectStandardError "$mysqlData\mysqld-stderr.log"

    $deadline = (Get-Date).AddSeconds(30)
    while (-not (Test-PortListening 3306)) {
        if ((Get-Date) -gt $deadline) {
            throw "MySQL nao subiu em 30s. Veja $mysqlData\mysqld-stderr.log"
        }
        Start-Sleep -Milliseconds 500
    }
    Write-Host "MySQL pronto na porta 3306."
}

# 2. Tomcat (embutido via Maven Cargo) - roda em primeiro plano, Ctrl+C para parar
$env:PATH = "$mavenBin;" + $env:PATH
$env:JAVA_HOME = $javaHome
Set-Location $projectDir

Write-Host "Iniciando Tomcat (mvn cargo:run)..."
Write-Host "App vai ficar em http://localhost:8081/monte-sua-bike/"
& "$mavenBin\mvn.cmd" cargo:run
