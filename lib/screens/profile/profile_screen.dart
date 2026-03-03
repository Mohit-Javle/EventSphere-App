import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/event_provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth = Provider.of<AuthProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);
    final user = auth.user;

    if (user == null) return const Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark 
                      ? AppColors.textSecondaryDark.withValues(alpha: 0.1) 
                      : AppColors.textSecondaryLight.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.photoUrl ?? 'https://i.pravatar.cc/150?img=11'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                            width: 2,
                          ),
                        ),
                        child: const Icon(LucideIcons.pencil, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(user.name, style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStat(context, eventProvider.purchasedTickets.length.toString(), "Tickets"),
                      Container(
                        height: 30,
                        width: 1,
                        color: isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.2) : AppColors.textSecondaryLight.withValues(alpha: 0.2),
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                      ),
                      _buildStat(context, "45", "Connections"),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Menu Options
            _buildMenuOption(context, "My Tickets", LucideIcons.ticket, onTap: () {
              // This is handled by the parent MainLayout tab selection usually, 
              // but we can also trigger a tab change if we had controller access.
            }),
            _buildMenuOption(context, "Saved Events", LucideIcons.heart, onTap: () {}),
            _buildMenuOption(context, "Payment Methods", LucideIcons.creditCard, onTap: () {}),
            _buildMenuOption(context, "Theme Settings", LucideIcons.moon, onTap: () {
              context.push('/settings');
            }),
            _buildMenuOption(context, "Notifications", LucideIcons.bell, onTap: () {
              context.push('/settings');
            }),
            
            const SizedBox(height: 32),
            CustomButton(
              text: "Log Out",
              isOutlined: true,
              onPressed: () {
                auth.logout();
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String count, String label) {
    return Column(
      children: [
        Text(count, style: Theme.of(context).textTheme.displaySmall),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? AppColors.textSecondaryDark 
                    : AppColors.textSecondaryLight,
              ),
        ),
      ],
    );
  }

  Widget _buildMenuOption(BuildContext context, String title, IconData icon, {required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16)),
      trailing: Icon(
        LucideIcons.chevronRight, 
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
