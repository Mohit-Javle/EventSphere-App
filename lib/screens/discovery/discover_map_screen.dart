import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';
import '../../shared/widgets/es_event_card.dart';

class DiscoverMapScreen extends StatefulWidget {
  const DiscoverMapScreen({super.key});

  @override
  State<DiscoverMapScreen> createState() => _DiscoverMapScreenState();
}

class _DiscoverMapScreenState extends State<DiscoverMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: Stack(
        children: [
          // Mock Map Background
          _MockMapBackground(),
          
          // Header with Search
          Positioned(
            top: 60, left: 20, right: 20,
            child: Row(
              children: [
                Expanded(
                  child: EsCard(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.search, color: EsColors.textMuted, size: 20),
                        const SizedBox(width: 12),
                        Text("Search in map...", style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(color: EsColors.bgElevated, shape: BoxShape.circle),
                  child: const Icon(LucideIcons.slidersHorizontal, color: EsColors.primary, size: 20),
                ),
              ],
            ),
          ).animate().slideY(begin: -0.2, end: 0).fadeIn(),
          
          // Map Markers (Mock)
          ...List.generate(4, (index) => _MapMarker(index: index)),
          
          // Bottom Event Carousel
          Positioned(
            bottom: 110, left: 0, right: 0,
            child: SizedBox(
              height: 120,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: EsEventCard(
                      variant: EsEventCardVariant.compact,
                      title: "Tech Meetup #24",
                      category: "Tech",
                      date: "Mar 20, 2026",
                      location: "1.2 miles away",
                      price: "Free",
                    ),
                  );
                },
              ),
            ),
          ).animate().slideY(begin: 0.2, end: 0).fadeIn(),
          
          // Current Location Button
          Positioned(
            bottom: 250, right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: EsColors.bgElevated, shape: BoxShape.circle),
              child: const Icon(LucideIcons.locateFixed, color: EsColors.primary, size: 24),
            ),
          ).animate().fadeIn(),
        ],
      ),
    );
  }
}

class _MockMapBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1E1E2E), // Dark map style
      child: CustomPaint(
        painter: _MapGridPainter(),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Main Roads
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 4;
    
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), roadPaint);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapMarker extends StatelessWidget {
  final int index;
  const _MapMarker({required this.index});

  @override
  Widget build(BuildContext context) {
    final offsets = [
      const Offset(100, 200),
      const Offset(250, 350),
      const Offset(150, 500),
      const Offset(300, 150),
    ];
    
    return Positioned(
      left: offsets[index].dx,
      top: offsets[index].dy,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: index == 1 ? EsColors.primary : EsColors.bgElevated,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Text(
              "\$${25 * (index + 1)}",
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 2, height: 8,
            color: index == 1 ? EsColors.primary : EsColors.bgElevated,
          ),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              color: index == 1 ? EsColors.primary : EsColors.bgElevated,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ],
      ).animate(onPlay: (c) => c.repeat(reverse: true)).slideY(end: -0.1, duration: 2.seconds),
    );
  }
}
