# MiniUi

A lightweight Flutter UI component library built on the `widgets` layer.

MiniUi explores:

- A UI stack that **does not depend on `material.dart`**
- Centralized multi-theme management (light / dark / blue / red / festival, etc.)
- Reuse as an SDK / component library across projects
- A pure token‑driven design system  
  (Color / Spacing / Radius / Typography / ComponentSize)

This repository contains both the component implementations and a visual demo app (under `example/`).

---

## Features

- **No Material dependency**
  - Entry based on `WidgetsApp` + `Directionality`
  - Components only import `package:flutter/widgets.dart`

- **Theme + token system**
  - `MiniTheme`: aggregates color / spacing / radius / typography / component‑size tokens
  - Built‑in themes: `light / dark / blue / red / festival`
  - `MiniThemeController`: global theme state with hot switching

- **Pure component abstraction**
  - Display: `MiniText / MiniCard / MiniImage / MiniTag / MiniEmpty / MiniLoading`
  - Input: `MiniButton / MiniInput`
  - Form: `MiniCheckbox / MiniSwitch / MiniStepper / MiniSearchBar`
  - List: `MiniDivider / MiniListItem`
  - Navigation & layout: `MiniAppBar / MiniTabBar / MiniPageScaffold`
  - Feedback: `MiniToast / MiniDialog / MiniActionSheet / MiniSnackbar / MiniLoadingOverlay`

- **Demo pages**
  - Home: theme switching + basic components + form examples + list & toast examples
  - List: full‑screen `MiniListItem` list skeleton
  - Tokens: visualized colors / spacing / radius / typography tokens

---

## Quick Start

### Dependency (assuming published to pub.dev)

Add MiniUi to your host app `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  miniui: ^1.0.0
```

### Minimal example (no `material.dart`)

```dart
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

void main() {
  final controller = MiniThemeController();

  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: MiniThemeProvider(
        theme: controller.theme,
        child: WidgetsApp(
          color: controller.theme.colors.background,
          builder: (context, _) => Center(
            child: MiniButton(
              label: 'Hello MiniUi',
              onPressed: () {},
            ),
          ),
        ),
      ),
    ),
  );
}
```

This snippet shows:

- Using `MiniThemeController` to manage the current theme
- Injecting the theme via `MiniThemeProvider`
- Rendering a button via `MiniButton`

For more complete usage, see the “Use MiniUi as SDK in another project” section below and the examples in `example/`.

---

## Project Structure (core)

```text
lib/
  core/
    base/
      base_component.dart   # MiniThemeController / MiniThemeProvider / BaseComponent
    painters/
      loading_painter.dart  # Custom painter for loading
    utils/
      tokens.dart           # MiniTheme + Color/Spacing/Radius/Typography tokens

  components/
    button/      mini_button.dart
    card/        mini_card.dart
    empty/       mini_empty.dart
    image/       mini_image.dart
    input/       mini_input.dart
    loading/     mini_loading.dart
    tag/         mini_tag.dart
    text/        mini_text.dart
    form/
      mini_checkbox.dart
      mini_radio.dart
      mini_switch.dart
      mini_stepper.dart
      mini_search_bar.dart
    list/
      mini_divider.dart
      mini_list_item.dart
    data/
      mini_avatar.dart
      mini_badge.dart
      mini_skeleton.dart
    feedback/
      mini_toast.dart
      mini_dialog.dart
      mini_action_sheet.dart
      mini_snackbar.dart
      mini_loading_overlay.dart
    nav/
      mini_app_bar.dart
      mini_tab_bar.dart
    layout/
      mini_page_scaffold.dart
    selection/
      mini_segmented_control.dart

  miniui.dart         # Public export entry (SDK-style)

example/
  lib/
    main.dart         # Example app entry (home / list / tokens / layout / feedback)
    demo/
      home_page.dart    # Home demo
      list_page.dart    # List demo
      tokens_page.dart  # Theme tokens demo
      layout_page.dart  # Layout & navigation demo
      feedback_page.dart# Feedback components demo

  example.dart       # Minimal usage example (optional)
```

---

## Theme & Token System

### MiniTheme & tokens

Theme definitions are centralized in [`lib/core/utils/tokens.dart`](lib/core/utils/tokens.dart):

- `MiniColorTokens`
- `MiniSpacingTokens`
- `MiniRadiusTokens`
- `MiniTypographyTokens`
- `MiniComponentSizeTokens` (component sizing tokens: button / input)
- `MiniTheme` (aggregates all tokens above)
- `MiniThemes` (built‑in themes)

