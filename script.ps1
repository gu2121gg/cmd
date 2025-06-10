while ($true) {
    # Caminhos das pastas
    $sourcePath = "Imagens"
    $destinationPath = "C:\Users"

    # Verifica se as pastas existem
    if (-not (Test-Path $sourcePath)) {
        Write-Error "A pasta de origem não existe: $sourcePath"
        return
    }

    if (-not (Test-Path $destinationPath)) {
        Write-Error "A pasta de destino não existe: $destinationPath"
        return
    }

    # Clona os arquivos da pasta de origem para a pasta de destino
    Copy-Item -Path $sourcePath\* -Destination $destinationPath -Recurse -Force

    Write-Host "Clonagem concluída com sucesso." -ForegroundColor Green

    # Aguarda 5 minutos antes de executar novamente
    Start-Sleep -Seconds 300
}
