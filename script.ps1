# ESTE SCRIPT É PARA FINS EDUCACIONAIS E DE TESTE APENAS.
# Ele simula a cópia de arquivos da pasta 'Imagens' (Pictures) de cada usuário para
# uma pasta de destino específica.
# ELE NÃO CAUSA NENHUM DANO REAL AO SEU SISTEMA, NÃO É UM VÍRUS E NÃO MODIFICA ARQUIVOS DO SISTEMA.
# Todos os arquivos copiados serão colocados em uma pasta de simulação específica,
# que você pode apagar facilmente.

Write-Host "--- Iniciando Simulação de Cópia de Imagens  ---" -ForegroundColor Yellow

# Define a pasta de destino para a simulação da cópia
# IMPORTANTE: Você pode alterar esta pasta, mas certifique-se de que é um local seguro e fácil de gerenciar.
# Criaremos esta pasta se ela não existir.
$simulationDestinationPath = "C:\Users\SimulatedExfilImages"

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
    Write-Host "`n--- Iniciando ciclo de simulação de cópia... ---" -ForegroundColor Yellow

    # Obtém todos os perfis de usuário em C:\Users
    # Excluímos 'Default', 'Public' e 'All Users' que não são perfis de usuário ativos.
    $userProfiles = Get-ChildItem -Path "C:\Users" -Directory | Where-Object {
        $_.Name -ne "Default" -and $_.Name -ne "Public" -and $_.Name -ne "All Users" -and $_.Name -ne "Default User" -and $_.Name -notlike "Upd*" # Exclui outros perfis de sistema/temporários
    }

    if ($userProfiles.Count -eq 0) {
        Write-Warning "Nenhum perfil de usuário válido encontrado em C:\Users para simulação."
    }

    foreach ($userProfile in $userProfiles) {
        $username = $userProfile.Name
        $picturesSourcePath = Join-Path -Path $userProfile.FullName -ChildPath "Pictures"

        Write-Host "Verificando pasta 'Imagens' para o usuário: $username ($picturesSourcePath)" -ForegroundColor White

        if (Test-Path $picturesSourcePath) {
            try {
                # Define a subpasta de destino para este usuário dentro da pasta de simulação
                $userDestination = Join-Path -Path $simulationDestinationPath -ChildPath $username
                New-Item -ItemType Directory -Path $userDestination -Force | Out-Null # Garante a subpasta do usuário

                # Copia o conteúdo da pasta 'Imagens' para a pasta de destino de simulação.
                # O parâmetro -Force sobrescreve arquivos se já existirem na pasta de destino,
                # simulando a sincronização ou cópia de novas versões.
                Copy-Item -Path (Join-Path $picturesSourcePath "*") -Destination $userDestination -Recurse -Force -ErrorAction Stop

                Write-Host "  Conteúdo da pasta 'Imagens' de '$username' copiado com sucesso para '$userDestination'." -ForegroundColor Green
            } catch {
                Write-Error "  Falha ao copiar imagens para o usuário '$username': $($_.Exception.Message)"
            }
        } else {
            Write-Warning "  Pasta 'Imagens' não encontrada para o usuário '$username' em: $picturesSourcePath"
        }
    }

    Write-Host "`n--- Ciclo de simulação de cópia concluído. Aguardando 5 minutos... ---" -ForegroundColor Blue
    Start-Sleep -Seconds 300 # Aguarda 5 minutos (300 segundos) antes do próximo ciclo
}

Write-Host "--- Simulação encerrada ---" -ForegroundColor Red
# Nota: O script acima está em um loop infinito (while($true)),
# então 'Simulação encerrada' só será exibida se o script for parado manualmente (Ctrl+C).
