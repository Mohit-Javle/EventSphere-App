import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_avatar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStats(),
                const SizedBox(height: 32),
                _buildSection("Account Settings"),
                _buildMenuItem(LucideIcons.user, "Personal Information", () {}),
                _buildMenuItem(LucideIcons.bell, "Notifications", () => context.push('/notifications')),
                _buildMenuItem(LucideIcons.shieldCheck, "Security", () {}),
                const SizedBox(height: 24),
                _buildSection("Preferences"),
                _buildMenuItem(LucideIcons.palette, "Appearance", () {}),
                _buildMenuItem(LucideIcons.globe, "Language", () {}),
                const SizedBox(height: 24),
                _buildSection("Support"),
                _buildMenuItem(LucideIcons.info, "Help Center", () {}),
                _buildMenuItem(LucideIcons.fileText, "Privacy Policy", () {}),
                const SizedBox(height: 48),
                EsButton(
                  text: "Logout",
                  variant: EsButtonVariant.secondary,
                  width: double.infinity,
                  onPressed: () => context.go('/login'),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [EsColors.primary, EsColors.accent],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(color: Colors.black.withValues(alpha: 0.4)),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EsAvatar(size: EsAvatarSize.xl),
                const SizedBox(height: 16),
                Text("Alex Rivera", style: Theme.of(context).textTheme.displaySmall),
                const Text("@alex_rivera", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                Chip(
                  backgroundColor: Colors.white12,
                  label: const Text("Premium Member", style: TextStyle(color: Colors.white, fontSize: 10)),
                  side: BorderSide.none,
                ),
              ],
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem("12", "Attended"),
        _buildStatItem("4", "Circles"),
        _buildStatItem("850", "Karma"),
      ],
    );
  }

  Widget _buildStatItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 12, color: EsColors.textMuted)),
      ],
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: EsColors.textMuted, letterSpacing: 1)),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: EsCard(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: EsColors.primary, size: 20),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(LucideIcons.chevronRight, color: EsColors.textMuted, size: 18),
          ],
        ),
      ),
    );
  }
}
