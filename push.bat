@echo off
chcp 65001 >nul
cd /d "%~dp0"

:: 自动查找 GitHub Desktop 自带的 Git（兼容不同版本号）
for /f "tokens=*" %%i in ('dir /b /ad "%LOCALAPPDATA%\GitHubDesktop\app-*"') do set "GIT_PATH=%LOCALAPPDATA%\GitHubDesktop\%%i\resources\app\git\cmd"
set "PATH=%GIT_PATH%;%PATH%"

:: 如果尚未初始化，自动初始化并添加远程仓库
if not exist ".git" (
    git init
    git remote add origin https://github.com/NemecSoft/weblocation.git
)

:: 如果远程仓库不存在，自动添加
git remote show origin >nul 2>nul || git remote add origin https://github.com/NemecSoft/weblocation.git

set /p msg=modify: 

git add .
git commit -m "%msg%"
git push -u origin HEAD

echo.
echo ok
pause
