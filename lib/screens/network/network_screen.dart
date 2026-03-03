import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';
import '../../shared/widgets/es_avatar.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Community", style: Theme.of(context).textTheme.displaySmall),
        actions: [
          IconButton(icon: const Icon(LucideIcons.userPlus, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader("Suggested Connections"),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => _buildUserCard(index),
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader("Active Circles"),
          const SizedBox(height: 16),
          _buildCircleItem("Tech Innovators", "420 Members", LucideIcons.cpu),
          _buildCircleItem("Design Enthusiasts", "1.2k Members", LucideIcons.palette),
          _buildCircleItem("Startup Founders", "850 Members", LucideIcons.rocket),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        TextButton(onPressed: () {}, child: const Text("See all")),
      ],
    );
  }

  Widget _buildUserCard(int index) {
    final names = ["Sarah Chen", "Marcus Bell", "Elena Rossi", "David Kim", "Aria Stark"];
    return EsCard(
      width: 140,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EsAvatar(size: EsAvatarSize.md),
          const SizedBox(height: 12),
          Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          const Text("Graphic Designer", style: TextStyle(fontSize: 10, color: EsColors.textMuted), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: EsColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
            child: const Text("Connect", style: TextStyle(color: EsColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleItem(String name, String members, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: EsCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: EsColors.bgSurface, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: EsColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(members, style: const TextStyle(color: EsColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: EsColors.textMuted),
          ],
        ),
      ),
    );
  }
}
