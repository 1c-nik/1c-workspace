# setup.ps1 — первичная настройка рабочего места
param(
    [string]$Root = $PSScriptRoot
)

$skillsSource = Join-Path $Root "claude-code-skills-1c\.claude\skills"
$skillsTarget = Join-Path $Root ".claude\skills"
$claudeDir    = Join-Path $Root ".claude"

# 1. Инициализировать подмодуль, если он еще не выкачан (нужно для коллег)
Write-Host "Проверяем подмодули Git..."
git -C $Root submodule update --init --recursive

# 2. Создать папку .claude\, если её ещё нет
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir | Out-Null
    Write-Host "Создана папка .claude\"
}

# 3. Создать Junction (умную ссылку на папку)
if (Test-Path $skillsTarget) {
    Write-Host "Папка .claude\skills уже существует, пропускаем."
} else {
    # Эта команда связывает .claude\skills со скачанным подмодулем
    cmd /c mklink /J "$skillsTarget" "$skillsSource"
    Write-Host "Успех! Связь создана: .claude\skills -> claude-code-skills-1c\.claude\skills"
}

Write-Host "Готово. Рабочее место полностью настроено!"