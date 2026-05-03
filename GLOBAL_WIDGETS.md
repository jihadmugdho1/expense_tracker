# Petzy — Global Widgets Documentation

> **All 32 files inside** `lib/core/common/global_widgets/`
>
> This document is the single source of truth for every reusable widget in the project.  
> New team members must read this before building any screen. Every widget's file path, purpose, internal structure, parameters, and usage examples are documented here.

---

## Folder Structure

```
lib/core/common/global_widgets/
├── appbar/
│   ├── header.dart                          → ProAppBar
│   └── home_header.dart                     → ProHomeHeader
├── common_button/
│   ├── common_button.dart                   → ProElevatedButton
│   └── small_button/
│       └── small_button.dart               → IconTextButton
├── create_post_bar/
│   └── create_post_bar.dart                → CreatePostBar
├── filter_service/
│   └── filter_service.dart                 → FilterService + FilterResult
├── floating_msg/
│   └── floating_msg.dart                   → FloatingChatButton
├── friend_section_card/
│   └── people_card.dart                    → FriendCard
├── info_card/
│   └── info_card.dart                      → InfoCard
├── loading_indicator/
│   └── indicators.dart                     → Indicators
├── network_error/
│   └── internet_lost.dart                  → InternetLost
├── payment_sheet/
│   └── common_paymentsheet.dart            → (placeholder — not yet implemented)
├── pet_profile_card/
│   └── pet_profile_card.dart               → PetProfileCard
├── photo_grid_tab/
│   └── photo_grid_tab.dart                 → PhotoGridTab + PhotoItem
├── post_card/
│   ├── postcard.dart                       → PostCard
│   ├── product_card.dart                   → ProductCard
│   ├── three_dot_dialog.dart               → PostOptionsDialog
│   └── post_like_bottom_sheet.dart         → LikesBottomSheet
├── quick_button/
│   └── quick_button.dart                   → QuickButton
├── searchbar/
│   └── searchbar.dart                      → ProSearchBar
├── service_card/
│   └── global_servicecard.dart             → ServiceCard
├── service_details_screen/
│   └── service_details_screen.dart         → (placeholder — not yet implemented)
├── service_get_card/
│   └── service_get_card.dart               → BookingCard
├── service_see_all/
│   └── service_see_all.dart                → ServiceSeeAll
├── shorts_card_main/
│   ├── shorts_card_first/
│   │   └── shorts_card_first.dart          → AddShortsCard
│   ├── shorts_card_second/
│   │   └── shorts_card_second.dart         → ShortsCard
│   └── shorts_card_third/
│       └── shorts_card_third.dart          → (placeholder — not yet implemented)
├── special_card_service/
│   └── special_card_service.dart           → SpecialCard
├── special_services/
│   └── special_services.dart               → SpecialServices
├── tabbar/
│   ├── filter_tabbar.dart                  → FilterButtonGroup
│   └── underline_tabbar.dart              → UnderlineTabBar
└── text_field/
    └── reuseable_text_field.dart           → ProTextField
```

---

## Table of Contents

