$repoUrl = "https://github.com/gu2121gg/cmd/archive/refs/heads/main.zip"; # URL direta para o ZIP do seu repositório
$destinationFolder = ".\cmd_repo_download"; # Pasta onde o repositório será extraído (no diretório atual)
$tempZipFile = Join-Path $env:TEMP "cmd_repo_temp.zip"; # Caminho para o arquivo ZIP temporário

# Cria a pasta de destino se ela não existir, forçando a criação se necessário
New-Item -ItemType Directory -Force -Path $destinationFolder | Out-Null;

Write-Host "Iniciando download e extração do repositório GitHub...";

try {
    # Baixa o arquivo ZIP do repositório. Out-Null evita output desnecessário.
    Invoke-WebRequest -Uri $repoUrl -OutFile $tempZipFile -ErrorAction Stop | Out-Null;

    Write-Host "Arquivo ZIP baixado. Extraindo conteúdo...";

    # Extrai o conteúdo do ZIP para a pasta de destino. O parâmetro -Force sobrescreve se existir.
    Expand-Archive -Path $tempZipFile -DestinationPath $destinationFolder -Force -ErrorAction Stop;

    Write-Host "Conteúdo extraído. Limpando arquivos temporários...";

    # Remove o arquivo ZIP temporário. SilentlyContinue evita erros se o arquivo já não existir.
    Remove-Item -Path $tempZipFile -Force -ErrorAction SilentlyContinue | Out-Null;

    # Exibe o caminho completo onde os arquivos foram extraídos
    Write-Host "Download e extração concluídos com sucesso em: $(Resolve-Path $destinationFolder)";

} catch {
    Write-Error "Ocorreu um erro durante o processo: $($_.Exception.Message)";
    # Se houver um erro, tenta limpar o ZIP temporário
    if (Test-Path $tempZipFile) { Remove-Item -Path $tempZipFile -Force -ErrorAction SilentlyContinue | Out-Null; }
}
