@echo off
cls
echo Verificando se o Python esta instalado...

:: Verifica se o Python está instalado
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python nao encontrado! Baixando e instalando...
    :: Baixar o instalador do Python
    curl -o python_installer.exe https://www.python.org/ftp/python/3.9.6/python-3.9.6.exe
    :: Instalar Python silenciosamente
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
    echo Python instalado com sucesso!
) else (
    echo Python ja esta instalado!
)

echo.
echo Verificando se o Git esta instalado...

:: Verifica se o Git está instalado
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Git nao encontrado! Baixando e instalando...
    :: Baixar o instalador do Git
    curl -o git_installer.exe https://git-scm.com/download/win
    :: Instalar Git silenciosamente
    start /wait git_installer.exe /VERYSILENT /NORESTART
    echo Git instalado com sucesso!
) else (
    echo Git ja esta instalado!
)

:: Agora, abre o link
echo.
echo Abrindo o link...
start https://www.youtube.com/watch?v=5ceevGlzBCo

pause
