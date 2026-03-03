import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/es_colors.dart';
import 'es_card.dart';
import 'es_chip.dart';

enum EsEventCardVariant { featured, compact }

class EsEventCard extends StatelessWidget {
  final String title;
  final String? bannerUrl;
  final String date;
  final String? location;
  final String category;
  final int? attendeeCount;
  final String? price;
  final bool isLive;
  final VoidCallback? onTap;
  final EsEventCardVariant variant;

  const EsEventCard({
    super.key,
    required this.title,
    this.bannerUrl,
    required this.date,
    this.location,
    required this.category,
    this.attendeeCount,
    this.price,
    this.isLive = false,
    this.onTap,
    this.variant = EsEventCardVariant.featured,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == EsEventCardVariant.featured) {
      return _buildFeatured(context);
    }
    return _buildCompact(context);
  }

  Widget _buildFeatured(BuildContext context) {
    return EsCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      width: double.infinity,
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Banner Image
          if (bannerUrl != null)
            Image.network(bannerUrl!, fit: BoxFit.cover)
          else
            Container(decoration: const BoxDecoration(gradient: EsColors.gradientCard)),
          
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.4, 1.0],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EsChip(label: category, variant: EsChipVariant.filled),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(LucideIcons.bookmark, color: Colors.white, size: 20),
                    ),
                  ],
                ),
                const Spacer(),
                if (isLive)
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: EsColors.accent, shape: BoxShape.circle),
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.5, duration: 1000.ms),
                      const SizedBox(width: 6),
                      Text(
                        "LIVE",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: EsColors.accent, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Text(title, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.calendar, size: 14, color: EsColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(date, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(width: 16),
                    if (location != null) ...[
                      Icon(LucideIcons.mapPin, size: 14, color: EsColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(location!, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    return EsCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 80,
              height: 80,
              child: bannerUrl != null 
                ? Image.network(bannerUrl!, fit: BoxFit.cover)
                : Container(decoration: const BoxDecoration(gradient: EsColors.gradientCard)),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(date, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.primary)),
                const SizedBox(height: 4),
                if (location != null)
                  Row(
                    children: [
                      Icon(LucideIcons.mapPin, size: 12, color: EsColors.textMuted),
                      const SizedBox(width: 4),
                      Text(location!, style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
              ],
            ),
          ),
          if (price != null)
            Text(price!, style: Theme.of(context).textTheme.displaySmall?.copyWith(color: EsColors.success)),
        ],
      ),
    );
  }
}
