# MiniUi

一个基于 Flutter `widgets` 层的超轻量 UI 组件库，用于探索：

- 完全不依赖 `material.dart`
- 多主题（浅色 / 深色 / 蓝色 / 红色 / 节日…）统一管理
- 可作为 SDK / 组件库跨项目复用
- 纯 Token 驱动的设计系统（Color / Spacing / Radius / Typography）

当前仓库同时包含组件实现与可视化 Demo（通过 `example/` 示例应用运行）。

---

## 功能特性概览

- 无 Material 依赖  
  - 所有入口基于 `WidgetsApp` + `Directionality`  
  - 组件只依赖 `package:flutter/widgets.dart`

- 多主题 + Token 体系  
  - `MiniTheme`：聚合 Color / Spacing / Radius / Typography 多类 Token  
  - 内置主题：`light / dark / blue / red / festival`  
  - `MiniThemeController`：全局主题状态管理，支持热切换

- 纯组件化封装  
  - 基础展示：`MiniText / MiniCard / MiniImage / MiniTag / MiniEmpty / MiniLoading`  
  - 交互输入：`MiniButton / MiniInput`  
  - 表单控件：`MiniCheckbox / MiniRadio / MiniSwitch / MiniStepper / MiniSearchBar`  
  - 列表骨架：`MiniDivider / MiniListItem`  
  - 导航与布局：`MiniAppBar / MiniTabBar / MiniPageScaffold`  
  - 反馈：`MiniToast / MiniDialog / MiniActionSheet / MiniSnackbar / MiniLoadingOverlay`

- Demo 页面  
  - 首页：主题切换 + 基础组件 + 表单示例 + 列表 & Toast 示例  
  - 列表页：全屏 `MiniListItem` 列表骨架  
  - Token 页：颜色 / 间距 / 圆角 / 字体 Token 可视化

---

## 快速上手

### 依赖声明（假设已发布到 pub.dev）

在你的宿主应用 `pubspec.yaml` 中添加：

```yaml
dependencies:
  flutter:
    sdk: flutter

  miniui: ^1.0.0
```

### 最小使用示例（不依赖 `material.dart`）

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

上面这段代码完成了：

- 使用 `MiniThemeController` 管理当前主题；
- 通过 `MiniThemeProvider` 注入主题；
- 使用 `MiniButton` 渲染一个按钮。

更完整的用法可以参考下文「在其他项目中作为 SDK 使用」一节，以及 `example/` 目录中的示例应用。

---

## 项目结构（核心部分）

```text
lib/
  core/
    base/
      base_component.dart   # MiniThemeController / MiniThemeProvider / BaseComponent
    painters/
      loading_painter.dart  # 加载动效画笔
    utils/
      tokens.dart           # MiniTheme + Color/Spacing/Radius/Typography Tokens

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

  miniui.dart         # 对外统一导出入口（模拟 SDK 用法）

example/
  lib/
    main.dart         # 示例应用入口（完整 Demo：home / list / tokens / layout / feedback）
    demo/
      home_page.dart    # 首页 Demo
      list_page.dart    # 列表页 Demo
      tokens_page.dart  # Theme Tokens 展示页
      layout_page.dart  # 布局与导航示例
      feedback_page.dart# 反馈组件示例

  example.dart       # 精简版使用示例（可选）
```

---

## 主题与 Token 体系

### MiniTheme 与 Tokens

主题定义集中在 [`lib/core/utils/tokens.dart`](lib/core/utils/tokens.dart)：

- `MiniColorTokens`
- `MiniSpacingTokens`
- `MiniRadiusTokens`
- `MiniTypographyTokens`
- `MiniTheme`（聚合以上 Tokens）
- `MiniThemes`（内置多套主题）

示例（简化）：

```dart
class MiniTheme {
  final String name;
  final Brightness brightness;
  final MiniColorTokens colors;
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;
}
```

组件内部统一从 `MiniTheme` 获取设计值，例如：

- 间距：`theme.spacing.md`
- 圆角：`theme.radius.medium`
- 字体：`theme.typography.body`
- 颜色：`theme.colors.primary / background / foreground ...`

### 主题控制与注入

[`lib/core/base/base_component.dart`](lib/core/base/base_component.dart) 提供：

- `MiniThemeController`：可热切换主题（`setTheme` / `setThemeByName`）
- `MiniThemeProvider`：`InheritedWidget` 注入 `MiniTheme`
- `BaseComponent`：所有组件统一继承，可直接通过 `themeOf(context)` 拿到当前主题

使用方式（在 app 根部）：

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

### 自定义皮肤 / 自定义主题 Token 示例

在内置 `light / dark / blue / red / festival / glass` 之外，你可以基于 Token 定义一套自己的品牌皮肤，例如：

