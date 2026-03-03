import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
        title: const Text("Notifications"),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Mark all read", style: TextStyle(color: EsColors.primary))),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildNotificationItem(index),
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    final titles = [
      "Ticket Confirmed! 🎫",
      "New comment in Tech Circle",
      "Event starting in 1 hour!",
      "Marcus Bell wants to connect",
      "Welcome to EventSphere"
    ];
    
    return EsCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: index == 0 ? EsColors.primary.withValues(alpha: 0.1) : EsColors.bgSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              index == 0 ? LucideIcons.ticket : (index == 2 ? LucideIcons.clock : LucideIcons.bell),
              color: index == 0 ? EsColors.primary : EsColors.textMuted,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titles[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: const TextStyle(color: EsColors.textMuted, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                const Text("Just now", style: TextStyle(color: EsColors.textMuted, fontSize: 10)),
              ],
            ),
          ),
          if (index < 2)
            Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: EsColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
