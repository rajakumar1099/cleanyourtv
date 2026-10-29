# CleanYourTV Debloat & Apple TV Launcher Setup (Xiaomi MiTV-MOOR2)

Your **Xiaomi MiTV-MOOR2** (Android 11, Google TV) has been debloated and outfitted with a lightweight Apple TV-style native Leanback launcher.

---

## 1. Summary of Changes Made

### Telemetry & Analytics Disabled
- `com.miui.tv.analytics`
- `com.xiaomi.statistic`
- `com.xiaomi.tvqs.overseas`

### Ads, Promos & Content Rows Disabled
- `com.mitv.tvhome.oemtab` (OEM banner ad rows)
- `com.mitv.tvhome.michannel` (PatchWall recommendation rows)
- `com.mitv.tvhome.mitvplus` (Mi TV+ ad channels)
- `com.mitv.tvhome.atv` (PatchWall home interface)
- `com.xm.webcontent` (Xiaomi web promotion WebView)
- `com.google.android.partnersetup` (RLZ attribution trackers)

### Bloatware & Preloaded Nagware Disabled
- `fusion.android.tv.demo` (Store demo mode)
- `com.xiaomi.mitv.tvmanager` (Cleaner utility nagware)
- `com.mitv.toolhouse`
- `com.xiaomi.mitv.manualhelp` (User manual service)
- `com.xiaomo.tv.milegal`
- `android.autoinstalls.config.xiaomi.amelie`
- `com.google.android.play.games`
- `com.xiaomi.mimusic2`

### Unselected Streaming Apps Disabled
- `com.graymatrix.did` (ZEE5)
- `com.sonyliv` (SonyLIV)
- `com.mxtech.videoplayer.television` (MX Player)

### Preserved Features & Essential Apps
- **Streaming apps**: YouTube (`com.google.android.youtube.tv`), Netflix (`com.netflix.ninja`), Prime Video (`com.amazon.amazonvideo.livingroom`), Disney+ Hotstar (`in.startv.hotstar`), Sun NXT (`com.suntv.sunnxt`), NetMirror (`app.netmirror.newtv`).
- **Google Cast / Chromecast built-in**: `com.google.android.apps.mediashell`
- **Miracast / Mi Cast**: `com.xiaomi.mitv.smartshare`
- **OTA Updates**: `com.xiaomi.mitv.updateservice`
- **HDMI & Hardware Inputs**: Live TV & input switcher `com.mitv.livetv` is strictly preserved.
- **Stock Launcher Redirect**: `com.google.android.apps.tv.launcherx` and setupwraith remain enabled for remote key stability; `HomeKeyService` accessibility redirection routes all Home events cleanly to `com.gathin.tvhome`.

---

## 2. Dock & Appearance Configuration

- **Dock Layout**: 6 slots in a rounded dock band at the bottom with ambient glow.
- **Order (Left to Right)**:
  1. YouTube
  2. Netflix
  3. Prime Video
  4. Disney+ Hotstar
  5. Sun NXT
  6. NetMirror
- **Navigation**: Deterministic D-pad navigation, smooth spring highlight animation, top bar with network status, Settings, and Inputs dropdown.

---

## 3. How to Customize Dock or Wallpaper

1. Open `launcher\app\src\main\res\values\config.xml`.
2. To change the dock apps or order, edit the `<string-array name="dock_apps">` section:
   ```xml
   <string-array name="dock_apps">
       <item>com.google.android.youtube.tv</item>
       <item>com.netflix.ninja</item>
       ...
   </string-array>
   ```
3. To change columns, update `<integer name="columns">6</integer>`.
4. Rebuild and install by running:
   ```powershell
   .\build_and_install.ps1
   ```

---

## 4. How to Re-enable Any Disabled App

To re-enable any disabled package individually over ADB:
```powershell
.\platform-tools\adb.exe connect 192.168.1.48:5555
.\platform-tools\adb.exe -s 192.168.1.48:5555 shell pm enable <package.name>
```
For example, to re-enable SonyLIV:
```powershell
.\platform-tools\adb.exe -s 192.168.1.48:5555 shell pm enable com.sonyliv
```

To re-enable everything and restore the stock Google TV launcher:
```powershell
.\restore.ps1
```

---

## 5. Security Note: Turning Off Network ADB

To secure your TV and close open ports:
1. On the TV, go to: **Settings → System → Developer options**.
2. Turn **OFF** **USB debugging** (and **Network debugging / Wireless debugging** if toggled).
3. Select **Revoke USB debugging authorizations**.
