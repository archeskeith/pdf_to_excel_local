import PyInstaller.__main__

PyInstaller.__main__.run([
    'install_and_run.sh',
    '--onefile',
    '--name=flask_app_installer'
])
