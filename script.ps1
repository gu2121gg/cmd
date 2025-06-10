# ESTE SCRIPT É PARA FINS EDUCACIONAIS E DE TESTE APENAS.
# Ele simula a cópia de arquivos da pasta 'Imagens' (Pictures) do usuário atual para
# uma pasta de destino específica e simula a abertura de múltiplos CMDs.
# ELE NÃO CAUSA NENHUM DANO REAL AO SEU SISTEMA, NÃO É UM VÍRUS E NÃO MODIFICA ARQUIVOS DO SISTEMA.
# Todos os arquivos copiados serão colocados em uma pasta de simulação específica,
# que você pode apagar facilmente.

Write-Host "--- Iniciando Simulação (Educacional) ---" -ForegroundColor Yellow

# Define a pasta de destino para a simulação da cópia dentro do perfil do usuário atual.
# IMPORTANTE: Você pode alterar esta pasta, mas certifique-se de que é um local seguro e fácil de gerenciar.
# Criaremos esta pasta se ela não existir.
$simulationDestinationPath = Join-Path -Path $env:USERPROFILE -ChildPath "SimulatedExfilImages"

# Garante que a pasta de destino da simulação exista
try {
    if (-not (Test-Path $simulationDestinationPath)) {
        New-Item -ItemType Directory -Path $simulationDestinationPath -Force | Out-Null
        Write-Host "Pasta de destino da simulação criada: $simulationDestinationPath" -ForegroundColor Green
    } else {
        Write-Host "Pasta de destino da simulação já existe: $simulationDestinationPath" -ForegroundColor Cyan
    }
} catch {
    Write-Error "Erro ao criar/verificar pasta de destino da simulação: $($_.Exception.Message)"
    exit # Sai do script se não puder criar a pasta de destino
}

# Loop contínuo para simular o monitoramento e cópia
while ($true) {
    Write-Host "`n--- Iniciando ciclo de simulação... ---" -ForegroundColor Yellow

    $username = $env:USERNAME # Obtém o nome do usuário atual
    $picturesSourcePath = Join-Path -Path $env:USERPROFILE -ChildPath "Pictures" # Caminho para a pasta Imagens do usuário atual

    Write-Host "Verificando pasta 'Imagens' para o usuário atual: $username ($picturesSourcePath)" -ForegroundColor White

    if (Test-Path $picturesSourcePath) {
        try {
            # Copia o conteúdo da pasta 'Imagens' para a pasta de destino de simulação.
            # O parâmetro -Force sobrescreve arquivos se já existirem na pasta de destino,
            # simulando a sincronização ou cópia de novas versões.
            Copy-Item -Path (Join-Path $picturesSourcePath "*") -Destination $simulationDestinationPath -Recurse -Force -ErrorAction Stop

            Write-Host "  Conteúdo da pasta 'Imagens' de '$username' copiado com sucesso para '$simulationDestinationPath'." -ForegroundColor Green
        } catch {
            Write-Error "  Falha ao copiar imagens para o usuário '$username': $($_.Exception.Message)"
        }
    } else {
        Write-Warning "  Pasta 'Imagens' não encontrada para o usuário '$username' em: $picturesSourcePath"
    }

    # --- Simulação de múltiplos CMDs ---
    Write-Host "Iniciando simulação visual de 'vírus'..." -ForegroundColor Yellow
    $numCmdWindows = 10;
    $cmdPath = "$env:SystemRoot\System32\cmd.exe"
    if (-not (Test-Path $cmdPath)) {
        Write-Warning "cmd.exe não encontrado em $cmdPath. Tentando PATH...";
        $cmdPath = (Get-Command cmd.exe).Path
    }
    if (-not (Test-Path $cmdPath)) {
        Write-Error "Não foi possível localizar cmd.exe. Abortando simulação visual."
        # Não sai do script, apenas pula a parte visual se cmd.exe não for encontrado
    } else {
        for ($i = 1; $i -le $numCmdWindows; $i++) {
            # Comando para abrir um CMD com fundo preto e texto verde, e exibir uma mensagem
            # O ping -n 3 127.0.0.1 > nul mantém a janela aberta por 3 segundos antes de fechar automaticamente
            $cmdArguments = "/c color 0a & echo Acessando o sistema... & echo Processando dados... & echo Instalacao em andamento... & ping -n 3 127.0.0.1 > nul & exit";
            try {
                Start-Process -FilePath $cmdPath -ArgumentList $cmdArguments;
                Start-Sleep -Milliseconds 100; # Pequeno atraso para as janelas abrirem em sequência
            } catch {
                Write-Warning "Falha ao abrir janela CMD número ${i}: $($_.Exception.Message)";
            }
        }
    }
    Write-Host "Simulação visual concluída." -ForegroundColor Green


    Write-Host "`n--- Ciclo de simulação concluído. Aguardando 5 minutos... ---" -ForegroundColor Blue
    Start-Sleep -Seconds 300 # Aguarda 5 minutos (300 segundos) antes do próximo ciclo
}

Write-Host "--- Simulação encerrada ---" -ForegroundColor Red
# Nota: O script acima está em um loop infinito (while($true)),
# então 'Simulação encerrada' só será exibida se o script for parado manualmente (Ctrl+C).
