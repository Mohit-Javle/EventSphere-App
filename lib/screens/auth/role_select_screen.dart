import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen> {
  String? _selectedRole; // 'attendee' or 'organizer'

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Choose Your Role",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "How do you plan to use EventSphere?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
              ),
              const SizedBox(height: 48),
              _buildRoleCard(
                title: "Attendee",
                description: "Discover events, buy tickets, and connect with other participants.",
                icon: LucideIcons.user,
                isSelected: _selectedRole == 'attendee',
                onTap: () {
                  setState(() {
                    _selectedRole = 'attendee';
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildRoleCard(
                title: "Organizer",
                description: "Create events, manage ticket sales, and view analytics.",
                icon: LucideIcons.calendarPlus,
                isSelected: _selectedRole == 'organizer',
                onTap: () {
                  setState(() {
                    _selectedRole = 'organizer';
                  });
                },
              ),
              const Spacer(),
              CustomButton(
                text: "Continue",
                onPressed: _selectedRole == null
                    ? () {} // Disabled if null, but CustomButton needs disabled state logic. Let's handle it manually.
                      : () {
                          final role = _selectedRole == 'organizer' 
                              ? UserRole.organizer 
                              : UserRole.attendee;
                          Provider.of<AuthProvider>(context, listen: false).register(
                            "New User", 
                            "user@example.com", 
                            "password", 
                            role
                          );
                        },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.1)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.2) : AppColors.textSecondaryLight.withValues(alpha: 0.2)),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.2) : AppColors.textSecondaryLight.withValues(alpha: 0.2)),
                ),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
