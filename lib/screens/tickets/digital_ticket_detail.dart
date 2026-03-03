import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';

class DigitalTicketDetail extends StatelessWidget {
  final String id;
  const DigitalTicketDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text("Digital Ticket"),
        actions: [
          IconButton(icon: const Icon(LucideIcons.share2, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Ticket Card
            EsCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                   // Top Banner
                   Container(
                     height: 120,
                     width: double.infinity,
                     decoration: const BoxDecoration(
                       gradient: EsColors.gradientPrimary,
                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                     ),
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Flutter Forward 2026", style: Theme.of(context).textTheme.displaySmall),
                         const SizedBox(height: 4),
                         Text("VIP ENTRANCE", style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 2)),
                       ],
                     ),
                   ),
                   
                   // Dotted Divider (Mock)
                   _buildDottedDivider(),
                   
                   // Info Section
                   Padding(
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             _buildDetail("DATE", "Mar 15, 2026"),
                             _buildDetail("TIME", "10:00 AM"),
                           ],
                         ),
                         const SizedBox(height: 24),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             _buildDetail("LOCATION", "Moscone Center, SF"),
                             _buildDetail("SEAT", "VIP-A1"),
                           ],
                         ),
                         const SizedBox(height: 40),
                         
                         // QR Code Area
                         Container(
                           width: 200, height: 200,
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: const Center(
                             child: Icon(LucideIcons.qrCode, color: Colors.black, size: 160),
                           ),
                         ).animate().scale(delay: 400.ms, duration: 600.ms, curve: Curves.elasticOut),
                         
                         const SizedBox(height: 40),
                         Text("ES-TICK-99420KL", style: Theme.of(context).textTheme.labelSmall),
                       ],
                     ),
                   ),
                ],
              ),
            ).animate().slideY(begin: 0.2, end: 0).fadeIn(),
            
            const SizedBox(height: 32),
            
            // Helpful message
            Text(
              "Present this QR code at the event entrance for a quick check-in.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: EsColors.textMuted, letterSpacing: 1)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildDottedDivider() {
    return Container(
      color: EsColors.bgSurface,
      height: 20,
      child: Row(
        children: [
          Container(width: 10, height: 20, decoration: const BoxDecoration(color: EsColors.bgBase, borderRadius: BorderRadius.horizontal(right: Radius.circular(10)))),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    (constraints.constrainWidth() / 10).floor(),
                    (index) => const SizedBox(width: 5, height: 1, child: DecoratedBox(decoration: BoxDecoration(color: EsColors.bgBorder))),
                  ),
                );
              },
            ),
          ),
          Container(width: 10, height: 20, decoration: const BoxDecoration(color: EsColors.bgBase, borderRadius: BorderRadius.horizontal(left: Radius.circular(10)))),
        ],
      ),
    );
  }
}
