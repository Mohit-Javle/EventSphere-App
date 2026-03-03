import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_avatar.dart';

class EventDetailScreen extends StatelessWidget {
  final String id;
  const EventDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: CustomScrollView(
        slivers: [
          // Hero Banner
          SliverAppBar(
            expandedHeight: 260,
            backgroundColor: EsColors.bgBase,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _GlassIconButton(icon: LucideIcons.arrowLeft, onTap: () => context.pop()),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _GlassIconButton(icon: LucideIcons.bookmark, onTap: () {}),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1540575861501-7ad058c78a00?w=800",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          EsColors.bgBase.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20, left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: EsColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: EsColors.primary.withValues(alpha: 0.3)),
                      ),
                      child: Text("TECH", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Flutter Forward 2026",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  // Organizer Row
                  Row(
                    children: [
                      const EsAvatar(size: EsAvatarSize.sm),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Organized by", style: Theme.of(context).textTheme.labelSmall),
                          Text("Google Developers", style: Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                      const Spacer(),
                      EsButton(text: "Follow", variant: EsButtonVariant.secondary, size: EsButtonSize.small),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Info Row
                  _buildInfoItem(LucideIcons.calendar, "Saturday, Mar 15 · 10:00 AM PST"),
                  const SizedBox(height: 16),
                  _buildInfoItem(LucideIcons.mapPin, "Moscone Center, San Francisco"),
                  const SizedBox(height: 16),
                  _buildInfoItem(LucideIcons.users, "1,240 attending"),
                  
                  const SizedBox(height: 32),
                  
                  // Countdown
                  Center(child: _CountdownTimer()),
                  
                  const SizedBox(height: 32),
                  
                  Text("About This Event", style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 12),
                  Text(
                    "Join us for the most ambitious Flutter event ever! We're pushing the boundaries of what's possible with multi-platform development. Discover the latest updates on Impeller, Dart 4.0, and radical new developer tools.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EsColors.textSecondary),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Who's Going
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Who's Going (1.2k+)", style: Theme.of(context).textTheme.displaySmall),
                      TextButton(onPressed: () {}, child: const Text("View All")),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: List.generate(5, (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: EsAvatar(size: EsAvatarSize.md),
                    )),
                  ),
                  
                  const SizedBox(height: 100), // Bottom padding for sticky bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildStickyBar(context),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: EsColors.bgSurface, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: EsColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Text(text, style: const TextStyle(color: EsColors.textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _buildStickyBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: EsColors.bgSurface,
        border: const Border(top: BorderSide(color: EsColors.bgBorder, width: 0.5)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("From", style: Theme.of(context).textTheme.labelSmall),
                Text("\$49.00", style: Theme.of(context).textTheme.displaySmall?.copyWith(color: EsColors.success)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: EsButton(
                text: "Get Tickets →",
                onPressed: () => context.push('/purchase/$id'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _CountdownTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUnit("03", "DAYS"),
        _buildDivider(),
        _buildUnit("14", "HOURS"),
        _buildDivider(),
        _buildUnit("22", "MINS"),
        _buildDivider(),
        _buildUnit("45", "SECS"),
      ],
    );
  }

  Widget _buildUnit(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 10, color: EsColors.textMuted, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(":", style: TextStyle(fontSize: 32, color: EsColors.textMuted)),
    );
  }
}