1. [ProAppBar](#1-proappbar)
2. [ProHomeHeader](#2-prohomeheader)
3. [ProElevatedButton](#3-proelevatedbutton)
4. [IconTextButton](#4-icontextbutton)
5. [ProSearchBar](#5-prosearchbar)
6. [ProTextField](#6-protextfield)
7. [CreatePostBar](#7-createpostbar)
8. [ServiceCard](#8-servicecard)
9. [PostCard](#9-postcard)
10. [ProductCard](#10-productcard)
11. [BookingCard](#11-bookingcard)
12. [SpecialCard](#12-specialcard)
13. [SpecialServices](#13-specialservices)
14. [PetProfileCard](#14-petprofilecard)
15. [FriendCard](#15-friendcard)
16. [InfoCard](#16-infocard)
17. [FilterButtonGroup](#17-filterbuttongroup)
18. [UnderlineTabBar](#18-underlinetabbar)
19. [FilterService + FilterResult](#19-filterservice--filterresult)
20. [QuickButton](#20-quickbutton)
21. [AddShortsCard](#21-addshortscard)
22. [ShortsCard](#22-shortscard)
23. [PhotoGridTab + PhotoItem](#23-photogridtab--photoitem)
24. [PostOptionsDialog](#24-postoptionsdialog)
25. [LikesBottomSheet](#25-likesbottomsheet)
26. [FloatingChatButton](#26-floatingchatbutton)
27. [InternetLost](#27-internetlost)
28. [Indicators](#28-indicators)
29. [ServiceSeeAll](#29-serviceseeall)
30. [Placeholder Files (not yet implemented)](#30-placeholder-files-not-yet-implemented)
31. [AppTextStyle — Typography System](#31-apptextstyle--typography-system)
32. [All Enums](#32-all-enums)

---

## 1. ProAppBar

**File:** `lib/core/common/global_widgets/appbar/header.dart`  
**Class:** `ProAppBar`  
**Implements:** `PreferredSizeWidget` → place directly in `Scaffold(appBar: ...)`

### What it does
Standard app bar for every inner screen of the app. Handles the back button, screen title, optional custom title widget, and right-side action buttons — all in one place so every screen looks consistent.

### How it is built internally
- Wraps Flutter's native `AppBar`
- `automaticallyImplyLeading: false` so the back button is fully controlled by `showBackButton`
- When `showBackButton: true`, renders an `IconButton(Icons.arrow_back)`
- `onBackPressed` defaults to `Navigator.pop(context)` automatically — you do not need to provide it unless you need custom navigation (e.g. GetX `Get.back()`)
- Title is either `titleWidget` (any custom widget) or a plain `Text` styled with `AppTextStyle.semiBoldTextStyle(fontSize: AppTextStyle.xxl)`
- `preferredSize` returns `Size.fromHeight(kToolbarHeight)` so Flutter knows its height

### Parameters

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `title` | `String?` | `null` | No | Plain text title. Ignored when `titleWidget` is also set. |
| `titleWidget` | `Widget?` | `null` | No | Replaces the text title with any custom widget. |
| `centerTitle` | `bool` | `true` | No | Centers the title. |
| `showBackButton` | `bool` | `true` | No | Shows or hides the back arrow. Set `false` on root/tab screens. |
| `onBackPressed` | `VoidCallback?` | `null` | No | Custom back handler. If omitted, `Navigator.pop(context)` is called. |
| `actions` | `List<Widget>?` | `null` | No | Widgets placed at the right end of the bar. |
| `backgroundColor` | `Color?` | `AppColors.background(context)` | No | App bar background. |
| `foregroundColor` | `Color?` | `AppColors.textPrimary(context)` | No | Color applied to back icon and default title text. |
| `elevation` | `double` | `0` | No | Drop shadow depth. |

### Usage Examples

**Basic — screen with back button:**
```dart
Scaffold(
  appBar: ProAppBar(
    title: 'My Bookings',
  ),
  body: ...,
)
```

**No back button — root or tab screen:**
```dart
appBar: ProAppBar(
  title: 'Settings',
  showBackButton: false,
),
```

**Custom back action (GetX):**
```dart
appBar: ProAppBar(
  title: 'Booking Details',
  onBackPressed: () => Get.back(),
),
```

**With right-side action buttons:**
```dart
appBar: ProAppBar(
  title: 'Notifications',
  actions: [
    IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: _openFilter,
    ),
  ],
),
```

**Custom title widget (e.g. logo):**
```dart
appBar: ProAppBar(
  titleWidget: Image.asset('assets/logo.png', height: 28),
  showBackButton: false,
),
```

**Where it is used:** Settings, Notifications, Booking, Pet Market, Pet School, Pet Care, Create Post — every inner screen (20+ screens).

---

## 2. ProHomeHeader

**File:** `lib/core/common/global_widgets/appbar/home_header.dart`  
**Class:** `ProHomeHeader`  
**Implements:** `PreferredSizeWidget`

### What it does
The specialized app bar only for the Home screen. The right side changes depending on whether the current user is a guest or a logged-in user.

- **Guest:** shows a compact `Login` button (`IconTextButton`)
- **Logged-in:** shows a scan icon (`LucideIcons.scanLine`) and a notification bell (`Iconsax.notification`) with a small red dot badge

### How it is built internally
- Uses Flutter's `AppBar` with `automaticallyImplyLeading: false`
- Left: `IconButton(Icons.menu)` for the hamburger/drawer
- Centre: `Expanded` containing a `ProSearchBar`
- Right: conditional — `isGuest == true` renders `IconTextButton(text: 'Login')`, otherwise renders `_buildActions()` with scan + notification icons
- Notification badge is a `Positioned` red dot (8×8 px `BoxDecoration(shape: BoxShape.circle)`) overlaid on the notification icon
- `preferredSize` returns `Size.fromHeight(kToolbarHeight)`

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `isGuest` | `bool` | **Yes** | `true` → show Login button. `false` → show scan + notification. |
| `controller` | `TextEditingController?` | No | Controller wired to the centre search bar. |
| `onMenuTap` | `VoidCallback?` | No | Hamburger menu tap. |
| `onLoginTap` | `VoidCallback?` | No | Login button tap (guest only — currently wired to empty `() {}`, must be set). |
| `onScanTap` | `VoidCallback?` | No | Scan icon tap (logged-in only). |
| `onNotificationTap` | `VoidCallback?` | No | Notification bell tap (logged-in only). |

### Usage Examples

**Guest user:**
```dart
Scaffold(
  appBar: ProHomeHeader(
    isGuest: true,
    controller: _searchController,
    onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
    onLoginTap: () => Get.to(() => LoginScreen()),
  ),
  body: ...,
)
```

**Logged-in user:**
```dart
Scaffold(
  appBar: ProHomeHeader(
    isGuest: false,
    controller: _searchController,
    onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
    onScanTap: () => Get.to(() => ScanScreen()),
    onNotificationTap: () => Get.to(() => NotificationScreen()),
  ),
  body: ...,
)
```

**Where it is used:** Home screen only.

---

## 3. ProElevatedButton

**File:** `lib/core/common/global_widgets/common_button/common_button.dart`  
**Class:** `ProElevatedButton`

### What it does
The primary action button for the entire app. Supports text labels, leading/trailing icons, loading spinner, disabled state, solid color, and gradient backgrounds — all from one widget.

### How it is built internally
- `SizedBox(width, height)` wrapping an `ElevatedButton`
- Inside the button: an `Ink` widget that paints the gradient decoration
- Content is determined by priority:
  1. `isLoading == true` → shows a 22×22 `CircularProgressIndicator`
  2. `child != null` → renders `child` directly
  3. Otherwise → builds a `Row` with optional `leadingIcon` + `text` + `trailingIcon`
- When `isDisabled || isLoading` → `onPressed` is set to `null` (Flutter automatically styles as disabled)
- Button is full-width by default (`width: double.infinity`)

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String?` | `null` | Button label. |
| `child` | `Widget?` | `null` | Fully custom content. Overrides `text` and icons when set. |
| `leadingIcon` | `IconData?` | `null` | Icon shown left of the text. |
| `trailingIcon` | `IconData?` | `null` | Icon shown right of the text. |
| `iconSize` | `double?` | `20` | Size of leading/trailing icons. |
| `fontWeight` | `double?` | `null` | Label font weight as a number (e.g. `700`). |
| `isLoading` | `bool` | `false` | Shows a spinner and disables the button. |
| `isDisabled` | `bool` | `false` | Disables the button without a spinner. |
| `backgroundColor` | `Color?` | `AppColors.primary` | Solid background. Visually overridden when `gradient` is set. |
| `foregroundColor` | `Color?` | `null` | ElevatedButton foreground color. |
| `textColor` | `Color?` | `AppColors.white` | Label text color. |
| `iconColor` | `Color?` | Same as `textColor` | Icon color. |
| `gradient` | `Gradient?` | `null` | Gradient fill. Overrides `backgroundColor` visually. |
| `border` | `BorderSide?` | `null` | Outline border. |
| `width` | `double?` | `double.infinity` | Button width. |
| `height` | `double` | `55` | Button height. |
| `borderRadius` | `double` | `12` | Corner radius. |
| `padding` | `EdgeInsetsGeometry` | `symmetric(horizontal:16)` | Inner padding. |
| `fontSize` | `double?` | `AppTextStyle.lg` | Label font size. |
| `textStyle` | `TextStyle?` | `null` | Fully custom text style; overrides `fontSize` and `textColor`. |
| `onPressed` | `VoidCallback?` | `null` | Tap callback. |

### Usage Examples

**Simple submit button:**
```dart
ProElevatedButton(
  text: 'Book Now',
  onPressed: () => _book(),
)
```

**Loading while API call is in progress:**
```dart
ProElevatedButton(
  text: 'Submit',
  isLoading: _isLoading,
  onPressed: _submit,
)
```

**Disabled until form is valid:**
```dart
ProElevatedButton(
  text: 'Continue',
  isDisabled: !_formIsValid,
  onPressed: _continue,
)
```

**With leading icon:**
```dart
ProElevatedButton(
  text: 'Upload Photo',
  leadingIcon: Icons.photo_camera,
  onPressed: _pickPhoto,
)
```

**Gradient background:**
```dart
ProElevatedButton(
  text: 'Get Started',
  gradient: const LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF3B37A3)],
  ),
  onPressed: _start,
)
```

**Outlined / transparent style:**
```dart
ProElevatedButton(
  text: 'Cancel',
  backgroundColor: Colors.transparent,
  textColor: AppColors.primary,
  border: const BorderSide(color: AppColors.primary),
  onPressed: _cancel,
)
```

**Fixed small width:**
```dart
ProElevatedButton(
  text: 'Pay',
  width: 120,
  height: 44,
  onPressed: _pay,
)
```

**Where it is used:** All booking screens, guest user screen, create post screen, filter apply button, any form submit.

---

## 4. IconTextButton

**File:** `lib/core/common/global_widgets/common_button/small_button/small_button.dart`  
**Class:** `IconTextButton`

### What it does
A small compact button that can show an icon, a text label, or both. Used in headers, cards, and anywhere a mini action chip is needed. Default size is 100×32.

### How it is built internally
- `SizedBox(width, height)` wrapping a `TextButton`
- Renders a `Row(mainAxisAlignment: center)` with optional `Icon` and `Text`
- Font weight is accepted as a `double` (e.g. `700`) and converted to `FontWeight` enum internally via `_resolveFontWeight()`
- Border is shown only when `borderColor` or `borderWidth` is provided

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `icon` | `IconData?` | `null` | Icon to show. |
| `text` | `String?` | `null` | Label text. |
| `onTap` | `VoidCallback?` | `null` | Tap handler. |
| `textColor` | `Color?` | `AppColors.white` | Text color. |
| `iconColor` | `Color?` | `AppColors.white` | Icon color. |
| `backgroundColor` | `Color?` | `AppColors.primary` | Button fill color. |
| `borderColor` | `Color?` | `null` | Shows a border when set. |
| `borderWidth` | `double?` | `1` | Border stroke width. |
| `borderRadius` | `double?` | `8` | Corner radius. |
| `height` | `double?` | `32` | Button height. |
| `width` | `double?` | `100` | Button width. |
| `iconSize` | `double?` | `16` | Icon size. |
| `fontSize` | `double?` | `10` | Text font size. |
| `fontWeight` | `double?` | `null` | Font weight as number: `400`, `600`, `700`, etc. |
| `iconWeight` | `double?` | `null` | Material Symbols icon weight. |
| `padding` | `EdgeInsetsGeometry?` | `symmetric(vertical:6)` | Inner padding. |

### Usage Examples

**Text only (Login chip in home header):**
```dart
IconTextButton(
  text: 'Login',
  onTap: () => Get.to(() => LoginScreen()),
)
```

**Icon + text:**
```dart
IconTextButton(
  icon: Icons.add,
  text: 'Add',
  onTap: _addItem,
)
```

**Icon only:**
```dart
IconTextButton(
  icon: Icons.share,
  width: 36,
  backgroundColor: Colors.transparent,
  iconColor: AppColors.primary,
  onTap: _share,
)
```

**Outlined style (View button in InfoCard):**
```dart
IconTextButton(
  text: 'View',
  backgroundColor: Colors.transparent,
  textColor: AppColors.primary,
  borderColor: AppColors.primary,
  onTap: _view,
)
```

**Where it is used:** `ProHomeHeader` (Login chip), `InfoCard` (View button), any inline action chip.

---

## 5. ProSearchBar

**File:** `lib/core/common/global_widgets/searchbar/searchbar.dart`  
**Class:** `ProSearchBar`

### What it does
A styled search input field with a search icon prefix and a live auto-clear (×) button that appears automatically when the user types text. Supports read-only tap-to-navigate mode for screens that open a dedicated search page on tap.

### How it is built internally
- `ClipRRect` + `Container` gives the rounded background without an outline border
- Inside: a `TextField` (not `TextFormField`) with `LucideIcons.search` as default prefix
- The clear button is built using `ValueListenableBuilder<TextEditingValue>` watching the controller — it only renders when `controller.text.isNotEmpty`
- When `enableBorder: true`, `OutlineInputBorder` is applied to all three border states (enabled, focused, default); when `false` (default) `InputBorder.none` is used
- `readOnly: true` prevents the keyboard from opening — pair with `onTap` to navigate to a search screen

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `controller` | `TextEditingController?` | `null` | Wires to the field. Clear button only works when this is provided. |
| `hintText` | `String` | `"Search..."` | Placeholder text. |
| `onChanged` | `ValueChanged<String>?` | `null` | Called on every keystroke. |
| `onTap` | `VoidCallback?` | `null` | Called when the field is tapped. |
| `onClear` | `VoidCallback?` | `null` | Called when × is tapped. Falls back to `controller.clear()`. |
| `prefixIcon` | `Widget?` | `LucideIcons.search` | Replaces the default search icon. |
| `suffixIcon` | `Widget?` | Auto-clear × | Replaces the entire suffix logic. |
| `fillColor` | `Color?` | `AppColors.lightSurfaceVariant` | Background fill. |
| `borderColor` | `Color?` | `AppColors.border(context)` | Border color (only visible when `enableBorder: true`). |
| `borderRadius` | `double` | `10` | Corner radius. |
| `readOnly` | `bool` | `false` | When `true` keyboard won't open; use `onTap` to navigate. |
| `enableBorder` | `bool` | `false` | Shows an outline border around the field. |

### Usage Examples

**Live search — filter list as user types:**
```dart
ProSearchBar(
  controller: _searchController,
  hintText: 'Search services...',
  onChanged: (query) => setState(() => _filterList(query)),
)
```

**Read-only — tap opens a search screen:**
```dart
ProSearchBar(
  hintText: 'Search...',
  readOnly: true,
  onTap: () => Get.to(() => SearchScreen()),
)
```

**With visible outline border:**
```dart
ProSearchBar(
  controller: _ctrl,
  hintText: 'Find a pet',
  enableBorder: true,
  borderColor: AppColors.primary,
)
```

**Custom clear logic:**
```dart
ProSearchBar(
  controller: _ctrl,
  onClear: () {
    _ctrl.clear();
    setState(() => _resetResults());
  },
)
```

**Where it is used:** `ProHomeHeader`, `ServiceSeeAll`, Pet Market, Pet School, Pet Care, Create Post tag sheets.

---

## 6. ProTextField

**File:** `lib/core/common/global_widgets/text_field/reuseable_text_field.dart`  
**Class:** `ProTextField`

### What it does
A form-ready text input wrapping Flutter's `TextFormField`. Use this inside a `Form` widget whenever you need validation. Supports password mode, multi-line, custom icons, and read-only state.

### How it is built internally
- Builds an `OutlineInputBorder` from `borderRadius` and `borderColor` and applies it to `border`, `enabledBorder`, and `focusedBorder`
- When `obscureText: true`, `maxLines` is forced to `1` regardless of what is passed
- `filled: true` + `fillColor` gives the background color

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `controller` | `TextEditingController?` | `null` | Input controller. |
| `hintText` | `String?` | `"Enter text"` | Placeholder. |
| `labelText` | `String?` | `null` | Floating label above the field. |
| `obscureText` | `bool?` | `false` | Hides input — use for passwords. Forces `maxLines: 1`. |
| `readOnly` | `bool?` | `false` | Field cannot be edited. |
| `maxLines` | `int?` | `1` | Number of visible lines. Ignored when `obscureText: true`. |
| `prefixIcon` | `Widget?` | `null` | Widget inside the left side. |
| `suffixIcon` | `Widget?` | `null` | Widget inside the right side (e.g. password eye toggle). |
| `keyboardType` | `TextInputType?` | `null` | `email`, `number`, `phone`, etc. |
| `validator` | `String? Function(String?)?` | `null` | Validation function used by `Form`. |
| `onChanged` | `void Function(String)?` | `null` | Called on every character change. |
| `onTap` | `VoidCallback?` | `null` | Called when tapped. |
| `fillColor` | `Color?` | `AppColors.background(context)` | Background color. |
| `borderColor` | `Color?` | `AppColors.border(context)` | Border + focus border color. |
| `borderRadius` | `double?` | `12` | Corner radius. |

### Usage Examples

**Email field inside a Form:**
```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      ProTextField(
        controller: _emailCtrl,
        labelText: 'Email',
        hintText: 'Enter your email',
        keyboardType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.email_outlined),
        validator: (v) => v!.isEmpty ? 'Email is required' : null,
      ),
      ProElevatedButton(
        text: 'Submit',
        onPressed: () {
          if (_formKey.currentState!.validate()) _submit();
        },
      ),
    ],
  ),
)
```

**Password field with visibility toggle:**
```dart
StatefulBuilder(
  builder: (context, setState) {
    bool hide = true;
    return ProTextField(
      controller: _passCtrl,
      hintText: 'Password',
      obscureText: hide,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(hide ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => hide = !hide),
      ),
    );
  },
)
```

**Multi-line notes field:**
```dart
ProTextField(
  controller: _notesCtrl,
  hintText: 'Add notes...',
  maxLines: 5,
)
```

**Read-only display field:**
```dart
ProTextField(
  controller: _displayCtrl,
  labelText: 'Booking ID',
  readOnly: true,
)
```

**Where it is used:** Messaging screen, any form screen (login, registration, booking forms).

---

## 7. CreatePostBar

**File:** `lib/core/common/global_widgets/create_post_bar/create_post_bar.dart`  
**Class:** `CreatePostBar`

### What it does
The composition row shown at the top of the home feed. Shows the current user's avatar on the left, a tappable "What's on your mind?" text area in the centre, and a photo library icon on the right.

### How it is built internally
- Horizontal `Row` with three children: `CircleAvatar`, `Expanded(TextField)`, `IconButton`
- The `TextField` has `enabled: onTap == null` — when `onTap` is provided the field itself is disabled (read-only) and the entire row navigates to a create post screen instead of opening the keyboard inline
- Falls back to a person-icon placeholder avatar when `avatarUrl` is null

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `avatarUrl` | `String?` | `null` | Network URL of the user's profile photo. Shows a person icon when null. |
| `hintText` | `String` | `"What's on your mind?"` | Placeholder in the text area. |
| `onTap` | `VoidCallback?` | `null` | Called when the text area is tapped. Usually navigates to `CreatePostScreen`. |
| `onPhotoTap` | `VoidCallback?` | `null` | Called when the photo icon is tapped. |
| `fillColor` | `Color?` | `Colors.grey[200]` | Background color of the text area. |
| `photoIconColor` | `Color?` | `Colors.green` | Color of the photo library icon. |

### Usage

```dart
CreatePostBar(
  avatarUrl: currentUser.profileImage,
  onTap: () => Get.to(() => CreatePostScreen()),
  onPhotoTap: () => _pickImageAndNavigate(),
)
```

**Where it is used:** Home feed screen.

---

## 8. ServiceCard

**File:** `lib/core/common/global_widgets/service_card/global_servicecard.dart`  
**Class:** `ServiceCard`

### What it does
A vertical card displaying a service listing — hotel, course, pet care slot, etc. Fixed width at 45% of the screen width. Shows a network image with a semi-transparent rating badge (top-left) and heart/favorite icon (top-right), then title, location, and price below.

### How it is built internally
- `GestureDetector` → `SizedBox(width: 0.45 * AppSizer.width)` → `Column`
- Image section is a `Stack` with the image, rating badge, and favorite button as `Positioned` overlays
- Facility row (beds / baths / pets) only renders when at least one of those fields is non-null
- Price is formatted as `$248` using `toStringAsFixed(0)`
- `productAmount` (e.g. `"/night"`) is shown beside the price when provided

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `imageUrl` | `String?` | **Yes** | Network URL of the service photo. |
| `rating` | `double?` | **Yes** | Shown as `★ 4.9` on the image. |
| `title` | `String?` | **Yes** | Service name. Truncated to 1 line. |
| `location` | `String?` | **Yes** | Location or instructor name. Truncated to 1 line. |
| `price` | `double?` | **Yes** | Price shown as `$248`. |
| `onTap` | `VoidCallback?` | **Yes** | Called when the card is tapped. |
| `productAmount` | `String?` | No | Label beside price (e.g. `"/night"`, `"/class"`). |
| `onFavorite` | `VoidCallback?` | No | Called when the heart icon is tapped. |
| `beds` | `int?` | No | Bed count shown with bed icon. |
| `baths` | `int?` | No | Bath count shown with shower icon. |
| `pets` | `int?` | No | Pet capacity shown with paw icon. |

### Usage Examples

**Hotel card (with facilities row):**
```dart
ServiceCard(
  imageUrl: hotel.imageUrl,
  rating: hotel.rating,
  title: hotel.name,
  location: hotel.address,
  price: hotel.pricePerNight,
  productAmount: '/night',
  beds: hotel.beds,
  baths: hotel.baths,
  pets: hotel.petCapacity,
  onTap: () => Get.to(() => HotelDetailScreen(id: hotel.id)),
  onFavorite: () => _toggleFavorite(hotel.id),
)
```

**Course card (no facilities row):**
```dart
ServiceCard(
  imageUrl: course.thumbnail,
  rating: course.rating,
  title: course.title,
  location: course.instructorName,
  price: course.price,
  onTap: () => Get.to(() => CourseDetailScreen(id: course.id)),
)
```

**Inside a horizontal ListView:**
```dart
SizedBox(
  height: 260,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: services.length,
    itemBuilder: (context, i) => ServiceCard(
      imageUrl: services[i]['imageUrl'],
      rating: services[i]['rating'],
      title: services[i]['title'],
      location: services[i]['location'],
      price: services[i]['price'],
      onTap: () {},
    ),
  ),
)
```

**Where it is used:** Pet Market, Pet School, Pet Care, `ServiceSeeAll`, `SpecialServices`, Create Post tag products.

---

## 9. PostCard

**File:** `lib/core/common/global_widgets/post_card/postcard.dart`  
**Class:** `PostCard`

### What it does
A complete social media post card. Displays the author header, caption, post body with hashtags, an optional full-width image, an optional embedded product widget, engagement counts, and four SVG action buttons (like, comment, share, save).

### How it is built internally — internal sections

| Private method | What it renders |
|----------------|----------------|
| `_header()` | `CircleAvatar` + name + optional location + timestamp + `IconButton(more_vert)` that opens `PostOptionsDialog` |
| `caption` (inline) | Shown directly below header if `caption != null` |
| `_text()` | Post body text + hashtag `Wrap` in accent color |
| `_image()` | Full-width `Image.network` at 34% of screen height |
| `productWidget` (inline) | Any widget embedded between image and counts |
| `_counts()` | Tappable likes text (opens `LikesBottomSheet`) + `"X comments • Y shares"` text |
| `_actions()` | SVG icon row: like / comment / share on left, save on right |

The avatar supports both network URLs (`http://...`) and local asset paths — checked via `startsWith('http')`.

### Parameters

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `userName` | `String` | — | **Yes** | Post author's display name. |
| `userAvatar` | `String` | — | **Yes** | Avatar URL (`http://`) or asset path. |
| `timeAgo` | `String` | — | **Yes** | Human-readable timestamp (e.g. `"2 hours ago"`). |
| `location` | `String?` | `null` | No | Location tag below the name. |
| `caption` | `String?` | `null` | No | Short caption below the header. |
| `postText` | `String?` | `null` | No | Main post body text. |
| `hashtags` | `List<String>` | `[]` | No | Hashtag strings (e.g. `["#dogs", "#petcare"]`). |
| `imageUrl` | `String?` | `null` | No | Network image for the post. |
| `productWidget` | `Widget?` | `null` | No | Embed any widget inside the post (e.g. `ProductCard`). |
| `likes` | `int` | `0` | No | Like count. Tapping opens `LikesBottomSheet`. |
| `comments` | `int` | `0` | No | Comment count. |
| `shares` | `int` | `0` | No | Share count. |
| `save` | `int` | `0` | No | Save count. |
| `onLike` | `VoidCallback?` | `null` | No | Like button tap. |
| `onComment` | `VoidCallback?` | `null` | No | Comment button tap. |
| `onShare` | `VoidCallback?` | `null` | No | Share button tap. |
| `onSave` | `VoidCallback?` | `null` | No | Save button tap. |
| `path` | `String?` | `null` | No | Reserved for routing. |

### Usage Examples

**Standard post with image:**
```dart
PostCard(
  userName: post.authorName,
  userAvatar: post.authorAvatar,
  timeAgo: post.timeAgo,
  location: post.location,
  caption: post.caption,
  postText: post.body,
  hashtags: post.tags,
  imageUrl: post.imageUrl,
  likes: post.likes,
  comments: post.comments,
  shares: post.shares,
  save: post.saves,
  onLike: () => _like(post.id),
  onComment: () => _openComments(post.id),
  onShare: () => _share(post),
  onSave: () => _save(post.id),
)
```

**Post with embedded product widget:**
```dart
PostCard(
  userName: post.authorName,
  userAvatar: post.authorAvatar,
  timeAgo: post.timeAgo,
  likes: post.likes,
  comments: post.comments,
  shares: post.shares,
  save: post.saves,
  productWidget: ProductCard(
    title: product.name,
    location: product.location,
    rating: product.rating,
    reviews: product.reviewCount,
    price: product.price,
    oldPrice: product.oldPrice,
    image: product.imageUrl,
    onTap: () => Get.to(() => ProductDetailScreen(id: product.id)),
  ),
)
```

**Where it is used:** Community / feed screens.

---

## 10. ProductCard

**File:** `lib/core/common/global_widgets/post_card/product_card.dart`  
**Class:** `ProductCard`

### What it does
A compact horizontal product card — 50×50 thumbnail on the left, product name, location, star rating, review count, current price, and crossed-out old price on the right. Fixed width at 70% of the screen width.

### Parameters (all required)

| Parameter | Type | Description |
|-----------|------|-------------|
| `title` | `String` | Product name. |
| `location` | `String` | Store or location name. |
| `rating` | `double` | Star rating (e.g. `4.5`). |
| `reviews` | `int` | Review count shown as `"4.5 (128)"`. |
| `price` | `double` | Current price shown as `$29.99`. |
| `oldPrice` | `double` | Original price shown with red strikethrough. |
| `image` | `String` | Network URL of the product image. |
| `onTap` | `VoidCallback` | Called when tapped. |

### Usage

```dart
ProductCard(
  title: 'Royal Canin Dog Food',
  location: 'Pet Shop NY',
  rating: 4.8,
  reviews: 321,
  price: 29.99,
  oldPrice: 45.00,
  image: product.imageUrl,
  onTap: () => Get.to(() => ProductDetailScreen(id: product.id)),
)
```

**Where it is used:** As `productWidget` inside `PostCard`; standalone in service/product listing sections.

---

## 11. BookingCard

**File:** `lib/core/common/global_widgets/service_get_card/service_get_card.dart`  
**Class:** `BookingCard`

### What it does
A horizontal card for booking history entries. Left side: 110×110 service image with an optional "Booked" badge overlay. Right side: title, location, price, booking ID reference, and a dark "View booking" button.

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `imageUrl` | `String` | **Yes** | — | Network URL of the service image. |
| `title` | `String` | **Yes** | — | Service or booking title. |
| `location` | `String` | **Yes** | — | Location text. |
| `price` | `String` | **Yes** | — | Price string (e.g. `"\$248/night"`). |
| `bookingId` | `String` | **Yes** | — | Shown as `"ID: #ABC123"`. |
| `isBooked` | `bool` | No | `false` | When `true`, shows a white "Booked" chip overlaid on the image. |
| `onTap` | `VoidCallback` | **Yes** | — | Called when "View booking" button is pressed. |

### Usage

```dart
BookingCard(
  imageUrl: booking.serviceImage,
  title: booking.serviceName,
  location: booking.address,
  price: '\$${booking.totalPrice}/night',
  bookingId: booking.id,
  isBooked: booking.status == BookingStatus.confirmed,
  onTap: () => Get.to(() => BookingDetailScreen(id: booking.id)),
)
```

**Where it is used:** Booking history screen.

---

## 12. SpecialCard

**File:** `lib/core/common/global_widgets/special_card_service/special_card_service.dart`  
**Class:** `SpecialCard`

### What it does
A full-width promotional banner card, 180 logical pixels tall. Background image fills the entire card; a left-to-right gradient overlay darkens the left side for text legibility. Shows a large discount percentage, an offer title (1 line), and a description (max 2 lines).

### How it is built internally
- `Container(width: double.infinity, height: 180.h)` → `ClipRRect` → `Stack`
- Layer 1: `Positioned.fill` network image (`BoxFit.cover`)
- Layer 2: `Positioned.fill` gradient container (`black @ 60% opacity` → transparent, left to right)
- Layer 3: `Positioned.fill` text content (title, subtitle, description)

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `imageUrl` | `String?` | `null` | Background image URL. |
| `title` | `String?` | `"30%"` | Large text — typically discount percentage. |
| `subtitle` | `String?` | `"Exclusive Offer"` | Medium text below the percentage. |
| `description` | `String?` | `"Up to 30% off..."` | Small description (max 2 lines). |
| `onTap` | `VoidCallback?` | `null` | Called when the card is tapped. |

### Usage

```dart
SpecialCard(
  imageUrl: promo.bannerUrl,
  title: '${promo.discountPercent}%',
  subtitle: promo.offerTitle,
  description: promo.description,
  onTap: () => Get.to(() => PromoDetailScreen(id: promo.id)),
)
```

**Where it is used:** Home screen promotions section.

---

## 13. SpecialServices

**File:** `lib/core/common/global_widgets/special_services/special_services.dart`  
**Class:** `SpecialServices`

### What it does
A section widget that renders a "Special Services" heading with a "See All" link, followed by a horizontally scrollable row of `ServiceCard` items. Accepts a plain `List<Map>` so it can be driven directly from API response data without needing a typed model.

### How it is built internally
- `Column` with a header `Row` (title + "See All" `GestureDetector`) and a `SizedBox(height: ...) → ListView.separated(scrollDirection: Axis.horizontal)`
- Height of the scroll area is `(0.40 * screenWidth) + 96` — matches `ServiceCard`'s internal image height plus info rows
- `ListView.separated` with a 12 px `SizedBox` separator between items
- Each item is a `ServiceCard` built from the map's fields

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `services` | `List<Map<String, dynamic>>` | **Yes** | List of service data maps. See required keys below. |
| `onSeeAll` | `VoidCallback?` | No | Called when "See All" is tapped. |

### Map keys expected per item

| Key | Type | Description |
|-----|------|-------------|
| `'imageUrl'` | `String` | Network URL for `ServiceCard.imageUrl`. |
| `'rating'` | `num` | Rating value — cast to `double` internally. Defaults to `4.5` if null. |
| `'title'` | `String` | Card title. |
| `'location'` | `String` | Location text. |
| `'price'` | `num` | Price — cast to `double` internally. |
| `'onTap'` | `VoidCallback` | Tap handler passed to `ServiceCard.onTap`. |

### Usage

```dart
SpecialServices(
  onSeeAll: () => Get.to(() => const ServiceSeeAll(serviceType: 'Special Services')),
  services: [
    {
      'imageUrl': 'https://example.com/hotel.jpg',
      'rating': 4.9,
      'title': 'Elite Pet Hotel',
      'location': 'New York, NY',
      'price': 248,
      'onTap': () => Get.to(() => HotelDetailScreen()),
    },
    {
      'imageUrl': 'https://example.com/grooming.jpg',
      'rating': 4.7,
      'title': 'Pro Grooming Studio',
      'location': 'Brooklyn, NY',
      'price': 60,
      'onTap': () => Get.to(() => GroomingDetailScreen()),
    },
  ],
)
```

**Where it is used:** Home screen — featured/special services horizontal row.

---

## 14. PetProfileCard

**File:** `lib/core/common/global_widgets/pet_profile_card/pet_profile_card.dart`  
**Class:** `PetProfileCard`

### What it does
A horizontal card for displaying a pet's key information — name (bold), breed (accent color), age and gender (small secondary text on one row) — with a circular avatar on the right. Used for selecting or tagging a pet.

### How it is built internally
- `GestureDetector` → `Container(width, height, padding, border, borderRadius)`
- Left: `Expanded(Column)` with name, breed, and an `Row(age, gender)`
- Right: `CircleAvatar(radius: 28, backgroundImage: NetworkImage)`
- Defaults: `width = AppSizer.width * 0.6`, `height = AppSizer.height * 0.1`

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | `String` | **Yes** | Pet's name — shown in bold. |
| `breed` | `String` | **Yes** | Breed — shown in `AppColors.accent`. |
| `details` | `String` | **Yes** | Stored but currently not rendered (reserved for future use). |
| `imageUrl` | `String` | **Yes** | Network URL of the pet's photo. |
| `age` | `String` | **Yes** | Age string (e.g. `"2 years"`). |
| `gender` | `String` | **Yes** | Gender string (e.g. `"Male"`). |
| `height` | `double?` | No | Card height. Defaults to 10% of screen height. |
| `width` | `double?` | No | Card width. Defaults to 60% of screen width. |
| `onTap` | `VoidCallback?` | No | Called when the card is tapped. |

### Usage

```dart
PetProfileCard(
  name: pet.name,
  breed: pet.breed,
  details: pet.notes,
  imageUrl: pet.photoUrl,
  age: '${pet.ageYears} years',
  gender: pet.gender,
  onTap: () => _selectPet(pet),
)
```

**In a horizontal list (tag a pet in a post):**
```dart
SizedBox(
  height: 90,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: myPets.length,
    itemBuilder: (context, i) => PetProfileCard(
      name: myPets[i].name,
      breed: myPets[i].breed,
      details: '',
      imageUrl: myPets[i].photoUrl,
      age: myPets[i].age,
      gender: myPets[i].gender,
      width: 200,
      onTap: () => _tagPet(myPets[i]),
    ),
  ),
)
```

**Where it is used:** Create Post screen (tag a pet section).

---

## 15. FriendCard

**File:** `lib/core/common/global_widgets/friend_section_card/people_card.dart`  
**Class:** `FriendCard`

### What it does
A social connection card whose button labels and enabled/disabled state change automatically based on the `FriendCardType` enum. No conditional logic is needed in the parent screen — just pass the correct type.

### Button behavior by type

| `FriendCardType` | Primary Button | Secondary Button | Primary enabled? |
|------------------|---------------|------------------|-----------------|
| `friend` | "Message" | "Unfriend" | Yes |
| `request` | "Accept" | "Reject" | Yes |
| `sentRequest` | "Requested" | "Cancel" | **No** (disabled) |

### How it is built internally
- `InkWell(onTap: onCardTap)` → `Container(padding, border, boxShadow, borderRadius)`
- `Row`: `CircleAvatar(radius: 28)` + `Expanded(Column(name, subtitle))` + primary `TextButton` + secondary `TextButton`
- Primary button is set to `onPressed: null` when `isPrimaryDisabled` (i.e. `sentRequest` type)

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | `String` | **Yes** | Display name. |
| `subtitle` | `String` | **Yes** | Status text (e.g. `"5 mutual friends"`, `"Pending"`). |
| `imageUrl` | `String` | **Yes** | Network URL of the profile picture. |
| `type` | `FriendCardType` | **Yes** | Controls button labels and states. |
| `onCardTap` | `VoidCallback` | **Yes** | Card body tap — navigate to profile. |
| `onPrimaryTap` | `VoidCallback?` | No | Primary button tap (Message / Accept). |
| `onSecondaryTap` | `VoidCallback?` | No | Secondary button tap (Unfriend / Reject / Cancel). |

### Usage Examples

```dart
// Existing friend
FriendCard(
  name: user.name,
  subtitle: '${user.mutualFriends} mutual friends',
  imageUrl: user.avatarUrl,
  type: FriendCardType.friend,
  onCardTap: () => Get.to(() => ProfileScreen(userId: user.id)),
  onPrimaryTap: () => Get.to(() => ChatScreen(userId: user.id)),
  onSecondaryTap: () => _unfriend(user.id),
)

// Incoming friend request
FriendCard(
  name: requester.name,
  subtitle: 'Wants to be friends',
  imageUrl: requester.avatarUrl,
  type: FriendCardType.request,
  onCardTap: () => Get.to(() => ProfileScreen(userId: requester.id)),
  onPrimaryTap: () => _acceptRequest(requester.id),
  onSecondaryTap: () => _rejectRequest(requester.id),
)

// Request already sent
FriendCard(
  name: user.name,
  subtitle: 'Pending',
  imageUrl: user.avatarUrl,
  type: FriendCardType.sentRequest,
  onCardTap: () => Get.to(() => ProfileScreen(userId: user.id)),
  onSecondaryTap: () => _cancelRequest(user.id),
  // onPrimaryTap is ignored — button is auto-disabled
)
```

**Where it is used:** People / friends list screens.

---

## 16. InfoCard

**File:** `lib/core/common/global_widgets/info_card/info_card.dart`  
**Class:** `InfoCard`

### What it does
A settings-style row card. Left side: a colored square with a rounded icon. Middle: title (semibold), subtitle, and optional description. Right side: a fixed `IconTextButton(text: 'View')` that shares the same `onTap` callback as the card.

### How it is built internally
- `GestureDetector(onTap)` → `Container(margin, padding, border, borderRadius)`
- `Row`: icon container + `Expanded(Column)` + `IconTextButton('View', onTap: onTap)`
- Description renders only when non-null
- Default `backgroundColor` is `AppColors.white` (light surface)

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `icon` | `IconData` | **Yes** | — | Icon shown in the colored box. |
| `title` | `String` | **Yes** | — | Primary text. |
| `subtitle` | `String` | **Yes** | — | Secondary text. |
| `description` | `String?` | No | `null` | Optional third line of smaller text. |
| `iconBgColor` | `Color` | No | `AppColors.primarylight` | Background of the icon box. |
| `backgroundColor` | `Color?` | No | `AppColors.white` | Card background. |
| `trailing` | `Widget?` | No | `null` | Reserved (not currently rendered). |
| `onTap` | `VoidCallback?` | No | `null` | Called by both the card and the View button. |

### Usage

```dart
InfoCard(
  icon: Icons.medical_services_outlined,
  iconBgColor: Colors.red.shade100,
  title: 'Vaccination Record',
  subtitle: 'Last updated: Jan 2025',
  description: 'Rabies, DHPP, Bordetella',
  onTap: () => Get.to(() => VaccinationScreen()),
)
```

**Where it is used:** Settings screen, pet health profile.

---

## 17. FilterButtonGroup

**File:** `lib/core/common/global_widgets/tabbar/filter_tabbar.dart`  
**Class:** `FilterButtonGroup`

### What it does
A pill-style tab/filter bar where each option is an animated button. The selected button gets a colored background with an `AnimatedContainer` transition (200 ms). Supports two layout modes:
- `isExpanded: true` — all buttons have equal width (good for 3–4 tabs that fill the full width)
- `isExpanded: false` — buttons are chip-sized based on text content (good for scrollable filter chips)

### How it is built internally
- Outer `Container` is the bar background
- `Row` of `AnimatedContainer` buttons generated by `List.generate`
- When `isExpanded: true` each button is wrapped in `Expanded`; when `false` it is not wrapped
- State is managed by the parent — `FilterButtonGroup` is stateless; the parent controls `selectedIndex`

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `options` | `List<String>` | **Yes** | — | Labels for each button. |
| `selectedIndex` | `int` | **Yes** | — | Index of the active button. |
| `onChanged` | `Function(int)` | **Yes** | — | Called with the new index on tap. |
| `isExpanded` | `bool` | No | `true` | Equal width vs chip width. |
| `selectedColor` | `Color?` | No | `AppColors.primary` | Active button fill. |
| `unselectedColor` | `Color?` | No | `AppColors.background(context)` | Bar background. |
| `textColor` | `Color?` | No | `AppColors.white` | Active button text color. |
| `borderRadius` | `double` | No | `10` | Corner radius of bar and buttons. |

### Usage Examples

**Equal-width booking tabs (most common use):**
```dart
// Declare in state:
int _tab = 0;

// In build:
FilterButtonGroup(
  options: const ['Pending', 'Ongoing', 'Completed', 'Cancelled'],
  selectedIndex: _tab,
  onChanged: (i) => setState(() => _tab = i),
)
```

**Chip-style filter (auto width):**
```dart
FilterButtonGroup(
  options: const ['All', 'Dogs', 'Cats', 'Birds'],
  selectedIndex: _selected,
  onChanged: (i) => setState(() => _selected = i),
  isExpanded: false,
)
```

**Where it is used:** Booking screen status tabs.

---

## 18. UnderlineTabBar

**File:** `lib/core/common/global_widgets/tabbar/underline_tabbar.dart`  
**Class:** `UnderlineTabBar`

### What it does
A Material `TabBar` with a primary-colored underline indicator and optional leading icons per tab. Scrollable from the start (no equal-width stretching). Must be placed inside a `DefaultTabController` or connected to a `TabController`.

### How it is built internally
- Returns a Flutter `TabBar` directly (not a custom widget around it)
- `isScrollable: true`, `tabAlignment: TabAlignment.start`
- `indicatorSize: TabBarIndicatorSize.label` so the underline matches the label width, not the full tab
- Selected text is `semiBoldTextStyle`, unselected is `regularTextStyle`
- Each `Tab` contains a `Row(icon?, text)`

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `tabs` | `List<String>` | **Yes** | Tab label strings. |
| `images` | `List<Widget>?` | No | Optional leading icon/image per tab. Length must match `tabs`. |

### Usage Examples

**Text-only tabs:**
```dart
DefaultTabController(
  length: 3,
  child: Column(
    children: [
      UnderlineTabBar(
        tabs: const ['Posts', 'Photos', 'Videos'],
      ),
      Expanded(
        child: TabBarView(
          children: [PostsTab(), PhotosTab(), VideosTab()],
        ),
      ),
    ],
  ),
)
```

**With leading icons:**
```dart
UnderlineTabBar(
  tabs: const ['Friends', 'Requests', 'Suggested'],
  images: const [
    Icon(Icons.people, size: 16),
    Icon(Icons.person_add, size: 16),
    Icon(Icons.star_outline, size: 16),
  ],
)
```

**Where it is used:** Profile screen, gallery section tabs.

---

## 19. FilterService + FilterResult

**File:** `lib/core/common/global_widgets/filter_service/filter_service.dart`  
**Classes:** `FilterService` (StatefulWidget), `FilterResult` (plain data class)

### What it does
A draggable bottom sheet filter panel. Depending on the `showStayType` flag it renders either:
- **Service / school / care mode** (`showStayType: false`): categories grid + price range + sort by + ratings
- **Hotel mode** (`showStayType: true`): stay type checkboxes + price range + ratings (no categories/sort)

All state is managed internally. When "Apply Filter" is tapped, a `FilterResult` object is returned via `onApply` and the sheet closes.

### How to open it — always use the static method

```dart
FilterService.show(context, {showStayType, onApply})
```

Never instantiate `FilterService` directly in a `build` method.

### Static method signature

```dart
FilterService.show(
  BuildContext context, {
  bool showStayType = false,
  void Function(FilterResult)? onApply,
})
```

### FilterResult — data returned on apply

| Field | Type | Description |
|-------|------|-------------|
| `onlyPet` | `bool` | "Only Pet" stay type checked (hotel mode only). |
| `humanAndPet` | `bool` | "Human And Pet" stay type checked (hotel mode only). |
| `minPrice` | `double` | Lower price bound (slider range 0–300). |
| `maxPrice` | `double` | Upper price bound (slider range 0–300). |
| `categories` | `Map<String, bool>` | `{"Name Training": true, "Leash": false, ...}` — 8 categories. |
| `sortBy` | `String` | One of: `'Most Popular'`, `'Most Recent'`, `'Top Selling'`, `'Low to High'`, `'High to Low'`. |
| `ratings` | `Set<int>` | Set of selected star ratings, e.g. `{4, 5}`. |

### Available categories (service/school mode)

`Name Training`, `Potty Training`, `Leash`, `Behavior`, `Socialization`, `Agility Training`, `Guard Training`, `Puppy Training`

### Usage Examples

**Pet School / Pet Care filter:**
```dart
GestureDetector(
  onTap: () => FilterService.show(
    context,
    onApply: (result) {
      setState(() {
        _minPrice = result.minPrice;
        _maxPrice = result.maxPrice;
        _sortBy = result.sortBy;
        _selectedRatings = result.ratings;
        _categories = result.categories;
      });
    },
  ),
  child: const Icon(Icons.filter_list),
)
```

**Hotel filter (with stay type):**
```dart
FilterService.show(
  context,
  showStayType: true,
  onApply: (result) {
    setState(() {
      _onlyPet = result.onlyPet;
      _humanAndPet = result.humanAndPet;
      _minPrice = result.minPrice;
      _maxPrice = result.maxPrice;
    });
  },
)
```

**Using FilterResult data to filter a list:**
```dart
List<Service> get _filtered => allServices.where((s) {
  final priceOk = s.price >= result.minPrice && s.price <= result.maxPrice;
  final ratingOk = result.ratings.isEmpty || result.ratings.contains(s.rating.floor());
  return priceOk && ratingOk;
}).toList();
```

**Where it is used:** Pet Market, Pet School, Pet Care, `ServiceSeeAll`.

---

## 20. QuickButton

**File:** `lib/core/common/global_widgets/quick_button/quick_button.dart`  
**Class:** `QuickButton`

### What it does
A small selectable category button: SVG icon on top, text label below. When `isSelected: true` the container gets a primary-tinted border and light background. Used as items inside `FilterService`'s category grid.

### How it is built internally
- `GestureDetector` → `Padding` → `Column(icon container, SizedBox, Text)`
- Icon container is a `Container(padding, decoration)` wrapping `SizedBox(30w × 30h, SvgPicture.asset)`
- Selection state changes the container color and border (no animation)

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `image` | `String` | `''` | Asset path to the SVG icon (e.g. `'assets/icons/leash.png'`). |
| `title` | `String` | `''` | Label below the icon. Max 1 line, ellipsis. |
| `ontap` | `GestureTapCallback?` | `null` | Tap handler. |
| `isSelected` | `bool` | `false` | Highlights the button when `true`. |

### Usage

```dart
QuickButton(
  image: 'assets/icons/leash.png',
  title: 'Leash',
  isSelected: _selectedCategories.contains('Leash'),
  ontap: () => setState(() => _toggleCategory('Leash')),
)
```

**Where it is used:** Inside `FilterService` category grid (internal). Can be reused in any custom category selector.

---

## 21. AddShortsCard

**File:** `lib/core/common/global_widgets/shorts_card_main/shorts_card_first/shorts_card_first.dart`  
**Class:** `AddShortsCard`

### What it does
A gradient card (primary-light → primary-dark, top-left to bottom-right) with a circular "+" button and "Add Shorts" label. Placed as the first item in the shorts row to prompt the user to create a new short.

### How scaling works
The widget computes a scale factor `s` by comparing the passed `width`/`height` to a 160×220 base size. All internal sizes (border radius, icon size, font size) multiply by `s` so the card looks proportional at any dimensions. The `scale` parameter is a manual multiplier on top of the auto-scaling.

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `width` | `double` | **Yes** | — | Rendered card width. |
| `height` | `double` | **Yes** | — | Rendered card height. |
| `scale` | `double` | No | `1` | Additional manual scale factor. |
| `onTap` | `VoidCallback?` | No | `null` | Called when tapped. |

### Usage

```dart
AddShortsCard(
  width: 120,
  height: 160,
  onTap: () => Get.to(() => CreateShortScreen()),
)
```

**Where it is used:** Shorts gallery row — always the first item.

---

## 22. ShortsCard

**File:** `lib/core/common/global_widgets/shorts_card_main/shorts_card_second/shorts_card_second.dart`  
**Class:** `ShortsCard`

### What it does
A video short card showing a thumbnail with a play icon overlay in the top-right, the video title in the top-left, and a bottom stats row showing likes, comments, and views. Uses the same proportional scaling approach as `AddShortsCard`.

### How scaling works
Base size is `0.33 * screenWidth` × `0.33 * screenHeight`. `s` is computed from `width/baseWidth` and `height/baseHeight`, then all internal sizes multiply by `s`.

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `width` | `double` | **Yes** | — | Card width. |
| `height` | `double` | **Yes** | — | Card height. |
| `title` | `String` | **Yes** | — | Video title (1 line, ellipsis). |
| `scale` | `double` | No | `1` | Manual scale multiplier. |
| `image` | `String?` | No | Unsplash placeholder | Network URL of the thumbnail. |
| `likes` | `int` | No | `0` | Like count. |
| `comments` | `int` | No | `0` | Comment count. |
| `views` | `int` | No | `0` | View count. |
| `onTap` | `VoidCallback?` | No | `null` | Called when tapped. |

### Usage

```dart
ShortsCard(
  width: 120,
  height: 160,
  title: short.title,
  image: short.thumbnailUrl,
  likes: short.likes,
  comments: short.comments,
  views: short.views,
  onTap: () => Get.to(() => ShortPlayerScreen(id: short.id)),
)
```

**In a horizontal list:**
```dart
SizedBox(
  height: 160,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: shorts.length + 1,
    itemBuilder: (context, i) {
      if (i == 0) return AddShortsCard(width: 120, height: 160, onTap: _create);
      final s = shorts[i - 1];
      return ShortsCard(width: 120, height: 160, title: s.title, image: s.thumb, onTap: () {});
    },
  ),
)
```

**Where it is used:** Shorts gallery row — every item after `AddShortsCard`.

---

## 23. PhotoGridTab + PhotoItem

**File:** `lib/core/common/global_widgets/photo_grid_tab/photo_grid_tab.dart`  
**Classes:** `PhotoGridTab`, `PhotoItem`

### What it does
A 3-column photo/video grid using `CustomScrollView` + `SliverGrid`. Items with `isVideo: true` show a small camera icon badge (top-right corner). A section title is shown above the grid via `SliverToBoxAdapter`.

### PhotoItem model

```dart
class PhotoItem {
  final String imageUrl; // network URL
  final bool isVideo;    // shows camera badge overlay when true
  const PhotoItem({required this.imageUrl, this.isVideo = false});
}
```

### PhotoGridTab parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | `'My Photos'` | Section header shown above the grid. |
| `photos` | `List<PhotoItem>` | **Required** | List of items to display. |

### Static default data
`PhotoGridTab.defaultPhotos` — a `const List<PhotoItem>` with 9 Unsplash pet images (3 flagged as video). Use for placeholder/demo screens.

### Usage

```dart
// With real data
PhotoGridTab(
  title: 'My Photos',
  photos: userMedia.map((m) => PhotoItem(
    imageUrl: m.url,
    isVideo: m.type == MediaType.video,
  )).toList(),
)

// With placeholder data
PhotoGridTab(
  title: 'Photos',
  photos: PhotoGridTab.defaultPhotos,
)
```

> **Important:** `PhotoGridTab` uses `CustomScrollView` internally. It must be placed inside an `Expanded` or a `SizedBox` with a bounded height — never inside an unbounded parent.

**Where it is used:** User profile screen, photos tab.

---

## 24. PostOptionsDialog

**File:** `lib/core/common/global_widgets/post_card/three_dot_dialog.dart`  
**Class:** `PostOptionsDialog`

### What it does
A `Dialog` shown when the three-dot (`more_vert`) icon on a `PostCard` is tapped. Contains two `ListTile` options: **Edit Post** and **Delete Post**. Both options pop the dialog first then trigger their logic. Delete tile text and icon are shown in `AppColors.error` (red).

### How it is built internally
- A `Dialog(backgroundColor: AppColors.surface, borderRadius: 16)` containing a `Column`
- Two `ListTile` items:
  1. `Icons.edit` + "Edit Post" — calls `Navigator.pop` then allows edit logic to be attached
  2. `Icons.delete` (red) + "Delete Post" (red) — calls `Navigator.pop` then allows delete logic to be attached
- Currently the edit/delete logic inside the widget is empty — wire it up from `onAddSection` or extend the widget to accept delete callback

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onAddSection` | `VoidCallback` | **Yes** | Currently called by neither tile (the tiles pop and handle logic internally). Pass a no-op `() {}` for now; extend the widget when real edit/delete API is added. |

### Usage (opened automatically inside PostCard — you rarely call this directly)

```dart
showDialog(
  context: context,
  builder: (_) => PostOptionsDialog(
    onAddSection: () {},
  ),
);
```

**Where it is used:** Automatically inside `PostCard._header()` when the three-dot button is tapped.

---

## 25. LikesBottomSheet

**File:** `lib/core/common/global_widgets/post_card/post_like_bottom_sheet.dart`  
**Class:** `LikesBottomSheet`

### What it does
A 300 px tall bottom sheet showing a "Likes" heading, a divider, and a scrollable `ListView` of placeholder user entries (`"User 0"`, `"User 1"`, ...). The item count equals `likes`.

> **Note:** Currently uses placeholder data (`Text("User $index")`). When real API is integrated, extend this widget to accept a `List<UserModel>` and render real user names and avatars.

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `likes` | `int` | **Yes** | Drives the item count of the list. |

### Usage (opened automatically inside PostCard._counts() — you rarely call this directly)

```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (context) => LikesBottomSheet(likes: post.likes),
);
```

**Where it is used:** Tapping the likes count text inside `PostCard`.

---

## 26. FloatingChatButton

**File:** `lib/core/common/global_widgets/floating_msg/floating_msg.dart`  
**Class:** `FloatingChatButton`

### What it does
A circular `FloatingActionButton` with a custom `AssetImage` icon for opening chat or support. Colors fall back to the current theme's surface and text-primary colors by default.

### How it is built internally
- `Container(shape: BoxShape.circle)` wrapping `FloatingActionButton`
- The `Image(image: image)` is used as the FAB's child
- `backgroundColor` and `foregroundColor` on both the outer container and FAB are kept in sync

### Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `onTap` | `VoidCallback` | **Yes** | — | Called when the button is pressed. |
| `image` | `AssetImage` | No | `AssetImage('assets/icons/chat_icon.png')` | Icon asset. |
| `backgroundColor` | `Color?` | No | `AppColors.surface(context)` | Button background. |
| `forgraoundColor` | `Color?` | No | `AppColors.textPrimary(context)` | Foreground / icon tint. Note: parameter is spelled `forgraoundColor` (typo in source). |

### Usage

```dart
// Default chat button
Scaffold(
  floatingActionButton: FloatingChatButton(
    onTap: () => Get.to(() => ChatListScreen()),
  ),
  body: ...,
)

// Custom support button
FloatingChatButton(
  image: const AssetImage('assets/icons/support.png'),
  backgroundColor: AppColors.primary,
  forgraoundColor: Colors.white,
  onTap: () => _openSupportChat(),
)
```

**Where it is used:** Any screen that needs a persistent floating chat/support action button.

---

## 27. InternetLost

**File:** `lib/core/common/global_widgets/network_error/internet_lost.dart`  
**Class:** `InternetLost`

### What it does
A full `Scaffold` error page shown when the device has no internet connection. Shows a Lottie animation (paper plane), a "No Internet Connection" heading, an explanatory message, and a "Retry ↺" tap link that calls `InternetService.to.retry()`. Colors auto-adapt to dark and light mode.

### How it is built internally
- `Scaffold(backgroundColor: black/white based on theme)` → `SafeArea` → centered `Column`
- Lottie animation from `assets/jsons/paperplane.json` at 150 logical pixels tall
- Retry triggers `InternetService.to.retry()` — a GetX service that manages connectivity

### Parameters
None. This widget has no constructor parameters.

### Usage

```dart
// Replace screen body when offline
Obx(() {
  if (!InternetService.to.isConnected.value) {
    return const InternetLost();
  }
  return _buildNormalScreen();
})
```

**Asset required:** `assets/jsons/paperplane.json`  
**GetX dependency:** `InternetService` must be registered before use.

**Where it is used:** Any screen that needs offline handling.

---

## 28. Indicators

**File:** `lib/core/common/global_widgets/loading_indicator/indicators.dart`  
**Class:** `Indicators`

### What it does
A static utility class providing three loading animation factory methods. Cannot be instantiated (`Indicators._()` private constructor). Uses the `loading_animation_widget` package.

### Methods

| Method | Animation Description |
|--------|-----------------------|
| `Indicators.twistingDots({color, size})` | Two dots that twist and rotate toward each other. |
| `Indicators.waveDots({color, size})` | A row of dots animated in a wave pattern. |
| `Indicators.horizontalRotatingDots({color, size})` | Dots rotating along a horizontal arc. |

All three methods require:
- `color` (`Color`) — the dot color
- `size` (`double`) — the total size of the animation widget

### Usage

```dart
// Centered loading state
if (_isLoading)
  Center(
    child: Indicators.twistingDots(
      color: AppColors.primary,
      size: 48,
    ),
  )

// Inline in a button row
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Indicators.waveDots(color: AppColors.white, size: 28),
    const SizedBox(width: 8),
    const Text('Processing...'),
  ],
)

// In a list tile
Indicators.horizontalRotatingDots(
  color: AppColors.primary,
  size: 32,
)
```

**Where it is used:** Any loading state across the app.

---

## 29. ServiceSeeAll

**File:** `lib/core/common/global_widgets/service_see_all/service_see_all.dart`  
**Class:** `ServiceSeeAll`

### What it does
A complete self-contained `Scaffold` screen (has its own `ProAppBar`) showing a 2-column grid of `ServiceCard` items with built-in text search and price-range filtering via `FilterService`. Navigate to this screen when the user taps "See All" on any service section.

### How it is built internally
- `ProAppBar` with the `serviceType` as title and a grid-view toggle icon in actions
- Header row: `ProSearchBar` (with live `onChanged` filtering) + filter icon that opens `FilterService.show()`
- Body: `GridView.builder(crossAxisCount: 2, childAspectRatio: 0.72)` of `ServiceCard` items
- `_filtered` getter combines text search (title + location) and price range filter from `FilterService`
- **Currently uses demo data (`_demoItems`).** Replace with a real API call / controller data when integrating

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `serviceType` | `String` | `''` | Screen title shown in `ProAppBar` (e.g. `"Pet Hotels"`, `"Training"`). |
| `isHotel` | `bool` | `false` | When `true`, passes `showStayType: true` to `FilterService` to show hotel-specific filters. |

### Usage

```dart
// From any "See All" button
GestureDetector(
  onTap: () => Get.to(() => const ServiceSeeAll(
    serviceType: 'Pet Hotels',
    isHotel: true,
  )),
  child: const Text('See All'),
)

// Training courses
Get.to(() => const ServiceSeeAll(serviceType: 'Training Classes'))

// Pet care
Get.to(() => const ServiceSeeAll(serviceType: 'Pet Care'))
```

**Where it is used:** Tapping "See All" on Pet Market, Pet School, and Pet Care sections.

---

## 30. Placeholder Files (not yet implemented)

These three files exist in the folder but contain no code (1-line empty files). They are scaffolded for future features:

| File | Intended Widget | Status |
|------|----------------|--------|
| `payment_sheet/common_paymentsheet.dart` | `CommonPaymentSheet` — a reusable payment bottom sheet | Empty — not yet built |
| `service_details_screen/service_details_screen.dart` | `ServiceDetailsScreen` — a shared detail screen for any service type | Empty — not yet built |
| `shorts_card_main/shorts_card_third/shorts_card_third.dart` | Third variant of the shorts card | Empty — not yet built |

When implementing these, follow the same patterns as the existing widgets in this folder. Add documentation here when they are built.

---

## 31. AppTextStyle — Typography System

**File:** `lib/core/common/styles/global_text_style.dart`  
**Class:** `AppTextStyle`

The centralized text style system for the entire app. All text must use this class — never write raw `TextStyle` with a font directly.

**Font:** Google Fonts **Nunito** — applied via `GoogleFonts.nunito()`  
**Sizing:** All `fontSize` values go through `AppSizer` (`.sp`) for responsive scaling

### Instantiation

```dart
AppTextStyle(context)   // context-aware: color defaults to AppColors.textPrimary(context)
AppTextStyle()          // no context: color defaults to AppColors.lightTextPrimary
```

### Font size constants

| Constant | Value | When to use |
|----------|-------|------------|
| `AppTextStyle.xs` | `10` | Captions, badges, tiny labels |
| `AppTextStyle.sm` | `12` | Secondary text, subtitles |
| `AppTextStyle.md` | `14` | Body text (default) |
| `AppTextStyle.lg` | `16` | Primary labels, button text |
| `AppTextStyle.xl` | `18` | Section sub-headers |
| `AppTextStyle.xxl` | `20` | Card titles, app bar titles |
| `AppTextStyle.title` | `24` | Screen titles |
| `AppTextStyle.heading` | `28` | Large headings |
| `AppTextStyle.display` | `32` | Hero/display text |

### Named weight shortcut methods

All methods accept optional `fontSize`, `color`, `fontStyle`, `lineHeight`, `letterSpacing`, `wordSpacing`, `decoration`.

| Method | FontWeight |
|--------|-----------|
| `thinTextStyle()` | w100 |
| `extraLightTextStyle()` | w200 |
| `lightTextStyle()` | w300 |
| `regularTextStyle()` | w400 |
| `mediumTextStyle()` | w500 |
| `semiBoldTextStyle()` | w600 |
| `boldTextStyle()` | w700 |
| `extraBoldTextStyle()` | w800 |
| `blackTextStyle()` | w900 |

### Base method — full control

```dart
AppTextStyle(context).getTextStyle(
  fontSize: 15,
  color: Colors.red,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.underline,
  letterSpacing: 0.5,
  lineHeight: 22,
)
```

### Usage Examples

```dart
// Screen title
Text('My Pets',
  style: AppTextStyle(context).boldTextStyle(fontSize: AppTextStyle.title))

// Secondary label in a card
Text(pet.breed,
  style: AppTextStyle(context).regularTextStyle(
    fontSize: AppTextStyle.sm,
    color: AppColors.textSecondary(context),
  ))

// Old price — red strikethrough
Text('\$45.00',
  style: AppTextStyle().regularTextStyle(
    color: AppColors.error,
    decoration: TextDecoration.lineThrough,
  ))

// App bar title
Text('Settings',
  style: AppTextStyle(context).semiBoldTextStyle(
    fontSize: AppTextStyle.xxl,
  ))
```

---

## 32. All Enums

**File:** `lib/core/utils/constants/enums.dart`

All enums used across the app — including those consumed by global widgets.

### Used directly by global widgets

```dart
// Used by FriendCard
enum FriendCardType {
  friend,       // shows: Message + Unfriend
  request,      // shows: Accept + Reject
  sentRequest,  // shows: Requested (disabled) + Cancel
}
```

### Used by feature screens across the app

```dart
enum BookingStatus {
  pending, confirmed, ongoing, completed, cancelled, disputed
}

enum HealthRecordType {
  vaccination, prescription, surgery, checkup, dental, diagnosis, other
}

enum NotificationType {
  booking, message, like, comment, follow, community, system
}

enum PetSpecies {
  dog, cat, bird, rabbit, hamster, reptile, other
}

enum ServiceCategory {
  hotel, market, care, school, grooming, training
}

enum PostType {
  photo, video, story, reel, poll
}

enum MediaType {
  image, video, document, audio
}

enum UserRole {
  user, serviceProvider, admin, guest
}

enum MessageType {
  text, image, video, document
}

enum PickerType {
  photo, video, both
}

enum AppDeviceType {
  small, medium, large, tablet
}

enum OrderStatus {
  processing, shipped, delivered
}

enum PaymentMethods {
  paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm
}
```

---

## Quick Reference — Widget to Screen Map

| Screen / Feature | Widgets Used |
|-----------------|-------------|
| **Home** | `ProHomeHeader`, `ProSearchBar`, `SpecialCard`, `SpecialServices`, `CreatePostBar`, `ShortsCard`, `AddShortsCard` |
| **Home — Guest user** | `ProHomeHeader(isGuest: true)` → `IconTextButton("Login")` |
| **Home — Logged-in** | `ProHomeHeader(isGuest: false)` → scan icon + notification bell |
| **All inner screens** | `ProAppBar` |
| **Pet Market / School / Care** | `ProAppBar`, `ProSearchBar`, `ServiceCard`, `FilterService` |
| **See All pages** | `ServiceSeeAll` (includes `ProAppBar`, `ProSearchBar`, `ServiceCard`, `FilterService`) |
| **Booking history** | `ProAppBar`, `BookingCard`, `FilterButtonGroup` |
| **Booking form** | `ProTextField`, `ProElevatedButton` |
| **Create Post** | `ProAppBar`, `CreatePostBar`, `PetProfileCard`, `ServiceCard`, `ProductCard` |
| **Community / Feed** | `PostCard`, `LikesBottomSheet`, `PostOptionsDialog` |
| **Profile screen** | `UnderlineTabBar`, `FriendCard`, `PhotoGridTab`, `InfoCard` |
| **Settings screen** | `ProAppBar`, `InfoCard` |
| **Shorts section** | `AddShortsCard`, `ShortsCard` |
| **Any form** | `ProTextField`, `ProElevatedButton` |
| **Any loading state** | `Indicators.twistingDots()` / `.waveDots()` / `.horizontalRotatingDots()` |
| **No internet** | `InternetLost` |
| **Chat FAB** | `FloatingChatButton` |
| **Filter categories** | `QuickButton` (inside `FilterService`) |
| **Any header action chip** | `IconTextButton` |

---

## Package Dependencies Used by Global Widgets

| Package | Used by |
|---------|---------|
| `google_fonts` | `AppTextStyle` — Nunito font |
| `flutter_svg` | `QuickButton`, `PostCard` (action icon SVGs) |
| `loading_animation_widget` | `Indicators` |
| `lottie` | `InternetLost` |
| `get` (GetX) | `ServiceSeeAll` (navigation), `InternetLost` (InternetService) |
| `iconsax` | `ProHomeHeader` (notification icon) |
| `lucide_icons` | `ProHomeHeader` (scan icon), `ProSearchBar` (search icon), `ServiceSeeAll` |