Simplified definition:

```dart
class MiniTheme {
  final String name;
  final Brightness brightness;
  final MiniColorTokens colors;
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;
  final MiniComponentSizeTokens componentSizes;
}
```

Components consistently read design values from `MiniTheme`, for example:

- Spacing: `theme.spacing.md`
- Radius: `theme.radius.medium`
- Typography: `theme.typography.body`
- Colors: `theme.colors.primary / background / foreground ...`
- Component sizes: `theme.componentSizes.buttonPadding / inputPadding`

### Component size tokens: MiniComponentSizeTokens

Component sizes (button height, input height, etc.) are controlled by `MiniComponentSizeTokens` instead of being hard‑coded:

```dart
class MiniComponentSizeTokens {
  final EdgeInsets buttonPadding;
  final EdgeInsets inputPadding;
}
```

Built‑in themes already provide sensible defaults (matching current visuals):

- Default family (`light / dark / blue / red / festival`)
  - `buttonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10)`
  - `inputPadding  = EdgeInsets.symmetric(horizontal: 14, vertical: 10)`
- `compact`
  - `buttonPadding = EdgeInsets.symmetric(horizontal: 14, vertical: 6)`
  - `inputPadding  = EdgeInsets.symmetric(horizontal: 10, vertical: 6)`
- `rounded`
  - `buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 12)`
  - `inputPadding  = EdgeInsets.symmetric(horizontal: 16, vertical: 12)`

Components now read these tokens:

- `MiniButton` uses `theme.componentSizes.buttonPadding`
- `MiniInput` uses `theme.componentSizes.inputPadding`

You can change sizes in two ways:

1. Provide explicit component‑size tokens in a custom theme:

   ```dart
   const MiniTheme brandTheme = MiniTheme(
     name: 'brand',
     brightness: Brightness.light,
     colors: MiniColorTokens(
       primary: Color(0xFF6200EE),
       background: Color(0xFFF3EFFE),
       foreground: Color(0xFF1D1B20),
       accent: Color(0xFF03DAC6),
       danger: Color(0xFFB00020),
     ),
     spacing: MiniThemes.defaultSpacing,
     radius: MiniThemes.defaultRadius,
     typography: MiniThemes.defaultTypography,
     componentSizes: MiniComponentSizeTokens(
       buttonPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
       inputPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
     ),
   );
   ```

2. Adjust tokens at runtime via `MiniThemeController.updateTokens`:

   ```dart
   final controller = MiniThemeController(initialTheme: MiniThemes.light);

   void enlargeButtons() {
     final current = controller.theme.componentSizes;
     controller.updateTokens(
       componentSizes: current.copyWith(
         buttonPadding: current.buttonPadding +
             const EdgeInsets.symmetric(vertical: 4),
       ),
     );
   }
   ```

This lets you tune component sizes by editing tokens instead of changing `MiniButton` / `MiniInput` implementations.

### Theme control & injection

[`lib/core/base/base_component.dart`](lib/core/base/base_component.dart) provides:

- `MiniThemeController`: hot‑switch themes (`setTheme` / `setThemeByName`)
- `MiniThemeProvider`: `InheritedWidget` that injects `MiniTheme`
- `BaseComponent`: base class providing `themeOf(context)` for components

Usage at app root:

```dart
final controller = MiniThemeController(initialTheme: MiniThemes.light);

WidgetsApp(
  color: controller.theme.colors.background,
  builder: (context, _) {
    return MiniThemeProvider(
      theme: controller.theme,
      child: YourRootWidget(),
    );
  },
);
```

### Custom brand skins / custom theme tokens

Besides built‑in `light / dark / blue / red / festival`, you can define your own branded theme:

```dart
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

const MiniTheme brandTheme = MiniTheme(
  name: 'brand',
  brightness: Brightness.light,
  colors: MiniColorTokens(
    primary: Color(0xFF6200EE),
    background: Color(0xFFF3EFFE),
    foreground: Color(0xFF1D1B20),
    accent: Color(0xFF03DAC6),
    danger: Color(0xFFB00020),
  ),
  spacing: MiniThemes.defaultSpacing,
  radius: MiniThemes.defaultRadius,
  typography: MiniThemes.defaultTypography,
);

void main() {
  final controller = MiniThemeController(
    initialTheme: brandTheme,
    availableThemes: <MiniTheme>[
      brandTheme,
      ...MiniThemes.all,
    ],
  );

  runApp(MyApp(controller: controller));
}
```

