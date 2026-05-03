# Petzy — Architecture & Engineering Guide

This document is the single source of truth for **how** Petzy is built. It
complements [README.md](README.md) (which covers **what** the app is and
how to run it) by explaining the layering, conventions, and extension
points contributors are expected to follow.

> TL;DR — Petzy uses a **feature-first, GetX-driven** layout. A small
> `core/` package provides cross-cutting services (network, storage,
> theming, sizing) and every vertical feature lives in its own folder
> under `lib/features/`.

---

## Table of contents

1. [High-level architecture](#high-level-architecture)
2. [Repository layout](#repository-layout)
3. [`lib/` directory map](#lib-directory-map)
4. [Feature module layout](#feature-module-layout)
5. [Application bootstrap](#application-bootstrap)
6. [State management (GetX)](#state-management-getx)
7. [Routing](#routing)
8. [Networking layer](#networking-layer)
9. [Persistence layer](#persistence-layer)
10. [Theming & design tokens](#theming--design-tokens)
11. [Responsive sizing](#responsive-sizing)
12. [Typography](#typography)
13. [Assets pipeline](#assets-pipeline)
14. [Utilities, helpers, validators, logging](#utilities-helpers-validators-logging)
15. [Disabled / future subsystems](#disabled--future-subsystems)
16. [Platform configuration](#platform-configuration)
17. [Conventions & coding standards](#conventions--coding-standards)
18. [Testing strategy](#testing-strategy)
19. [Extension recipes](#extension-recipes)

---

## High-level architecture

```
┌────────────────────────────────────────────────────────────────┐
│                         Presentation                            │
│  Widgets + GetX controllers live inside each feature module     │
└──────────────┬─────────────────────────────────────────────────┘
               │ binds via GetX (Get.put / Get.find / Bindings)
┌──────────────▼─────────────────────────────────────────────────┐
│                     Application / Core                          │
│  Controllers · NetworkCaller · StorageService · ThemeController │
└──────────────┬─────────────────────────────────────────────────┘
               │ Dio · SharedPreferences · (future) Firebase / WS
┌──────────────▼─────────────────────────────────────────────────┐
│                  Platform & external services                   │
│      REST API · Local storage · Platform channels · Assets      │
└────────────────────────────────────────────────────────────────┘
```

Guiding principles:

- **Feature isolation.** A feature module never reaches into another
  feature's files. Cross-feature collaboration flows through `core/` or
  a shared controller registered in GetX.
- **One state solution.** GetX is the only state / DI / routing system.
- **Thin UI.** Widgets render `Rx*` values through `Obx` and delegate all
  logic to controllers.
- **One HTTP door.** Every network call goes through `NetworkCaller`.
- **One storage door.** All key/value persistence goes through
  `StorageService`.
- **Design tokens everywhere.** No magic hex values, no raw font sizes,
  no raw pixel paddings in widget code.

---

## Repository layout

```
petzy_optimized/
├── android/              # Android native project
├── ios/                  # iOS native project
├── linux/  macos/  web/  windows/   # Scaffolded desktop/web targets
├── assets/
│   ├── images/           # PNG + SVG artwork
│   └── icons/            # SVG icons
├── lib/                  # Application source (see below)
├── test/                 # Flutter tests
├── analysis_options.yaml # Lint rules
├── pubspec.yaml          # Dependencies & asset declarations
└── README.md / ARCHITECTURE.md
```

## `lib/` directory map

```
lib/
├── main.dart                            # Entry point
├── app.dart                             # MyApp / GetMaterialApp shell
│
├── core/                                # Cross-cutting concerns
│   ├── core.dart                        # Barrel export
│   ├── bindings/
│   │   └── controller_binder.dart       # Initial DI bindings
│   ├── common/
│   │   ├── styles/
│   │   │   └── global_text_style.dart   # AppTextStyle helper
│   │   └── widgets/                     # Shared widgets (buttons, cards…)
│   ├── controllers/
│   │   └── theme_controller.dart        # Persistent theme mode
│   ├── localization/
│   │   └── app_localizations.dart       # (placeholder — i18n)
│   ├── models/
│   │   └── response_data.dart           # HTTP response envelope
│   ├── services/
│   │   ├── cache/storage_service.dart   # SharedPreferences wrapper
│   │   ├── firebase/                    # (disabled — FCM / notifications)
│   │   └── network/network_caller.dart  # Dio-based HTTP client
│   ├── utils/
│   │   ├── constants/                   # Colors, enums, paths, sizer, texts
│   │   ├── device/device_utility.dart   # Screen / platform helpers
│   │   ├── formatters/app_formatters.dart
│   │   ├── helpers/app_helper.dart
│   │   ├── logging/logger.dart
│   │   ├── theme/                       # AppTheme + custom_themes/
│   │   └── validators/app_validator.dart
│   ├── websoketMathod/websoket.dart     # (disabled — realtime)
│   └── datetime_formate.dart            # Relative-time formatter
│
├── features/                            # Vertical feature modules
│   ├── splash/
│   ├── authentication/
│   ├── bottom_nav/
│   ├── feed/
│   ├── reels/
│   ├── community/
│   ├── booking/
│   ├── profile/
│   ├── settings/
│   ├── guest_user/
│   └── service_providers/
│       ├── petcare_service/
│       ├── pethotel_service/
│       └── petschool_service/
│
└── routes/
    └── app_routes.dart                  # Named route table
```

## Feature module layout

Every feature folder follows the same skeleton. Create missing
subfolders only when you actually have files to put in them.

```
features/<feature_name>/
├── controllers/          # GetxController subclasses (state + logic)
├── models/               # Plain Dart models (fromJson / toJson)
├── services/             # Feature-specific API clients calling NetworkCaller
├── presentation/         # UI — screens/ and widgets/
│   ├── screens/          # Full screens (routed)
│   └── widgets/          # Widgets private to this feature
└── bindings/             # (optional) GetX Bindings for this feature
```

> **Historical note:** the existing code uses the misspelled folder name
> `presentaion/` in some modules. New modules should use `presentation/`.
> Existing folders may be renamed opportunistically — do not rename in
> the same PR as unrelated work.

Rules:

- Controllers expose **observables** (`RxT`, `Rx<T>`, `RxList<T>`) and
  pure methods. They must not touch `BuildContext`.
- Widgets only import from their own feature + `core/`. If two features
  need the same widget, lift it into `core/common/widgets/`.
- Services translate models ↔ HTTP via `NetworkCaller`. They do not
  store state.

## Application bootstrap

`main` → `MyApp` → `GetMaterialApp` → initial route `splashScreen`.

```dart
// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<ThemeController>(ThemeController(), permanent: true);
  runApp(const MyApp());
}
```

See [lib/main.dart](lib/main.dart) and [lib/app.dart](lib/app.dart).

`MyApp` wraps the tree in `Sizer`, then builds a `GetMaterialApp`:

- `initialRoute: AppRoute.splashScreen`
- `getPages: AppRoute.routes`
- `initialBinding: ControllerBinder()` — registers `SplashController`
- `themeMode` is reactive to `ThemeController`
- a custom `builder` forces `TextScaler.linear(1.0)` so system font
  scaling does not break the design

Additional service bootstrap — Firebase init, push-notification setup,
WebSocket connection, analytics — should be invoked from `main` before
`runApp`, behind feature flags where appropriate.

## State management (GetX)

Petzy uses GetX in three roles:

| Role | API | Example |
|------|-----|---------|
| State | `.obs` values + `Obx` | `final count = 0.obs;` |
| DI | `Get.put`, `Get.lazyPut`, `Get.find` | `Get.put(ThemeController(), permanent: true);` |
| Routing | `GetMaterialApp` + `GetPage` | `Get.toNamed(AppRoute.loginScreen);` |

Controller template:

```dart
class ExampleController extends GetxController {
  // State
  final isLoading = false.obs;
  final items = <Item>[].obs;

  // Deps (resolved via Get.find, constructor, or Bindings)
  final ExampleService _service;
  ExampleController(this._service);

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async {
    isLoading.value = true;
    try {
      items.value = await _service.fetchAll();
    } finally {
      isLoading.value = false;
    }
  }
}
```

Binding template — keep one `Bindings` class per feature and wire it
into its `GetPage`:

```dart
class ExampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExampleService());
    Get.lazyPut(() => ExampleController(Get.find()));
  }
}
```

Controller registration happens today in
[lib/core/bindings/controller_binder.dart](lib/core/bindings/controller_binder.dart).
Keep that file for app-wide permanent controllers; put feature
controllers in a feature-local `Bindings`.

## Routing

All routes are declared in
[lib/routes/app_routes.dart](lib/routes/app_routes.dart):

```dart
class AppRoute {
  static String loginScreen    = "/loginScreen";
  static String splashScreen   = "/splashScreen";
  static String bottomNavScreen = "/bottomNavScreen";

  static List<GetPage> routes = [
    GetPage(name: loginScreen,     page: () => const LoginScreen()),
    GetPage(name: splashScreen,    page: () => const SplashScreen()),
    GetPage(name: bottomNavScreen, page: () => const BottomNavScreen()),
  ];
}
```

Rules:

- Navigate by **name**, never by `MaterialPageRoute`.
- Add new routes here and attach a `binding:` when the screen owns a
  controller.
- Use `Get.offAllNamed` for auth flows that clear the stack,
  `Get.toNamed` for pushes, `Get.back` for pops.

## Networking layer

All HTTP traffic passes through
[lib/core/services/network/network_caller.dart](lib/core/services/network/network_caller.dart).

- Singleton `NetworkCaller` wraps `Dio`.
- 30 s connect + receive timeouts.
- Automatically attaches the bearer token from `StorageService`.
- Auto-retries once after token refresh on `401` — except for the auth
  endpoints (`/auth/login/`, `/auth/register/`, `/auth/logout/`,
  `/auth/token/refresh/`).
- Returns a uniform envelope — [ResponseData](lib/core/models/response_data.dart):

```dart
class ResponseData {
  final bool isSuccess;
  final int statusCode;
  final String errorMessage;
  final dynamic responseData;
}
```

Feature services stay thin:

```dart
class FeedService {
  final _api = NetworkCaller();
  Future<ResponseData> getFeed() => _api.get('/feed/');
  Future<ResponseData> like(String id) => _api.post('/feed/$id/like/', {});
}
```

Do not instantiate `Dio` directly. If you need a one-off third-party
request (S3 upload, etc.) add it behind a method on `NetworkCaller`.

## Persistence layer

[StorageService](lib/core/services/cache/storage_service.dart) wraps
`SharedPreferences`:

| Key | Purpose |
|-----|---------|
| `token` | Auth JWT |
| `userId` | Currently logged-in user id |

Use this service for any small, primitive, non-sensitive value. For
larger structured data (offline cache, drafts, etc.) introduce a proper
solution (Hive / sqflite / drift) behind a new service in
`core/services/`.

## Theming & design tokens

| Token | Source |
|-------|--------|
| Colours | [lib/core/utils/constants/colors.dart](lib/core/utils/constants/colors.dart) |
| Light / dark `ThemeData` | [lib/core/utils/theme/theme.dart](lib/core/utils/theme/theme.dart) |
| AppBar theme | [lib/core/utils/theme/custom_themes/app_bar_theme.dart](lib/core/utils/theme/custom_themes/app_bar_theme.dart) |
| ElevatedButton theme | [lib/core/utils/theme/custom_themes/elevated_button_theme.dart](lib/core/utils/theme/custom_themes/elevated_button_theme.dart) |
| TextField theme | [lib/core/utils/theme/custom_themes/text_field_theme.dart](lib/core/utils/theme/custom_themes/text_field_theme.dart) |
| Text theme | [lib/core/utils/theme/custom_themes/text_theme.dart](lib/core/utils/theme/custom_themes/text_theme.dart) |

Theme mode is managed by
[ThemeController](lib/core/controllers/theme_controller.dart) and
persisted in SharedPreferences. It exposes `isDarkMode` and `isSystem`
observables. Toggle with `Get.find<ThemeController>().setTheme(...)`.

Brand palette (see `AppColors`):

- Primary `#FF7176` — coral/pink
- Secondary `#282828` — near-black
- Accent `#89A7FF` — soft blue
- Semantic: success `#22C55E`, warning `#F59E0B`, error `#EF4444`,
  info `#3B82F6`

Never hard-code colours in widgets — always go through `AppColors`.

## Responsive sizing

Design canvas is **360×690** points. The helpers in
[lib/core/utils/constants/sizer.dart](lib/core/utils/constants/sizer.dart)
scale values to the current device:

| Extension | Meaning |
|-----------|---------|
| `.w` | Width in design pixels |
| `.h` | Height in design pixels |
| `.sp` | Scalable font size |
| `.r` | Corner radius / generic |
| `.rw`, `.rh`, `.rsp`, `.rr` | Device-aware responsive variants |

Breakpoints: small 360, medium 400, large 600, tablet 768, desktop 1024.

## Typography

[AppTextStyle](lib/core/common/styles/global_text_style.dart) provides
Nunito-based factories per weight × size. Rules:

- Never import `TextStyle(...)` inline in widgets — always call an
  `AppTextStyle` factory.
- Use semantic sizes (`xs`, `sm`, `md`, `lg`, `xl`, `xxl`, `title`,
  `heading`, `display`).
- Respect the forced `TextScaler.linear(1.0)` in
  [app.dart](lib/app.dart) — do not re-enable system font scaling
  globally.

## Assets pipeline

Assets are declared in [pubspec.yaml](pubspec.yaml) and referenced via
constants:

- Images: [lib/core/utils/constants/image_path.dart](lib/core/utils/constants/image_path.dart)
- Icons: [lib/core/utils/constants/icon_path.dart](lib/core/utils/constants/icon_path.dart)

Never use raw string paths in widgets — import `AppImages` / `AppIcons`
so renames stay safe.

Adding a new asset:

1. Drop the file into [assets/images/](assets/images/) or
   [assets/icons/](assets/icons/).
2. Register it in `image_path.dart` / `icon_path.dart`.
3. If the folder is new, add it under `flutter.assets` in
   [pubspec.yaml](pubspec.yaml).

## Utilities, helpers, validators, logging

| Concern | Location |
|---------|----------|
| Device / platform info | [lib/core/utils/device/device_utility.dart](lib/core/utils/device/device_utility.dart) |
| Formatting (date, currency, phone) | [lib/core/utils/formatters/app_formatters.dart](lib/core/utils/formatters/app_formatters.dart) |
| UI helpers (snackbars, dialogs, truncation) | [lib/core/utils/helpers/app_helper.dart](lib/core/utils/helpers/app_helper.dart) |
| Email / password / phone validation | [lib/core/utils/validators/app_validator.dart](lib/core/utils/validators/app_validator.dart) |
| Logging | [lib/core/utils/logging/logger.dart](lib/core/utils/logging/logger.dart) |
| Relative / absolute date | [lib/core/datetime_formate.dart](lib/core/datetime_formate.dart) |

Logger usage:

```dart
AppLoggerHelper.debug('payload=$json');
AppLoggerHelper.error('boom', error, stack);
```

Never `print` — always go through the logger so production builds can
short-circuit output.

## Disabled / future subsystems

Code that's currently commented out but intended to be re-enabled:

| Subsystem | Location | Needs |
|-----------|----------|-------|
| Firebase core + FCM | [lib/core/services/firebase/](lib/core/services/firebase/) | `firebase_core`, `firebase_messaging`, config files, `main.dart` init |
| Local / push notifications | [lib/core/services/firebase/notification_service.dart](lib/core/services/firebase/notification_service.dart) | `flutter_local_notifications` + FCM |
| WebSocket realtime | [lib/core/websoketMathod/websoket.dart](lib/core/websoketMathod/websoket.dart) | `web_socket_channel` or similar |
| Localization (i18n) | [lib/core/localization/app_localizations.dart](lib/core/localization/app_localizations.dart) | ARB files + `flutter gen-l10n` |

When enabling any of these, add the package to `pubspec.yaml`, wire it
into `main.dart` / `app.dart`, and update this document.

## Platform configuration

**Android** — [android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml)

- MainActivity uses `singleTop` launch mode and Flutter embedding v2.
- Change `applicationId` in `android/app/build.gradle` before the first
  production release.
- Add runtime permissions (camera, location, notifications) here as
  features need them.

**iOS** — [ios/Runner/Info.plist](ios/Runner/Info.plist)

- `CFBundleDisplayName` = `Petzy Optimized`.
- Bundle id is driven by `PRODUCT_BUNDLE_IDENTIFIER` in the Xcode
  project.
- Portrait + landscape are enabled for iPhone; iPad supports all four
  orientations.
- Add `NS…UsageDescription` keys here when adopting camera, photos,
  microphone, push, location, etc.

## Conventions & coding standards

### Dart / Flutter

- Keep the analyzer clean: `flutter analyze` must report **no** issues.
  The lint set lives in [analysis_options.yaml](analysis_options.yaml).
- `const` everything that can be `const`.
- File names: `snake_case.dart`. Class names: `UpperCamelCase`.
  Members: `lowerCamelCase`.
- No relative imports that cross package boundaries — use
  `package:petzy_optimized/...` for long paths.
- No hard-coded strings in production UI. Define them in
  [app_texts.dart](lib/core/utils/constants/app_texts.dart) today, move
  them into ARB files once i18n is wired up.

### Widget authoring

- Prefer `StatelessWidget` + a `GetxController` over `StatefulWidget`.
- Each public widget sits in its own file.
- Extract any `build` method longer than ~80 lines into smaller
  widgets.
- Don't pass `BuildContext` into controllers.

### Git / PRs

- Branches: `feat/<scope>`, `fix/<scope>`, `chore/<scope>`,
  `docs/<scope>`.
- Commits: imperative mood, present tense, scoped (`feat(booking):
  add cancellation flow`).
- Every PR should include: summary, screenshots for UI changes, a test
  plan, and any follow-up tasks.
- `main` is protected — merge via PR only. Never force-push.

## Testing strategy

The [test/](test/) folder is scaffolded. As features land, contributors
are expected to add:

| Layer | What to test | Tools |
|-------|--------------|-------|
| Unit | Controllers, services, validators, formatters | `flutter_test`, `mocktail` |
| Widget | Individual widgets & screens with mocked controllers | `flutter_test`, `GetX`'s test helpers |
| Integration | Smoke tests for critical flows (splash → home, login) | `integration_test` |

Every PR that adds logic should add or update at least one test.

## Extension recipes

### Add a new feature module

1. `mkdir -p lib/features/<name>/{controllers,models,services,presentation/screens,presentation/widgets,bindings}`.
2. Add a `GetxController`, a service hitting `NetworkCaller`, and a
   screen widget.
3. Create a `Bindings` class wiring them together.
4. Register a route in [lib/routes/app_routes.dart](lib/routes/app_routes.dart)
   with `binding: <Name>Binding()`.
5. Link to the feature from wherever it's reachable (bottom nav, home,
   etc.).
6. Add asset paths / colours / copy to their respective constants
   files.

### Add a new API endpoint

1. Add a method to the relevant feature service that calls
   `NetworkCaller.get/post/...`.
2. Map the JSON into a model in that feature's `models/` folder.
3. Call it from the controller, updating observables.
4. Handle `ResponseData.isSuccess == false` — surface
   `errorMessage` via a snackbar in `AppHelper`.

### Add a new persisted preference

1. Add a key and a typed getter/setter to
   [StorageService](lib/core/services/cache/storage_service.dart).
2. Never read `SharedPreferences` directly from a controller.

### Enable Firebase

1. Add `firebase_core` (and optionally `firebase_messaging`) to
   `pubspec.yaml`.
2. Run `flutterfire configure` to generate `firebase_options.dart`.
3. Uncomment [lib/core/services/firebase/](lib/core/services/firebase/)
   files and update imports.
4. Initialise in `main()` before `runApp`.
5. Add required iOS capabilities and Android `google-services.json`.

---

For anything not covered here, default to the conventions already
present in the codebase — and when in doubt, open a small PR that
updates this document alongside the change.
