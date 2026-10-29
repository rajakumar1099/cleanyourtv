# Restore script for Xiaomi MiTV-MOOR2
# Run this script to re-enable all packages disabled during debloat

$packages = @(
    "com.miui.tv.analytics",
    "com.xiaomi.statistic",
    "com.xiaomi.tvqs.overseas",
    "com.mitv.tvhome.oemtab",
    "com.mitv.tvhome.michannel",
    "com.mitv.tvhome.mitvplus",
    "com.mitv.tvhome.atv",
    "com.xm.webcontent",
    "com.google.android.partnersetup",
    "fusion.android.tv.demo",
    "com.xiaomi.mitv.tvmanager",
    "com.mitv.toolhouse",
    "com.xiaomi.mitv.manualhelp",
    "com.xiaomo.tv.milegal",
    "android.autoinstalls.config.xiaomi.amelie",
    "com.google.android.play.games",
    "com.xiaomi.mimusic2",
    "com.graymatrix.did",
    "com.sonyliv",
    "com.mxtech.videoplayer.television"
)

$adb = "platform-tools\adb.exe"
if (-not (Test-Path $adb)) { $adb = "adb" }

Write-Host "Reconnecting to TV at 192.168.1.48:5555..."
& $adb connect 192.168.1.48:5555

foreach ($pkg in $packages) {
    Write-Host "Enabling $pkg..."
    & $adb -s 192.168.1.48:5555 shell pm enable $pkg
}

Write-Host "Restoring default stock Google TV launcher..."
& $adb -s 192.168.1.48:5555 shell cmd package set-home-activity --user 0 com.google.android.apps.tv.launcherx/.home.HomeActivity

Write-Host "Restore complete! Current disabled packages:"
& $adb -s 192.168.1.48:5555 shell pm list packages -d
