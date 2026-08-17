# Patches

Unified diffs against the smali tree produced by
`apktool d SGCAM_8.5.300.XX.10_STABLE_V24.apk -o sgcam`, using apktool 2.12.0.
Paths are relative to that output directory.

| File | What it changes |
| --- | --- |
| `bju.patch` | Default mode for `ACTION_MAIN`: PHOTO → PHOTO_SPHERE |
| `gvj.patch` | Both mode lists in `ModeSwitchControllerImpl`, gated on the device/preference check |
| `gwk.patch` | "More modes" tab only created when the full interface is active |
| `CameraActivity.patch` | `Dev.init`, the first-launch dialog, and the process kill in `onStop` |
| `new/Dev.smali` | Device whitelist and preference gate (new class) |
| `new/Ask.smali` | First-launch interface dialog (new class) |

## Applying

```bash
apktool d SGCAM_8.5.300.XX.10_STABLE_V24.apk -o sgcam
cd sgcam

for p in ../patches/*.patch; do patch -p1 < "$p"; done

mkdir -p smali/sgcam/patzi
cp ../patches/new/*.smali smali/sgcam/patzi/

cd ..
apktool b sgcam -o gcam360-unsigned.apk
java -jar uber-apk-signer.jar --apks gcam360-unsigned.apk
```

## Not included as diffs

The resource changes are mechanical and would be noise as patches:

- `app_name` set to `GCam360` in `res/values/strings.xml` **and all 82 localized
  `res/values-*/strings.xml`** — the localized files override the default one,
  so patching only the default leaves the old name on most devices
- launcher icon layers in `res/mipmap-*` regenerated for both icon sets
  (`ic_launcher_*` and `adaptiveproduct_pixelcamera_*`), including the
  monochrome layer
- a `ListPreference` with key `patzicam_ui_mode` added to
  `res/xml/camera_preferences.xml` inside the "Viewfinder buttons" screen, plus
  two `string-array` entries in `res/values/arrays.xml`

## Notes on the smali

`gvj` holds two independent hardcoded mode lists: the logical `ArrayList` built
in the constructor, and the TextView registration in `e(Lhbp;)`. Patching only
the constructor produces a build that crashes during layout with
`IllegalArgumentException: attempted to activate non-existent mode
PHOTO_SPHERE`, thrown from `gwd.b()`.

The `l(Lheb;)` call in `gwk` must be kept even when the "More modes" tab is
suppressed, because it ends with `ModeSwitcher.e = true` and `setEnabled(true)`.
Removing the whole call leaves the mode switcher disabled.

The preference key is `patzicam_ui_mode` and kept that name from an earlier
build, so that existing installs don't lose their setting.
