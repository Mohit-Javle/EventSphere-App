import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "How will you use\nEventSphere?",
                style: Theme.of(context).textTheme.displayLarge,
              ).animate().slideX(begin: -0.2, end: 0).fadeIn(),
              const SizedBox(height: 32),
              
              _buildRoleCard(
                id: "attendee",
                title: "I'm an Attendee",
                description: "Discover events, buy tickets, and connect with other attendees.",
                icon: LucideIcons.user,
                features: ["Discover global events", "Smart QR tickets", "Networking tools"],
              ),
              
              const SizedBox(height: 20),
              
              _buildRoleCard(
                id: "organizer",
                title: "I'm an Organizer",
                description: "Create events, manage tickets, and grow your community.",
                icon: LucideIcons.calendarDays,
                features: ["Create custom events", "Attendee analytics", "Check-in tools"],
              ),
              
              const SizedBox(height: 40),
              
              EsButton(
                text: "Continue",
                onPressed: _selectedRole == null ? null : () => context.go('/profile-setup'),
                width: double.infinity,
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String id,
    required String title,
    required String description,
    required IconData icon,
    required List<String> features,
  }) {
    final bool isSelected = _selectedRole == id;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = id),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? EsColors.primary.withValues(alpha: 0.1) : EsColors.bgElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? EsColors.primary : EsColors.bgBorder,
            width: 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: EsColors.primary.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? EsColors.primary : EsColors.bgSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(height: 20),
              Divider(color: EsColors.primary.withValues(alpha: 0.2)),
              const SizedBox(height: 12),
              ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(LucideIcons.check, color: EsColors.success, size: 16),
                    const SizedBox(width: 8),
                    Text(f, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              )),
            ],
          ],
        ),
      ).animate(target: isSelected ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.02, 1.02), duration: 200.ms),
    );
  }
}
