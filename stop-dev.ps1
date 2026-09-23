# Para o MySQL e o Tomcat (Maven/Cargo) do projeto monte-sua-bike-java.
# Uso: powershell -ExecutionPolicy Bypass -File .\stop-dev.ps1

$mysqlBaseDir = "C:\Program Files\MySQL\MySQL Server 8.4"
$mysqlBin     = "$mysqlBaseDir\bin"

function Test-PortListening($port) {
    return [bool](Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue)
}

# 1. Tomcat (processo filho do cargo:run) + Maven (processo pai do cargo:run)
$tomcatProcs = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -match "catalina\.base=.*tomcat9x" }
$mvnProcs = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
    Where-Object { $_.CommandLine -match "cargo:run" }

$appProcs = @($tomcatProcs) + @($mvnProcs) | Where-Object { $_ }
if ($appProcs.Count -eq 0) {
    Write-Host "Tomcat/cargo:run nao esta rodando."
} else {
    foreach ($p in $appProcs) {
        Write-Host "Parando processo $($p.ProcessId) ($($p.Name))..."
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    Write-Host "Tomcat parado."
}

# 2. MySQL - tenta shutdown limpo, senao mata o processo
if (-not (Test-PortListening 3306)) {
    Write-Host "MySQL ja nao esta rodando na porta 3306."
} else {
    Write-Host "Parando MySQL..."
    & "$mysqlBin\mysqladmin.exe" -h 127.0.0.1 -P 3306 -u root -padm1234 shutdown 2>&1 | Out-Null

    $deadline = (Get-Date).AddSeconds(20)
    while (Test-PortListening 3306) {
        if ((Get-Date) -gt $deadline) {
            Write-Host "Shutdown limpo nao respondeu, forcando encerramento do processo mysqld..."
            Get-Process mysqld -ErrorAction SilentlyContinue | Stop-Process -Force
            break
        }
        Start-Sleep -Milliseconds 500
    }
    Write-Host "MySQL parado."
}