With this:

- Components automatically read tokens from `brandTheme`
- You can switch between built‑in themes and custom skins via `MiniThemeController`
- Multiple branded skins can be added to `availableThemes`

### Extending spacing tokens (xxs / xxl) without changing library API

If your app needs finer spacing than `xs ~ xl` but you do not want to modify `MiniSpacingTokens`, you can wrap it on the app side:

```dart
import 'package:miniui/miniui.dart';

class ExtendedSpacing {
  final MiniSpacingTokens core;
  final double xxs;
  final double xxl;

  const ExtendedSpacing({
    required this.core,
    required this.xxs,
    required this.xxl,
  });
}

// Extend MiniUi’s default spacing with xxs / xxl
const ExtendedSpacing kExtendedSpacing = ExtendedSpacing(
  core: MiniThemes.defaultSpacing,
  xxs: 2,
  xxl: 40,
);
```

Usage:

```dart
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: kExtendedSpacing.xxl,
    vertical: kExtendedSpacing.core.sm,
  ),
  child: ...,
)
```

MiniUi components still rely only on `theme.spacing.xs ~ xl`, keeping the library API stable, while your own widgets can opt into `xxs / xxl`.

---

## Advanced: Overlay & Size Preset Helpers

### Overlay helper: `miniShowOverlayEntry`

Toast / snackbar‑style overlays share a unified helper in the core layer:

```dart
Future<void> miniShowOverlayEntry({
  required OverlayState overlay,
  required Duration duration,
  required WidgetBuilder builder,
}) async {
  final OverlayEntry entry = OverlayEntry(builder: builder);

  overlay.insert(entry);
  await Future<void>.delayed(duration);

  if (entry.mounted) {
    entry.remove();
  }
}
```

`MiniToast.show` and `MiniSnackbar.show` both reuse this. You can use it for custom overlays as well:

```dart
Future<void> showCustomBanner(BuildContext context, String text) {
  final overlay = Overlay.of(context);
  if (overlay == null) return Future.value();

  final theme = MiniThemeProvider.of(context);

  return miniShowOverlayEntry(
    overlay: overlay,
    duration: const Duration(seconds: 2),
    builder: (context) {
      return Positioned(
        left: theme.spacing.lg,
        right: theme.spacing.lg,
        top: theme.spacing.lg,
        child: MiniCard(
          child: MiniText(text),
        ),
      );
    },
  );
}
```

### Size presets: `MiniSizePreset` (spacing / radius / typography / component sizes)

Size‑related tokens can be grouped as a `MiniSizePreset`:

```dart
class MiniSizePreset {
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;
  final MiniComponentSizeTokens componentSizes;

  const MiniSizePreset({
    required this.spacing,
    required this.radius,
    required this.typography,
    required this.componentSizes,
  });
}
```

`MiniThemes` internally maps `default / compact / rounded` themes to different presets. You can define your own:

```dart
const MiniSizePreset densePreset = MiniSizePreset(
  spacing: MiniSpacingTokens(xs: 2, sm: 6, md: 10, lg: 14, xl: 18),
  radius: MiniRadiusTokens(
    small: BorderRadius.all(Radius.circular(2)),
    medium: BorderRadius.all(Radius.circular(6)),
    large: BorderRadius.all(Radius.circular(10)),
    pill: BorderRadius.all(Radius.circular(999)),
  ),
  typography: MiniTypographyTokens(
    body: TextStyle(fontSize: 14),
    small: TextStyle(fontSize: 12),
    title: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    heading: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  ),
  componentSizes: MiniComponentSizeTokens(
    buttonPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    inputPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  ),
);
```

Then reuse it in a custom theme:

```dart
const MiniTheme denseTheme = MiniTheme(
  name: 'dense',
  brightness: Brightness.light,
  colors: MiniColorTokens(
    primary: Color(0xFF0066FF),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF111827),
    accent: Color(0xFF10B981),
    danger: Color(0xFFEF4444),
  ),
  spacing: densePreset.spacing,
  radius: densePreset.radius,
  typography: densePreset.typography,
  componentSizes: densePreset.componentSizes,
);
```

This decouples **size style** from **color style**: brand colors can change independently from compact/comfortable size presets.

---

## Components Overview

All components are exported via [`lib/miniui.dart`](lib/miniui.dart):

```dart
import 'package:miniui/miniui.dart';
```

