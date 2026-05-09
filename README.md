# Flutter GetX Template (petzy_optimized)

Opinionated Flutter starter using **GetX** for state, DI, and routing, with:

- App shell (`GetMaterialApp`) + responsive sizing (`Sizer`)
- Theming (light/dark/system) via `ThemeController`
- Connectivity monitoring + top snackbar via `InternetService` / `InternetToastListener`
- HTTP client wrapper (`Dio` via `NetworkCaller`) returning `ResponseData`
- Key/value storage wrapper (`SharedPreferences` via `StorageService`)
- Feature-first folder layout under `lib/features/`

| | |
|---|---|
| Version | `1.0.0+1` |
| Dart SDK | `^3.10.7` |
| State / DI / Routing | GetX |
| HTTP | Dio (`NetworkCaller`) |
| Storage | SharedPreferences (`StorageService`) |
| Sizing | `Sizer` + `lib/core/utils/constants/sizer.dart` |
| Platforms | Android, iOS, Web, Desktop (scaffolded) |

---

## Quick start

```bash
flutter pub get
flutter run
```

- Entry point: `lib/main.dart`
- App shell: `lib/app.dart`
- Routes table: `lib/routes/app_routes.dart`
- Initial route flow: `SplashScreen` → `BottomNavScreen`

## Project structure

```
lib/
├── main.dart                  # Boot: init ThemeController, run MyApp
├── app.dart                   # GetMaterialApp + Sizer shell
├── core/                      # Shared, cross-feature code
│   ├── bindings/              # Initial DI bindings
│   ├── common/                # Shared widgets & text styles
│   ├── controllers/           # App-wide controllers (theme)
│   ├── models/                # Shared models (ResponseData)
│   ├── json/                  # Generic JSON parsing helpers (ApiResponse, converters)
│   ├── services/              # NetworkCaller, StorageService, Firebase (off)
│   └── utils/                 # constants, theme, helpers, validators, logging
├── features/                  # One folder per feature (see rules below)
└── routes/app_routes.dart     # Named routes
```

Current features shipped in this template:

- `features/splash/` (note: currently uses `presentaion/` spelling)
- `features/bottom_nav/` (placeholder screens + controller)
- `features/authentication/` (placeholder login screen + starter models)

## Conventions (keep consistent)

1. **Feature-first.** New UI/logic goes under `lib/features/<name>/`.
2. **Avoid cross-feature imports.** Shared code goes in `lib/core/`.
3. **GetX only.** Use `.obs` + `Obx`, plus `Get.put/Get.find`, and `GetPage` routing.
4. **Thin UI.** Widgets render state; controllers hold logic.
5. **Navigate by name.** Use `Get.toNamed(AppRoute.xxx)` and register routes in `lib/routes/app_routes.dart`.
6. **One HTTP door.** Use `NetworkCaller` (`lib/core/services/network/network_caller.dart`).
7. **One storage door.** Use `StorageService` (`lib/core/services/cache/storage_service.dart`).
8. **Use design tokens.** Colors/styles/assets should come from `lib/core/utils/constants/*` and `lib/core/common/styles/*`.

## How to add a new feature (template)

Create a feature skeleton:

```
lib/features/<name>/
├── controllers/
├── models/
├── services/
├── presentation/
│   ├── screens/
│   └── widgets/
└── bindings/        # optional
```

Then:

- Add a `GetPage(...)` route in `lib/routes/app_routes.dart`
- Register dependencies in a feature `Bindings`, or in `lib/core/bindings/controller_binder.dart` if it must be permanent

## Useful commands

```bash
flutter pub get           # install deps
flutter analyze           # lint (recommended)
flutter test              # tests
flutter run               # run on attached device
flutter build apk         # Android APK
flutter build appbundle   # Android AAB
flutter build ipa         # iOS release
```

## Further reading

- `ARCHITECTURE.md` — architecture deep-dive and extension recipes
- Flutter docs: <https://docs.flutter.dev>
- GetX docs: <https://pub.dev/packages/get>
