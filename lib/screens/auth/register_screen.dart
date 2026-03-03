import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_textfield.dart';
import '../../shared/widgets/es_card.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.go('/login'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: Theme.of(context).textTheme.displayLarge,
            ).animate().slideY(begin: 0.3, end: 0).fadeIn(),
            const SizedBox(height: 8),
            Text(
              "Join the EventSphere community",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EsColors.textSecondary),
            ).animate(delay: 100.ms).slideY(begin: 0.3, end: 0).fadeIn(),
            
            const SizedBox(height: 32),
            
            EsCard(
              child: Column(
                children: [
                  const EsTextField(
                    label: "Full Name",
                    hint: "Alex Rivera",
                    prefixIcon: LucideIcons.user,
                  ),
                  const SizedBox(height: 20),
                  const EsTextField(
                    label: "Email Address",
                    hint: "alex@example.com",
                    prefixIcon: LucideIcons.mail,
                  ),
                  const SizedBox(height: 20),
                  EsTextField(
                    label: "Password",
                    hint: "••••••••",
                    prefixIcon: LucideIcons.lock,
                    isPassword: true,
                    onChanged: (val) => setState(() => _password = val),
                  ),
                  const SizedBox(height: 12),
                  _buildPasswordStrength(),
                  const SizedBox(height: 20),
                  const EsTextField(
                    label: "Confirm Password",
                    hint: "••••••••",
                    prefixIcon: LucideIcons.lock,
                    isPassword: true,
                  ),
                ],
              ),
            ).animate(delay: 200.ms).scale(begin: const Offset(0.95, 0.95)).fadeIn(),
            
            const SizedBox(height: 24),
            
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (v) {},
                  activeColor: EsColors.primary,
                  side: const BorderSide(color: EsColors.bgBorder),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "I agree to ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(text: "Terms of Service", style: TextStyle(color: EsColors.primary)),
                        const TextSpan(text: " and "),
                        TextSpan(text: "Privacy Policy", style: TextStyle(color: EsColors.primary)),
                      ],
                    ),
                  ),
                ),
              ],
            ).animate(delay: 300.ms).fadeIn(),
            
            const SizedBox(height: 32),
            
            EsButton(
              text: "Create Account",
              onPressed: () => context.go('/role-selection'),
              width: double.infinity,
            ).animate(delay: 400.ms).slideY(begin: 0.2, end: 0).fadeIn(),
            
            const SizedBox(height: 32),
            
            Center(
              child: GestureDetector(
                onTap: () => context.go('/login'),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(color: EsColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate(delay: 500.ms).fadeIn(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordStrength() {
    int strength = 0;
    if (_password.length > 6) strength++;
    if (_password.contains(RegExp(r'[A-Z]'))) strength++;
    if (_password.contains(RegExp(r'[0-9]'))) strength++;
    if (_password.contains(RegExp(r'[!@#\$&*~]'))) strength++;

    Color color;
    String label;
    switch (strength) {
      case 1: color = EsColors.error; label = "Weak"; break;
      case 2: color = EsColors.warning; label = "Fair"; break;
      case 3: color = EsColors.success; label = "Strong"; break;
      case 4: color = EsColors.success; label = "Very Strong"; break;
      default: color = EsColors.bgBorder; label = "Too Short";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index < strength ? color : EsColors.bgBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: strength > 0 ? color : EsColors.textMuted),
        ),
      ],
    );
  }
}
