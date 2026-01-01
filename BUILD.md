# Build Guide - Thieves City

This document provides instructions for building Thieves City for different platforms.

## Prerequisites

- Godot Engine 3.2.3 or later
- Platform-specific SDKs (for mobile builds)
- Export templates installed in Godot

## Installing Export Templates

1. Open Godot Editor
2. Go to **Editor → Manage Export Templates**
3. Download and install templates for your version

Or download manually from:
https://godotengine.org/download

## Platform-Specific Builds

### Web (HTML5)

**Requirements:**
- Godot with HTML5 export template
- Web server for testing (optional)

**Build Steps:**

1. Open project in Godot:
```bash
godot3 --path /path/to/Thieves_City
```

2. Go to **Project → Export**

3. Add **HTML5** export preset

4. Configure settings:
   - **Export Path**: `builds/web/index.html`
   - **Custom HTML Shell**: (optional)
   - **Head Include**: (optional)

5. Export:
```bash
godot3 --export "HTML5" builds/web/index.html --path .
```

6. Test locally:
```bash
cd builds/web
python3 -m http.server 8000
```

7. Open browser: `http://localhost:8000`

**Deployment:**
- Upload `builds/web/` folder to web hosting
- Ensure CORS headers are properly configured
- Use HTTPS for best compatibility

---

### Android

**Requirements:**
- Android SDK
- Android NDK
- Java JDK 8 or later
- Godot Android export templates

**Setup:**

1. Install Android SDK:
```bash
sudo apt-get install android-sdk
```

2. Configure Godot:
   - Go to **Editor → Editor Settings → Export → Android**
   - Set **Android SDK Path**
   - Set **Debug Keystore** path

**Build Steps:**

1. Open **Project → Export**

2. Add **Android** export preset

3. Configure settings:
   - **Package Name**: `com.thieves.city`
   - **Version Name**: `1.0.0`
   - **Version Code**: `1`
   - **Minimum SDK**: `21`
   - **Target SDK**: `30`
   - **Permissions**: Internet, Network State

4. Export APK:
```bash
godot3 --export "Android" builds/android/ThievesCity.apk --path .
```

5. Install on device:
```bash
adb install builds/android/ThievesCity.apk
```

**Publishing:**
- Sign APK with release keystore
- Upload to Google Play Console
- Follow Play Store guidelines

---

### iOS

**Requirements:**
- macOS with Xcode
- iOS SDK
- Apple Developer Account
- Godot iOS export templates

**Build Steps:**

1. Open **Project → Export**

2. Add **iOS** export preset

3. Configure settings:
   - **App Store Team ID**: Your team ID
   - **Bundle Identifier**: `com.thieves.city`
   - **Version**: `1.0.0`
   - **Required Icons**: Add all required icon sizes

4. Export Xcode project:
```bash
godot3 --export "iOS" builds/ios/ThievesCity.xcodeproj --path .
```

5. Open in Xcode:
```bash
open builds/ios/ThievesCity.xcodeproj
```

6. Configure signing and build

**Publishing:**
- Archive in Xcode
- Upload to App Store Connect
- Submit for review

---

### Windows Desktop

**Requirements:**
- Godot Windows export template
- (Optional) NSIS for installer

**Build Steps:**

1. Open **Project → Export**

2. Add **Windows Desktop** export preset

3. Configure settings:
   - **Export Path**: `builds/windows/ThievesCity.exe`
   - **Icon**: `icon.ico`
   - **Company Name**: Your company
   - **Product Name**: Thieves City

4. Export:
```bash
godot3 --export "Windows Desktop" builds/windows/ThievesCity.exe --path .
```

**Creating Installer:**
```bash
makensis installer_script.nsi
```

**Distribution:**
- Upload to itch.io, Steam, or your website
- Include all DLL dependencies
- Test on clean Windows installation

---

### macOS

**Requirements:**
- macOS with Xcode
- Godot macOS export template
- Apple Developer Account (for signing)

**Build Steps:**

1. Open **Project → Export**

2. Add **Mac OSX** export preset

3. Configure settings:
   - **Export Path**: `builds/macos/ThievesCity.zip`
   - **Bundle Identifier**: `com.thieves.city`
   - **Icon**: `icon.icns`

