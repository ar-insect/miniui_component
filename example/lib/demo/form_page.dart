import 'package:flutter/widgets.dart';
import 'package:miniui_component/miniui.dart';

class MiniFormDemoPage extends StatefulWidget {
  static const String routeName = '/form-demo';

  const MiniFormDemoPage({super.key});

  @override
  State<MiniFormDemoPage> createState() => _MiniFormDemoPageState();
}

class _MiniFormDemoPageState extends State<MiniFormDemoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _agreed = false;
   String? _nameError;
   String? _emailError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    String? nameError;
    String? emailError;

    if (_nameController.text.trim().isEmpty) {
      nameError = 'Name is required';
    }

    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      emailError = 'Email is required';
    } else if (!email.contains('@')) {
      emailError = 'Please enter a valid email';
    }

    setState(() {
      _nameError = nameError;
      _emailError = emailError;
    });

    if (nameError != null || emailError != null || !_agreed) {
      MiniToast.show(
        _formKey.currentContext!,
        !_agreed ? 'Please accept the terms' : 'Please fix the errors above',
      );
      return;
    }

    MiniToast.show(
      _formKey.currentContext!,
      'Form submitted: ${_nameController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final MiniTheme theme = MiniThemeProvider.of(context);
    final MiniLocalizations i18n = MiniLocalizations.of(context);

    return MiniPageScaffold(
      appBar: MiniAppBar(
        leading: const MiniBackButton(),
        title: MiniText('Form demo'),
        centerTitle: true,
      ),
      body: Container(
        color: theme.colors.background,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(theme.spacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MiniText(
                  'Sign up',
                  style: theme.typography.heading.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.md),
                MiniInput(
                  initialValue: '',
                  placeholder: 'Name',
                  onChanged: (String value) {
                    _nameController.text = value;
                  },
                ),
              if (_nameError != null) ...<Widget>[
                SizedBox(height: theme.spacing.xs),
                MiniText(
                  _nameError!,
                  style: theme.typography.small.copyWith(
                    color: theme.colors.danger.withValues(alpha: 0.9),
                  ),
                ),
              ],
                SizedBox(height: theme.spacing.md),
                MiniInput(
                  initialValue: '',
                  placeholder: 'Email',
                  onChanged: (String value) {
                    _emailController.text = value;
                  },
                ),
              SizedBox(height: theme.spacing.xs),
              if (_emailError != null)
                MiniText(
                  _emailError!,
                  style: theme.typography.small.copyWith(
                    color: theme.colors.danger.withValues(alpha: 0.9),
                  ),
                )
              else
                MiniText(
                  'We will never share your email.',
                  style: theme.typography.small.copyWith(
                    color: theme.colors.foreground.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: theme.spacing.lg),
                MiniText(
                  'About you',
                  style: theme.typography.title.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
                SizedBox(height: theme.spacing.xs),
                MiniTextArea(
                  placeholder: 'Tell us a bit more about yourself',
                  minLines: 3,
                  maxLines: 5,
                  onChanged: (_) {},
                ),
                SizedBox(height: theme.spacing.lg),
                MiniCheckbox(
                  value: _agreed,
                  label: 'I accept the terms and conditions',
                  onChanged: (bool v) {
                    setState(() {
                      _agreed = v;
                    });
                  },
                ),
                SizedBox(height: theme.spacing.lg),
                SizedBox(
                  width: double.infinity,
                  child: MiniButton(
                    label: i18n.formSubmit,
                    onPressed: _handleSubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