- Core
  - `MiniTheme` / `MiniThemes`
  - `MiniThemeController` / `MiniThemeProvider`
  - `BaseComponent`

- Display
  - `MiniText`
  - `MiniCard`
  - `MiniImage`
  - `MiniTag`
  - `MiniEmpty`
  - `MiniLoading`

- Input / form
  - `MiniButton` (primary / ghost / danger)
  - `MiniInput`
  - `MiniCheckbox`
  - `MiniSwitch`
  - `MiniStepper`
  - `MiniSearchBar`

- List
  - `MiniDivider`
  - `MiniListItem`

- Data display
  - `MiniAvatar`
  - `MiniBadge`
  - `MiniSkeleton`

- Navigation & layout
  - `MiniAppBar`
  - `MiniTabBar`
  - `MiniPageScaffold`

- Feedback
  - `MiniToast.show(context, message)`
  - `MiniDialog`
  - `MiniActionSheet`
  - `MiniSnackbar`
  - `MiniLoadingOverlay`

---

## Demo Pages

[`example/lib/main.dart`](example/lib/main.dart) wires up the demo routes:

- `/` → `MiniHomePage`
- `/list-demo` → `MiniListDemoPage`
- `/tokens` → `MiniTokensPage`
- `/layout-demo` → `MiniLayoutDemoPage`
- `/feedback-demo` → `MiniFeedbackDemoPage`

Key pages:

- **MiniHomePage** (`example/lib/demo/home_page.dart`)
  - Theme card (switch themes: light / dark / blue / red / festival)
  - Basic components: input / button / tag / loading
  - Form: `MiniCheckbox + MiniSwitch`
  - List & toast: `MiniListItem + MiniDivider`, `MiniToast.show` on tap
  - Buttons linking to List / Tokens / Layout / Feedback demos

- **MiniListDemoPage** (`example/lib/demo/list_page.dart`)
  - Full `MiniListItem` list with dividers
  - Top back area (‹) using `Navigator.pop`
  - `MiniToast` on tap

- **MiniTokensPage** (`example/lib/demo/tokens_page.dart`)
  - Visual color tokens
  - Spacing (xs–xl) comparison
  - Radius variations
  - Typography samples

- **MiniLayoutDemoPage** (`example/lib/demo/layout_page.dart`)
  - Combination of `MiniPageScaffold + MiniAppBar + MiniTabBar + MiniSegmentedControl`

- **MiniFeedbackDemoPage** (`example/lib/demo/feedback_page.dart`)
  - `MiniDialog / MiniActionSheet / MiniSnackbar / MiniLoadingOverlay`
  - `MiniBadge / MiniAvatar / MiniSkeleton`

---

## Development & Debugging

### Run the demo app

At project root:

```bash
flutter run -t example/lib/main.dart
```

This uses `example/lib/main.dart` as entry and runs the full demo.

To target a specific device:

```bash
# Web (Chrome)
flutter run -t example/lib/main.dart -d chrome

# iOS simulator
flutter run -t example/lib/main.dart -d ios

# Android emulator / device
flutter run -t example/lib/main.dart -d android
```

Prerequisites:

- Platform SDKs installed (Chrome / Xcode / Android SDK, etc.)
- For Web: `flutter config --enable-web`

---

## Testing

This repo includes minimal tests covering component behavior and token consistency:

- `test/mini_button_test.dart`  
  - Verifies `MiniButton` renders its label and responds to taps.
- `test/mini_theme_tokens_test.dart`  
  - Verifies `MiniThemes.light.spacing` is strictly increasing from `xs` to `xl`.  
  - Verifies `MiniThemes.light.brightness != MiniThemes.dark.brightness`.

Run tests at project root:

```bash
flutter test
```

---

## Use MiniUi as SDK in Another Project

Once MiniUi is added as a dependency, you can integrate it like this:

```dart
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

void main() {
  final controller = MiniThemeController(initialTheme: MiniThemes.light);
  runApp(MyHostApp(controller: controller));
}

class MyHostApp extends StatelessWidget {
  final MiniThemeController controller;

  const MyHostApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = controller.theme;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: MiniThemeProvider(
        theme: theme,
        child: WidgetsApp(
          color: theme.colors.background,
          builder: (context, _) {
            return Center(
              child: MiniButton(
                label: 'Hello MiniUi',
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
```

This lets you reuse MiniUi’s “no‑Material, multi‑theme” components inside any Flutter project.