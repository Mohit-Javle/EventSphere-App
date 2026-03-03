import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';
import '../../shared/widgets/es_avatar.dart';
import '../../shared/widgets/es_textfield.dart';

class DiscussionBoard extends StatelessWidget {
  const DiscussionBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Community Board", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Flutter Forward 2026", style: TextStyle(fontSize: 12, color: EsColors.textMuted)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) => _buildPostItem(index),
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildPostItem(int index) {
    final names = ["Elena Rossi", "Liam Wright", "Sophia Chen", "Marcus Bell"];
    final content = [
      "Anyone else excited for the AI keynote tomorrow? 🚀",
      "I'm looking for a ride from the airport, anyone arriving around 10am?",
      "Just arrived! The venue looks absolutely stunning. See you all soon!",
      "Does anyone have the schedule for the design workshop?"
    ];
    
    return EsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const EsAvatar(size: EsAvatarSize.xs),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const Text("2 hours ago", style: TextStyle(color: EsColors.textMuted, fontSize: 10)),
                ],
              ),
              const Spacer(),
              const Icon(LucideIcons.ellipsis, color: EsColors.textMuted),
            ],
          ),
          const SizedBox(height: 12),
          Text(content[index], style: const TextStyle(color: Colors.white, height: 1.4)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildAction(LucideIcons.heart, "24"),
              const SizedBox(width: 20),
              _buildAction(LucideIcons.messageSquare, "8"),
              const Spacer(),
              const Icon(LucideIcons.bookmark, color: EsColors.textMuted, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, color: EsColors.textMuted, size: 18),
        const SizedBox(width: 6),
        Text(count, style: const TextStyle(color: EsColors.textMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: EsColors.bgElevated, border: Border(top: BorderSide(color: EsColors.bgBorder))),
      child: Row(
        children: [
          const EsAvatar(size: EsAvatarSize.xs),
          const SizedBox(width: 16),
          const Expanded(
            child: EsTextField(label: "Message", hint: "Share something with the board..."),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: EsColors.primary, shape: BoxShape.circle),
            child: const Icon(LucideIcons.send, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
