# Build and install script for CleanYourTV launcher on Xiaomi MiTV-MOOR2
# Run this script anytime you want to re-build or re-install the launcher with custom config.xml

$sdk = (Resolve-Path "android-sdk").Path.Replace('\', '/')
"sdk.dir=$sdk" | Set-Content "launcher\local.properties"

$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"

Set-Location launcher
Write-Host "Building release APK..."
.\gradlew.bat assembleRelease --no-daemon
Set-Location ..

$apk = "launcher\app\build\outputs\apk\release\app-release.apk"
$adb = "platform-tools\adb.exe"

Write-Host "Installing to TV at 192.168.1.48:5555..."
& $adb connect 192.168.1.48:5555
& $adb -s 192.168.1.48:5555 push $apk /data/local/tmp/tvhome.apk
& $adb -s 192.168.1.48:5555 shell pm install -r /data/local/tmp/tvhome.apk
& $adb -s 192.168.1.48:5555 shell rm -f /data/local/tmp/tvhome.apk
& $adb -s 192.168.1.48:5555 shell am start -W -n com.gathin.tvhome/.MainActivity

Write-Host "Launcher installed and launched successfully!"
