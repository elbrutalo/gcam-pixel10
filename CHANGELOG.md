# Changelog

## v9

- Renamed to GCam360 (was Patzicam). The preference key `patzicam_ui_mode` was
  deliberately left unchanged so existing installs keep their setting.

## v8

- Interface can now be chosen: a dialog on first launch, and a `ListPreference`
  under *Viewfinder buttons → GCam360 Interface*.
- The device whitelist moved from `full()` to `known()` and is now only the
  fallback for the automatic setting.

## v7

- Device-dependent interface: full mode list on devices SGCam knows,
  Photo Sphere only on everything else.

## v6

- New launcher icon, regenerated for all densities including the monochrome
  layer for themed icons.

## v5

- "More modes" tab removed from the mode bar.

## v4

- Fixed a black viewfinder on the second launch by terminating the process in
  `onStop`. With Photo Sphere as the only mode the native Lightcycle engine is
  never torn down, so a warm start hits its own stale state.

## v3

- App name applied to all 83 locale variants, not just the default one.

## v2

- Fixed a crash on launch: the mode had to be registered in both of `gvj`'s
  hardcoded lists, not just the logical one.

## v1

- First build. Launches directly into Photo Sphere, reduced mode bar.
