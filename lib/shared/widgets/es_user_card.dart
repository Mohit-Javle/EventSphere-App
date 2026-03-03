import 'package:flutter/material.dart';
import 'es_card.dart';
import 'es_avatar.dart';
import 'es_button.dart';
import 'es_chip.dart';

class EsUserCard extends StatefulWidget {
  final String name;
  final String role;
  final String? imageUrl;
  final int? mutualConnections;
  final List<String>? interests;
  final VoidCallback? onConnect;

  const EsUserCard({
    super.key,
    required this.name,
    required this.role,
    this.imageUrl,
    this.mutualConnections,
    this.interests,
    this.onConnect,
  });

  @override
  State<EsUserCard> createState() => _EsUserCardState();
}

class _EsUserCardState extends State<EsUserCard> {
  bool _isSent = false;

  void _handleConnect() {
    setState(() => _isSent = true);
    if (widget.onConnect != null) widget.onConnect!();
  }

  @override
  Widget build(BuildContext context) {
    return EsCard(
      child: Column(
        children: [
          Row(
            children: [
              EsAvatar(imageUrl: widget.imageUrl, name: widget.name, size: EsAvatarSize.md),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16)),
                    Text(widget.role, style: Theme.of(context).textTheme.bodyMedium),
                    if (widget.mutualConnections != null)
                      Text(
                        "${widget.mutualConnections} mutual connections",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                  ],
                ),
              ),
              EsButton(
                text: _isSent ? "Sent ✓" : "Connect",
                variant: _isSent ? EsButtonVariant.ghost : EsButtonVariant.secondary,
                size: EsButtonSize.small,
                onPressed: _isSent ? null : _handleConnect,
              ),
            ],
          ),
          if (widget.interests != null && widget.interests!.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 28,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.interests!.length > 2 ? 3 : widget.interests!.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == 2 && widget.interests!.length > 2) {
                    return EsChip(label: "+${widget.interests!.length - 2} more", variant: EsChipVariant.outlined);
                  }
                  return EsChip(label: widget.interests![index], variant: EsChipVariant.outlined);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
