import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/cat_house_logo.dart';
import '../../widgets/app_text_field.dart';
import '../../services/auth_service.dart';
import '../home/main_nav_shell.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      await AuthService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainNavShell()),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'تعذر إنشاء الحساب. حاول مرة أخرى.';
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const Center(child: CatHouseLogo(size: 90, showText: false)),
                const SizedBox(height: 24),
                AppTextField(
                  label: 'الاسم الكامل',
                  controller: _nameController,
                  icon: Icons.person_outline,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'أدخل اسمك الكامل' : null,
                ),
                AppTextField(
                  label: 'البريد الإلكتروني',
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'أدخل بريد إلكتروني صحيح'
                      : null,
                ),
                AppTextField(
                  label: 'رقم الهاتف',
                  controller: _phoneController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      (v == null || v.length < 8) ? 'أدخل رقم هاتف صحيح' : null,
                ),
                AppTextField(
                  label: 'كلمة المرور',
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffix: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textGrey,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'كلمة المرور 6 أحرف على الأقل'
                      : null,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 4),
                  Text(_errorMessage!,
                      style: const TextStyle(color: AppColors.error)),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _loading ? null : _handleSignup,
                  child: _loading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text('إنشاء الحساب'),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
