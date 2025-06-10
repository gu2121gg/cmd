# Este script é para fins educacionais e de teste APENAS.
# Ele simula um comportamento "de vírus" abrindo várias janelas do CMD com texto verde.
# ELE NÃO CAUSA NENHUM DANO REAL AO SEU SISTEMA.

Write-Host "Iniciando simulação de 'instalação de vírus' (apenas para teste)..." -ForegroundColor Yellow

# Número de janelas CMD a serem abertas
$numCmdWindows = 10;

# Tentar encontrar o caminho para cmd.exe
$cmdPath = "$env:SystemRoot\System32\cmd.exe"
if (-not (Test-Path $cmdPath)) {
    Write-Warning "cmd.exe não encontrado em $cmdPath. Tentando PATH...";
    $cmdPath = (Get-Command cmd.exe).Path
}

if (-not (Test-Path $cmdPath)) {
    Write-Error "Não foi possível localizar cmd.exe. Abortando simulação."
    return
}

for ($i = 1; $i -le $numCmdWindows; $i++) {
    # Comando para abrir um CMD com fundo preto e texto verde, e exibir uma mensagem
    # O ping -n 3 127.0.0.1 > nul mantém a janela aberta por 3 segundos antes de fechar automaticamente
    $cmdArguments = "/c color 0a & echo Acessando o sistema... & echo Processando dados... & echo Instalacao em andamento... & ping -n 3 127.0.0.1 > nul & exit";
    
    try {
        # Para que as janelas apareçam e fiquem visíveis por um tempo:
        Start-Process -FilePath $cmdPath -ArgumentList $cmdArguments;
        Start-Sleep -Milliseconds 100; # Pequeno atraso para as janelas abrirem em sequência
    } catch {
        Write-Warning "Falha ao abrir janela CMD número $i: $($_.Exception.Message)";
    }
}

Write-Host "Simulação concluída. Nenhuma modificação prejudicial foi feita." -ForegroundColor Green
            
