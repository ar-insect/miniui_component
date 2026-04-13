import 'package:flutter/widgets.dart';

/// Semantic color tokens used to represent primary/background/foreground colors.
class MiniColorTokens {
  final Color primary;
  final Color background;
  final Color foreground;
  final Color accent;
  final Color danger;

  const MiniColorTokens({
    required this.primary,
    required this.background,
    required this.foreground,
    required this.accent,
    required this.danger,
  });

  static MiniColorTokens lerp(
    MiniColorTokens a,
    MiniColorTokens b,
    double t,
  ) {
    return MiniColorTokens(
      primary: Color.lerp(a.primary, b.primary, t) ?? b.primary,
      background: Color.lerp(a.background, b.background, t) ?? b.background,
      foreground: Color.lerp(a.foreground, b.foreground, t) ?? b.foreground,
      accent: Color.lerp(a.accent, b.accent, t) ?? b.accent,
      danger: Color.lerp(a.danger, b.danger, t) ?? b.danger,
    );
  }
}

/// Semantic spacing tokens from xs to xl, used to drive layout spacing.
class MiniSpacingTokens {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const MiniSpacingTokens({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  MiniSpacingTokens copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return MiniSpacingTokens(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  static MiniSpacingTokens lerp(
    MiniSpacingTokens a,
    MiniSpacingTokens b,
    double t,
  ) {
    double lerpDouble(double x, double y) => x + (y - x) * t;

    return MiniSpacingTokens(
      xs: lerpDouble(a.xs, b.xs),
      sm: lerpDouble(a.sm, b.sm),
      md: lerpDouble(a.md, b.md),
      lg: lerpDouble(a.lg, b.lg),
      xl: lerpDouble(a.xl, b.xl),
    );
  }
}

/// Corner radius tokens used to unify corner styles across components.
class MiniRadiusTokens {
  final BorderRadius small;
  final BorderRadius medium;
  final BorderRadius large;
  final BorderRadius pill;

  const MiniRadiusTokens({
    required this.small,
    required this.medium,
    required this.large,
    required this.pill,
  });

  MiniRadiusTokens copyWith({
    BorderRadius? small,
    BorderRadius? medium,
    BorderRadius? large,
    BorderRadius? pill,
  }) {
    return MiniRadiusTokens(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      pill: pill ?? this.pill,
    );
  }

  static MiniRadiusTokens lerp(
    MiniRadiusTokens a,
    MiniRadiusTokens b,
    double t,
  ) {
    return MiniRadiusTokens(
      small: BorderRadius.lerp(a.small, b.small, t) ?? b.small,
      medium: BorderRadius.lerp(a.medium, b.medium, t) ?? b.medium,
      large: BorderRadius.lerp(a.large, b.large, t) ?? b.large,
      pill: BorderRadius.lerp(a.pill, b.pill, t) ?? b.pill,
    );
  }
}

/// Typography tokens used to unify text sizes and weights.
class MiniTypographyTokens {
  final TextStyle body;
  final TextStyle small;
  final TextStyle title;
  final TextStyle heading;

  const MiniTypographyTokens({
    required this.body,
    required this.small,
    required this.title,
    required this.heading,
  });

  MiniTypographyTokens copyWith({
    TextStyle? body,
    TextStyle? small,
    TextStyle? title,
    TextStyle? heading,
  }) {
    return MiniTypographyTokens(
      body: body ?? this.body,
      small: small ?? this.small,
      title: title ?? this.title,
      heading: heading ?? this.heading,
    );
  }

  static MiniTypographyTokens lerp(
    MiniTypographyTokens a,
    MiniTypographyTokens b,
    double t,
  ) {
    return MiniTypographyTokens(
      body: TextStyle.lerp(a.body, b.body, t) ?? b.body,
      small: TextStyle.lerp(a.small, b.small, t) ?? b.small,
      title: TextStyle.lerp(a.title, b.title, t) ?? b.title,
      heading: TextStyle.lerp(a.heading, b.heading, t) ?? b.heading,
    );
  }
}

class MiniComponentSizeTokens {
  final EdgeInsets buttonPadding;
  final EdgeInsets inputPadding;

  /// Component-level size tokens for controls such as buttons and inputs.
  ///
  /// - [buttonPadding]: controls overall button height and horizontal padding.
  /// - [inputPadding]: controls overall input height and horizontal padding.
  ///
  /// Unlike [MiniSpacingTokens] (which is layout spacing), this describes
  /// component sizes so themes can switch between dense / relaxed styles.
  const MiniComponentSizeTokens({
    required this.buttonPadding,
    required this.inputPadding,
  });

  MiniComponentSizeTokens copyWith({
    EdgeInsets? buttonPadding,
    EdgeInsets? inputPadding,
  }) {
    return MiniComponentSizeTokens(
      buttonPadding: buttonPadding ?? this.buttonPadding,
      inputPadding: inputPadding ?? this.inputPadding,
    );
  }

  static MiniComponentSizeTokens lerp(
    MiniComponentSizeTokens a,
    MiniComponentSizeTokens b,
    double t,
  ) {
    return MiniComponentSizeTokens(
      buttonPadding: EdgeInsets.lerp(a.buttonPadding, b.buttonPadding, t) ??
          b.buttonPadding,
      inputPadding:
          EdgeInsets.lerp(a.inputPadding, b.inputPadding, t) ?? b.inputPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MiniComponentSizeTokens &&
            runtimeType == other.runtimeType &&
            buttonPadding == other.buttonPadding &&
            inputPadding == other.inputPadding;
  }

  @override
  int get hashCode => Object.hash(buttonPadding, inputPadding);
}

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

/// Aggregates color / spacing / radius / typography / component-size tokens
/// into a complete theme.
class MiniTheme {
  final String name;
  final Brightness brightness;
  final MiniColorTokens colors;
  final MiniSpacingTokens spacing;
  final MiniRadiusTokens radius;
  final MiniTypographyTokens typography;
  final MiniComponentSizeTokens componentSizes;

  const MiniTheme({
    required this.name,
    required this.brightness,
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.typography,
    required this.componentSizes,
  });

  MiniTheme copyWith({
    String? name,
    Brightness? brightness,
    MiniColorTokens? colors,
    MiniSpacingTokens? spacing,
    MiniRadiusTokens? radius,
    MiniTypographyTokens? typography,
    MiniComponentSizeTokens? componentSizes,
  }) {
    return MiniTheme(
      name: name ?? this.name,
      brightness: brightness ?? this.brightness,
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      componentSizes: componentSizes ?? this.componentSizes,
    );
  }

  static MiniTheme lerp(
    MiniTheme a,
    MiniTheme b,
    double t,
  ) {
    // Use different curves for each token group to make theme transitions
    // feel smoother and less mechanical.
    final double colorT = Curves.easeInOutCubic.transform(t);
    final double spacingT = Curves.easeOutCubic.transform(t);
    final double radiusT = Curves.easeOut.transform(t);
    final double typographyT = Curves.easeInOut.transform(t);
    final double componentSizeT = spacingT;

    // Avoid flipping brightness midway; delay it until 0.75 to reduce flicker.
    const double brightnessFlipPoint = 0.75;
    final Brightness brightness =
        t < brightnessFlipPoint ? a.brightness : b.brightness;

    return MiniTheme(
      name: t < 0.5 ? a.name : b.name,
      brightness: brightness,
      colors: MiniColorTokens.lerp(a.colors, b.colors, colorT),
      spacing: MiniSpacingTokens.lerp(a.spacing, b.spacing, spacingT),
      radius: MiniRadiusTokens.lerp(a.radius, b.radius, radiusT),
      typography: MiniTypographyTokens.lerp(
        a.typography,
        b.typography,
        typographyT,
      ),
      componentSizes: MiniComponentSizeTokens.lerp(
        a.componentSizes,
        b.componentSizes,
        componentSizeT,
      ),
    );
  }
}

/// Built-in theme factory: bundles default spacing/radius/typography and
/// several color palettes.
class MiniThemes {
  static const MiniComponentSizeTokens defaultComponentSizes =
      MiniComponentSizeTokens(
    buttonPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    inputPadding: EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 10,
    ),
  );

  static const MiniComponentSizeTokens compactComponentSizes =
      MiniComponentSizeTokens(
    buttonPadding: EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 6,
    ),
    inputPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 6,
    ),
  );

  static const MiniComponentSizeTokens roundedComponentSizes =
      MiniComponentSizeTokens(
    buttonPadding: EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 12,
    ),
    inputPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  );