```dart
import 'package:flutter/widgets.dart';
import 'package:miniui/miniui.dart';

// 定义一套自定义主题 Token
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
  // 使用自定义主题作为初始皮肤，并将其加入可选皮肤列表
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

这样一来：

- 组件内部会自动读取 `brandTheme` 中的颜色 / 间距 / 圆角 / 排版 Token；
- Demo 或宿主应用中可以通过 `MiniThemeController` 在内置主题和自定义皮肤之间切换；
- 你也可以按同样方式定义多套品牌皮肤，再统一放入 `availableThemes` 中管理。

---

## 组件一览

所有组件通过 [`lib/miniui.dart`](lib/miniui.dart) 对外导出：

```dart
import 'package:miniui/miniui.dart';
```

- 核心
  - `MiniTheme` / `MiniThemes`
  - `MiniThemeController` / `MiniThemeProvider`
  - `BaseComponent`

- 展示类
  - `MiniText`
  - `MiniCard`
  - `MiniImage`
  - `MiniTag`
  - `MiniEmpty`
  - `MiniLoading`

- 交互 / 表单
  - `MiniButton`（primary / ghost / danger）
  - `MiniInput`
  - `MiniCheckbox`
  - `MiniRadio<T>`
  - `MiniSwitch`
  - `MiniStepper`
  - `MiniSearchBar`

- 列表
  - `MiniDivider`
  - `MiniListItem`

- 数据展示
  - `MiniAvatar`
  - `MiniBadge`
  - `MiniSkeleton`

- 导航与布局
  - `MiniAppBar`
  - `MiniTabBar`
  - `MiniPageScaffold`

- 反馈
  - `MiniToast.show(context, message)`
  - `MiniDialog`
  - `MiniActionSheet`
  - `MiniSnackbar`
  - `MiniLoadingOverlay`

---

## Demo 页面说明

### 路由结构

[`example/lib/main.dart`](example/lib/main.dart) 使用 `WidgetsApp.onGenerateRoute` 管理页面：

- `/` → `MiniHomePage`
- `/list-demo` → `MiniListDemoPage`
- `/tokens` → `MiniTokensPage`
- `/layout-demo` → `MiniLayoutDemoPage`
- `/feedback-demo` → `MiniFeedbackDemoPage`

### MiniHomePage

入口文件：[`example/lib/demo/home_page.dart`](example/lib/demo/home_page.dart)

包含：

- 主题卡片：展示当前主题名称 + 主题切换按钮（light/dark/blue/red/festival）
- 基础组件示例：输入框 / Button / Tag / Loading
- 表单示例：`MiniCheckbox + MiniRadio + MiniSwitch`
- 列表与 Toast 示例：
  - `MiniListItem + MiniDivider`
  - 点击列表项或按钮时，通过 `MiniToast.show` 弹出提示
  - 提供入口按钮跳转到「列表页示例」「主题 Tokens 示例」「布局与导航示例」「反馈组件示例」

### MiniListDemoPage

入口文件：[`example/lib/demo/list_page.dart`](example/lib/demo/list_page.dart)

- 显示一组 `MiniListItem` + `MiniDivider` 构成的完整列表页骨架  
- 顶部有返回区域（`‹ 返回`），点击 `Navigator.pop()` 回首页  
- 点击任意列表项，底部弹出 `MiniToast` 提示

### MiniTokensPage

入口文件：[`example/lib/demo/tokens_page.dart`](example/lib/demo/tokens_page.dart)

- Colors：展示当前主题的一组颜色 Token 色块  
- Spacing：展示 xs–xl 对应的数值和高度对比  
- Radius：展示 small / medium / large / pill 不同圆角盒子  
- Typography：展示 heading / title / body / small 四种文字样式

### MiniLayoutDemoPage

入口文件：[`example/lib/demo/layout_page.dart`](example/lib/demo/layout_page.dart)

- 演示 `MiniPageScaffold + MiniAppBar + MiniTabBar + MiniSegmentedControl` 的组合使用  
- 顶部 SegmentedControl 切换 Segment，底部 TabBar 模拟主导航

### MiniFeedbackDemoPage

入口文件：[`example/lib/demo/feedback_page.dart`](example/lib/demo/feedback_page.dart)

- `MiniDialog` / `MiniActionSheet` / `MiniSnackbar` / `MiniLoadingOverlay` 等反馈组件示例  
- `MiniBadge` / `MiniAvatar` / `MiniSkeleton` 状态与占位骨架示例

---

## 开发与调试

### 在本仓库中运行完整 Demo 应用

在项目根目录执行：

```bash
flutter run -t example/lib/main.dart
```

该命令会使用 `example/lib/main.dart` 作为入口，运行包含 `home / list / tokens / layout / feedback` 的完整示例应用。

如需以 Web 或特定设备运行，可以指定设备：

```bash
# Web（Chrome）
flutter run -t example/lib/main.dart -d chrome

# iOS 模拟器
flutter run -t example/lib/main.dart -d ios

# Android 模拟器
flutter run -t example/lib/main.dart -d android
```

前提：

- 已安装对应平台的开发环境（Chrome / Xcode / Android SDK 等）
- Flutter 已启用 Web 时，需执行过：`flutter config --enable-web`

---

## 测试

本仓库内置了一些最小化的测试示例，覆盖组件渲染与主题 Token 一致性：

- 组件测试：`test/mini_button_test.dart`  
  - 验证 `MiniButton` 能正确渲染文案并响应点击。
- 主题 Token 测试：`test/mini_theme_tokens_test.dart`  
  - 验证 `MiniThemes.light` 的间距从 `xs` 到 `xl` 递增。  
  - 验证 `MiniThemes.light` 与 `MiniThemes.dark` 的亮度配置不同。

在项目根目录执行：

```bash
flutter test
```

即可运行全部测试用例。

## 在其他项目中作为 SDK 使用（示例）

假设本库作为 package 引入后，可以这样集成：

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

这样就可以在任意 Flutter 工程中，以「无 Material、可多主题」的方式复用 MiniUi 提供的底层组件。  
