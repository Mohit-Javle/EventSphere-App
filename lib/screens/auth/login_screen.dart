import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_textfield.dart';
import '../../shared/widgets/es_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.go('/onboarding'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.displayLarge,
            ).animate().slideY(begin: 0.3, end: 0).fadeIn(),
            const SizedBox(height: 8),
            Text(
              "Sign in to EventSphere",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EsColors.textSecondary),
            ).animate(delay: 100.ms).slideY(begin: 0.3, end: 0).fadeIn(),
            
            const SizedBox(height: 40),
            
            // Form Card
            EsCard(
              variant: EsCardVariant.highlighted,
              child: Column(
                children: [
                  const EsTextField(
                    label: "Email Address",
                    hint: "alex@example.com",
                    prefixIcon: LucideIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  const EsTextField(
                    label: "Password",
                    hint: "••••••••",
                    prefixIcon: LucideIcons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate(delay: 200.ms).scale(begin: const Offset(0.95, 0.95)).fadeIn(),
            
            const SizedBox(height: 32),
            
            EsButton(
              text: "Sign In",
              onPressed: () => context.go('/home'), // Simple redirect for now
              width: double.infinity,
            ).animate(delay: 300.ms).slideY(begin: 0.2, end: 0).fadeIn(),
            
            const SizedBox(height: 40),
            
            // Divider
            Row(
              children: [
                Expanded(child: Divider(color: EsColors.bgBorder)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("or continue with", style: Theme.of(context).textTheme.labelSmall),
                ),
                Expanded(child: Divider(color: EsColors.bgBorder)),
              ],
            ).animate(delay: 400.ms).fadeIn(),
            
            const SizedBox(height: 32),
            
            // Social Row
            Row(
              children: [
                Expanded(
                  child: EsButton(
                    text: "Google",
                    variant: EsButtonVariant.secondary,
                    prefixIcon: LucideIcons.globe,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: EsButton(
                    text: "Apple",
                    variant: EsButtonVariant.secondary,
                    prefixIcon: LucideIcons.apple,
                    onPressed: () {},
                  ),
                ),
              ],
            ).animate(delay: 500.ms).fadeIn(),
            
            const SizedBox(height: 40),
            
            Center(
              child: GestureDetector(
                onTap: () => context.go('/register'),
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: EsColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate(delay: 600.ms).fadeIn(),
          ],
        ),
      ),
    );
  }
}