4. Export:
```bash
godot3 --export "Mac OSX" builds/macos/ThievesCity.zip --path .
```

**Code Signing:**
```bash
codesign --force --deep --sign "Developer ID" ThievesCity.app
```

**Notarization:**
```bash
xcrun altool --notarize-app --file ThievesCity.zip
```

**Distribution:**
- Upload to Mac App Store or distribute directly
- Create DMG for easy installation

---

### Linux

**Requirements:**
- Godot Linux export template

**Build Steps:**

1. Open **Project → Export**

2. Add **Linux/X11** export preset

3. Configure settings:
   - **Export Path**: `builds/linux/ThievesCity.x86_64`
   - **64 Bits**: Enabled

4. Export:
```bash
godot3 --export "Linux/X11" builds/linux/ThievesCity.x86_64 --path .
```

**Creating Package:**

For Debian/Ubuntu:
```bash
dpkg-deb --build thieves-city-package
```

For Flatpak:
```bash
flatpak-builder --repo=repo build-dir com.thieves.city.json
```

**Distribution:**
- Upload to itch.io, Steam
- Submit to package repositories
- Provide AppImage for universal compatibility

---

## Automated Build Script

Create `build_all.sh`:

```bash
#!/bin/bash

PROJECT_PATH="/path/to/Thieves_City"
BUILD_DIR="builds"

# Web
godot3 --export "HTML5" "$BUILD_DIR/web/index.html" --path "$PROJECT_PATH"

# Android
godot3 --export "Android" "$BUILD_DIR/android/ThievesCity.apk" --path "$PROJECT_PATH"

# Windows
godot3 --export "Windows Desktop" "$BUILD_DIR/windows/ThievesCity.exe" --path "$PROJECT_PATH"

# macOS
godot3 --export "Mac OSX" "$BUILD_DIR/macos/ThievesCity.zip" --path "$PROJECT_PATH"

# Linux
godot3 --export "Linux/X11" "$BUILD_DIR/linux/ThievesCity.x86_64" --path "$PROJECT_PATH"

echo "All builds completed!"
```

Make executable:
```bash
chmod +x build_all.sh
./build_all.sh
```

---

## CI/CD Integration

### GitHub Actions

Create `.github/workflows/build.yml`:

```yaml
name: Build Thieves City

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Web
        uses: firebelley/godot-export@v4.1.0
        with:
          godot_executable_download_url: https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_linux_headless.64.zip
          godot_export_templates_download_url: https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_export_templates.tpz
          relative_project_path: ./
          export_preset: HTML5
      - name: Upload Artifact
        uses: actions/upload-artifact@v2
        with:
          name: web-build
          path: builds/web/
```

---

## Testing Builds

### Web
- Test in multiple browsers (Chrome, Firefox, Safari, Edge)
- Check mobile browser compatibility
- Verify WebGL support

### Android
- Test on multiple devices (phones, tablets)
- Check different Android versions
- Verify permissions and storage access

### iOS
- Test on iPhone and iPad
- Check different iOS versions
- Verify App Store compliance

### Desktop
- Test on different OS versions
- Check performance on various hardware
- Verify file permissions and save data

---

## Optimization Tips

1. **Reduce Build Size:**
   - Remove unused assets
   - Compress textures
   - Use smaller audio formats

2. **Performance:**
   - Profile on target devices
   - Optimize draw calls
   - Use object pooling

3. **Compatibility:**
   - Test on minimum spec devices
   - Provide quality settings
   - Handle different screen sizes

---

## Troubleshooting

### Build Fails
- Check export templates are installed
- Verify project settings
- Check console for errors

### App Crashes
- Check device logs
- Verify permissions
- Test on different devices

### Performance Issues
- Profile with Godot profiler
- Reduce draw calls
- Optimize scripts

---

## Resources

- [Godot Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/index.html)
- [Android Publishing Guide](https://developer.android.com/studio/publish)
- [iOS App Store Guidelines](https://developer.apple.com/app-store/guidelines/)
- [Steam Publishing](https://partner.steamgames.com/)

---

**Last Updated:** January 2, 2026
