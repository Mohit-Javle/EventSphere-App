import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_textfield.dart';
import '../../shared/widgets/es_avatar.dart';
import '../../shared/widgets/es_chip.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _step = 1;
  final List<String> _selectedInterests = [];
  final List<String> _allInterests = [
    "Tech", "Music", "Sports", "Business", "Art", "Food", 
    "Gaming", "Travel", "Fitness", "Fashion", "Film", "Science",
    "Design", "Marketing", "Crypto", "Wellness", "Photography", "Networking"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Step $_step of 2", style: Theme.of(context).textTheme.labelSmall),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _step == 1 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tell us about\nyourself", style: Theme.of(context).textTheme.displayLarge)
            .animate().slideY(begin: 0.2, end: 0).fadeIn(),
        const SizedBox(height: 32),
        
        // Avatar Picker
        Center(
          child: Stack(
            children: [
              const EsAvatar(size: EsAvatarSize.xl),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: EsColors.primary, shape: BoxShape.circle),
                  child: const Icon(LucideIcons.camera, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ).animate(delay: 100.ms).scale().fadeIn(),
        
        const SizedBox(height: 40),
        
        const EsTextField(
          label: "Display Name",
          hint: "Alex Rivera",
          prefixIcon: LucideIcons.user,
        ),
        const SizedBox(height: 20),
        const EsTextField(
          label: "Bio",
          hint: "Tech enthusiast and event explorer...",
          prefixIcon: LucideIcons.quote,
        ),
        
        const SizedBox(height: 40),
        
        EsButton(
          text: "Continue",
          onPressed: () => setState(() => _step = 2),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What are your\ninterests?", style: Theme.of(context).textTheme.displayLarge)
            .animate().slideY(begin: 0.2, end: 0).fadeIn(),
        const SizedBox(height: 8),
        Text("Select at least 3 to continue", style: Theme.of(context).textTheme.bodyMedium)
            .animate(delay: 100.ms).fadeIn(),
        
        const SizedBox(height: 32),
        
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _allInterests.map((interest) {
            final bool isSelected = _selectedInterests.contains(interest);
            return EsChip(
              label: interest,
              variant: EsChipVariant.filter,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(interest);
                  } else {
                    _selectedInterests.add(interest);
                  }
                });
              },
            );
          }).toList(),
        ).animate(delay: 200.ms).fadeIn(),
        
        const SizedBox(height: 40),
        
        Text("Social Links (Optional)", style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        const EsTextField(label: "Instagram", prefixIcon: LucideIcons.instagram),
        const SizedBox(height: 16),
        const EsTextField(label: "LinkedIn", prefixIcon: LucideIcons.linkedin),
        
        const SizedBox(height: 40),
        
        EsButton(
          text: "Complete Setup",
          onPressed: _selectedInterests.length < 3 ? null : () => context.go('/home'),
          width: double.infinity,
        ),
      ],
    );
  }
}
