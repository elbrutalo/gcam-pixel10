# GCam360

Photo Sphere for the Pixel 10, built from an older Google Camera port.

Google removed Photo Sphere from the stock Pixel camera. This is
`SGCAM_8.5.300.XX.10_STABLE_V24` by **Shamim**, patched to launch directly into
Photo Sphere and to hide the modes that don't work on current hardware.

**All credit for the underlying mod goes to Shamim.** This repository only
contains a small set of smali patches on top of his release. Original download:
<https://www.celsoazevedo.com/files/android/google-camera/dev-shamim/f/dl79/>

## What it does

- Opens straight into Photo Sphere (360°), no mode switching needed
- On the Pixel 10 the mode bar is reduced to a single entry, because photo and
  video are broken in this build on that device
- On devices the mod actually supports (Pixel 7a, 8, 8 Pro, Fold, Tablet and
  older) the full mode list is kept
- Either interface can be forced from *Settings → Viewfinder buttons →
  GCam360 Interface*, and is asked once on first launch
- Package name is `com.shamim.cam`, so it installs alongside the stock camera

Output is a regular JPEG with XMP panorama metadata, so Google Photos displays
it as a proper 360° image.

## Known limitations

- **Photo and video modes do not work on the Pixel 10.** This is not a camera
  replacement, it is a tool for one feature.
- The process is terminated when you leave the app. This is deliberate: with
  Photo Sphere as the only mode, the native Lightcycle engine is never torn
  down, and without the kill the viewfinder stays black on the second launch.
  The cost is roughly one extra second of startup time, and a panorama that is
  still rendering will be lost if you leave the app.
- Signed with a debug key, not with Shamim's. The `SignatureKiller` bundled in
  the original APK spoofs the platform signature, so the PairIP integrity check
  still passes.

## Install

```
adb install -r GCam360_v9.apk
```

If a differently signed copy of SGCam is already installed, uninstall it first.

## Patches applied

All changes are in smali, decoded and rebuilt with apktool 2.12.0 and signed
with uber-apk-signer 1.3.0.

### `smali/sgcam/patzi/Dev.smali` (new)

Device and preference gate. `full()` reads `patzicam_ui_mode` (the key kept its
original name across the rename) from the default SharedPreferences; on `auto` (or when no context is set yet) it falls back to
`known()`, a whitelist of the 25 Google device code names that the mod's own
`sgcam/default/DeviceCodeNames` lists.

### `smali/sgcam/patzi/Ask.smali` (new)

First-launch dialog offering automatic, full or reduced. Writes the preference
and terminates the process so the choice takes effect on the next start.

### `smali_classes2/bju.smali`

Default mode for `ACTION_MAIN` changed from `Lheb;->b` (PHOTO) to
`Lheb;->e` (PHOTO_SPHERE).

### `smali/gvj.smali` (`ModeSwitchControllerImpl`)

Two separate hardcoded mode lists had to be changed, which is easy to miss:

- the constructor builds the logical list and mapped PHOTO_SPHERE's ordinal
  through a `sparse-switch` that silently fell back to PHOTO
- `e(Lhbp;)` registers the actual TextViews via `gwq.j(mode)`

Both now branch on `Dev.full()`. If only the first is patched, the app crashes
with `IllegalArgumentException: attempted to activate non-existent mode
PHOTO_SPHERE` from `gwd.b()` during layout.

The assertion in `gvj.z(I)` is neutralised so that an `indexOf()` miss elsewhere
cannot throw.

### `smali/gwk.smali`

`l(Lheb;)` no longer creates the "More modes" tab when the interface is
reduced. The rest of the method is kept, because it ends with
`ModeSwitcher.e = true` and `setEnabled(true)`.

### `CameraActivity.smali`

`Dev.init(this)` at the top of `onCreate`, `Ask.show(this)` at the end of
`onResume`, and `Process.killProcess(myPid())` after the super call in
`onStop`.

### Resources

`app_name` set to `GCam360` in all 83 locale variants — patching only
`res/values/strings.xml` is not enough, the localized files override it.
Launcher icon layers regenerated for all five densities including the
monochrome layer for themed icons. `ListPreference` plus two string arrays
added for the interface setting.

## Building it yourself

```
apktool d SGCAM_8.5.300.XX.10_STABLE_V24.apk -o sgcam
# apply the patches described above
apktool b sgcam -o gcam360-unsigned.apk
java -jar uber-apk-signer.jar --apks gcam360-unsigned.apk
```

## License and credits

The Google Camera app is Google's. The SGCam modification is Shamim's. This
repository claims nothing beyond the patches listed above and is published for
Pixel 10 owners who want Photo Sphere back.