  static const MiniSpacingTokens defaultSpacing = MiniSpacingTokens(
    xs: 4,
    sm: 10,
    md: 14,
    lg: 20,
    xl: 28,
  );

  static const MiniSpacingTokens compactSpacing = MiniSpacingTokens(
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
  );

  static const MiniSpacingTokens roundedSpacing = MiniSpacingTokens(
    xs: 4,
    sm: 12,
    md: 16,
    lg: 24,
    xl: 32,
  );

  static const MiniRadiusTokens defaultRadius = MiniRadiusTokens(
    small: BorderRadius.all(Radius.circular(4)),
    medium: BorderRadius.all(Radius.circular(10)),
    large: BorderRadius.all(Radius.circular(16)),
    pill: BorderRadius.all(Radius.circular(999)),
  );

  static const MiniRadiusTokens compactRadius = MiniRadiusTokens(
    small: BorderRadius.all(Radius.circular(2)),
    medium: BorderRadius.all(Radius.circular(6)),
    large: BorderRadius.all(Radius.circular(10)),
    pill: BorderRadius.all(Radius.circular(999)),
  );

  static const MiniRadiusTokens roundedRadius = MiniRadiusTokens(
    small: BorderRadius.all(Radius.circular(6)),
    medium: BorderRadius.all(Radius.circular(16)),
    large: BorderRadius.all(Radius.circular(24)),
    pill: BorderRadius.all(Radius.circular(999)),
  );

