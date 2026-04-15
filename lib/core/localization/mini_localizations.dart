import 'package:flutter/widgets.dart';

class MiniLocalizations {
  final Locale locale;

  const MiniLocalizations(this.locale);

  static const LocalizationsDelegate<MiniLocalizations> delegate =
      _MiniLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('zh'),
    Locale('en'),
  ];

  static MiniLocalizations of(BuildContext context) {
    return Localizations.of<MiniLocalizations>(
          context,
          MiniLocalizations,
        ) ??
        const MiniLocalizations(Locale('en'));
  }

  bool get _isZh => locale.languageCode.toLowerCase() == 'zh';

  String get backLabel => _isZh ? '返回' : 'Back';
  String get confirmLabel => _isZh ? '确认' : 'Confirm';
  String get cancelLabel => _isZh ? '取消' : 'Cancel';
  String get searchPlaceholder => _isZh ? '搜索' : 'Search';
  String get formSubmit => _isZh ? '提交' : 'Submit';
  String get listViewTitle => _isZh ? '列表页示例' : 'List demo';
  String get tabViewTitle =>
      _isZh ? '标签 + PageView 示例' : 'TabBar + PageView demo';
  String get emptyMessage => _isZh ? '暂无数据' : 'No data';
  String get formDemoTitle => _isZh ? '表单示例' : 'Form demo';
  String get feedbackDemoTitle =>
      _isZh ? '反馈组件示例' : 'Feedback components';
  String get layoutDemoTitle =>
      _isZh ? '布局与导航示例' : 'Layout & navigation demo';
  String get homeOpenListDemo =>
      _isZh ? '列表页示例' : 'List demo';
  String get homeOpenTokensDemo =>
      _isZh ? '主题 Tokens 示例' : 'Tokens demo';
  String get homeOpenLayoutDemo =>
      _isZh ? '布局与导航示例' : 'Layout & navigation demo';
  String get homeOpenFeedbackDemo =>
      _isZh ? '反馈组件示例' : 'Feedback demo';
  String get homeOpenCustomTokensDemo =>
      _isZh ? '自定义外观示例' : 'Custom appearance demo';
  String get homeOpenTabViewDemo =>
      _isZh ? 'Tab + PageView 示例' : 'Tab + PageView demo';
  String get homeOpenFormDemo =>
      _isZh ? '表单示例' : 'Form demo';
  String get homeOpenSliverDemo =>
      _isZh ? 'Sliver 列表示例' : 'Sliver list demo';
  String get homeOpenGridDemo =>
      _isZh ? '宫格示例' : 'Grid demo';
  String get homeOpenProfileDemo =>
      _isZh ? '会员中心模版' : 'Profile template';
  String get homeOpenResultDemo =>
      _isZh ? '结果态示例' : 'Result demo';
  String get homeOpenBottomNavDemo =>
      _isZh ? '底部导航模版' : 'Bottom nav demo';
  String get homeComponentExamplesTitle =>
      _isZh ? '组件示例' : 'Component examples';
  String get homeFormExamplesTitle =>
      _isZh ? '表单示例' : 'Form examples';
  String get homeListToastExamplesTitle =>
      _isZh ? '列表与 Toast 示例' : 'List & Toast examples';
  String get primaryLabel => _isZh ? '主按钮' : 'Primary';
  String get ghostLabel => _isZh ? '幽灵按钮' : 'Ghost';
  String get dangerLabel => _isZh ? '危险' : 'Danger';
  String get tagLabel => _isZh ? '标签' : 'Tag';
  String get statusLabel => _isZh ? '状态' : 'Status';
  String get homeInputPlaceholder =>
      _isZh ? '输入一些文字' : 'Type something';
  String get homeAgreeTerms =>
      _isZh ? '我已阅读并同意协议' : 'I have read and agree to the terms';
  String get homeOptionA => _isZh ? '选项 A' : 'Option A';
  String get homeOptionB => _isZh ? '选项 B' : 'Option B';
  String get homeReceivePush =>
      _isZh ? '接收推送通知' : 'Receive push notifications';
  String get homeAccountSecurityTitle =>
      _isZh ? '账号安全' : 'Account security';
  String get homeAccountSecuritySubtitle =>
      _isZh ? '密码与登录设备管理' : 'Password & device management';
  String get homeRecommendedTag =>
      _isZh ? '推荐' : 'Recommended';
  String get homeNotificationsTitle =>
      _isZh ? '消息通知' : 'Notifications';
  String get homeNotificationsSubtitle =>
      _isZh ? '应用内消息与推送' : 'In-app messages & push';
  String get homeShowToastTitle =>
      _isZh ? '显示 Toast' : 'Show Toast';
  String get homeShowToastSubtitle =>
      _isZh ? '在底部弹出一条轻量提示' : 'Show a lightweight message at the bottom';
  String get homeToastAccountSecurity =>
      _isZh ? '点击了账号安全' : 'Tapped Account security';
  String get homeToastNotifications =>
      _isZh ? '点击了消息通知' : 'Tapped Notifications';
  String get homeToastGeneric =>
      _isZh ? '这是一条 MiniToast 提示' : 'This is a MiniToast message';
}

class _MiniLocalizationsDelegate
    extends LocalizationsDelegate<MiniLocalizations> {
  const _MiniLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return MiniLocalizations.supportedLocales
        .any((Locale l) => l.languageCode == locale.languageCode);
  }

  @override
  Future<MiniLocalizations> load(Locale locale) async {
    return MiniLocalizations(locale);
  }

  @override
  bool shouldReload(_MiniLocalizationsDelegate old) => false;
}