  static const MiniTypographyTokens defaultTypography = MiniTypographyTokens(
    body: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    small: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    title: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    heading: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
  );

  static const MiniTypographyTokens compactTypography = MiniTypographyTokens(
    body: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    small: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    title: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    heading: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  );

  static const MiniTypographyTokens roundedTypography = MiniTypographyTokens(
    body: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    small: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    title: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    heading: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
  );

  static final MiniTheme light = MiniTheme(
    name: 'light',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF0066FF),
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF000000),
      accent: Color(0xFF00C853),
      danger: Color(0xFFD50000),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
    componentSizes: defaultComponentSizes,
  );

  static final MiniTheme dark = MiniTheme(
    name: 'dark',
    brightness: Brightness.dark,
    colors: const MiniColorTokens(
      primary: Color(0xFF82B1FF),
      background: Color(0xFF121212),
      foreground: Color(0xFFFFFFFF),
      accent: Color(0xFF00E676),
      danger: Color(0xFFFF5252),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
    componentSizes: defaultComponentSizes,
  );

  static final MiniTheme blue = MiniTheme(
    name: 'blue',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF1565C0),
      background: Color(0xFFE3F2FD),
      foreground: Color(0xFF0D47A1),
      accent: Color(0xFF64B5F6),
      danger: Color(0xFFC62828),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
    componentSizes: defaultComponentSizes,
  );

  static final MiniTheme red = MiniTheme(
    name: 'red',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFFC62828),
      background: Color(0xFFFFEBEE),
      foreground: Color(0xFFB71C1C),
      accent: Color(0xFFEF5350),
      danger: Color(0xFFB71C1C),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
    componentSizes: defaultComponentSizes,
  );

  static final MiniTheme festival = MiniTheme(
    name: 'festival',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFFFF6D00),
      background: Color(0xFFFFF3E0),
      foreground: Color(0xFF4E342E),
      accent: Color(0xFFFFD600),
      danger: Color(0xFFD50000),
    ),
    spacing: defaultSpacing,
    radius: defaultRadius,
    typography: defaultTypography,
    componentSizes: defaultComponentSizes,
  );

  static final MiniTheme compact = MiniTheme(
    name: 'compact',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF0066FF),
      background: Color(0xFFF9FAFB),
      foreground: Color(0xFF111827),
      accent: Color(0xFF10B981),
      danger: Color(0xFFEF4444),
    ),
    spacing: compactSpacing,
    radius: compactRadius,
    typography: compactTypography,
    componentSizes: compactComponentSizes,
  );

  static final MiniTheme rounded = MiniTheme(
    name: 'rounded',
    brightness: Brightness.light,
    colors: const MiniColorTokens(
      primary: Color(0xFF2563EB),
      background: Color(0xFFF3F4F6),
      foreground: Color(0xFF111827),
      accent: Color(0xFF22C55E),
      danger: Color(0xFFDC2626),
    ),
    spacing: roundedSpacing,
    radius: roundedRadius,
    typography: roundedTypography,
    componentSizes: roundedComponentSizes,
  );

  static final List<MiniTheme> all = <MiniTheme>[
    light,
    dark,
    blue,
    red,
    festival,
    compact,
    rounded,
  ];
}
