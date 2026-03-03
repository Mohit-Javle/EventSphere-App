import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/es_colors.dart';

enum EsAvatarSize { xs, sm, md, lg, xl }

class EsAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final EsAvatarSize size;
  final bool isOnline;
  final bool hasRing;
  final bool isLoading;

  const EsAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = EsAvatarSize.md,
    this.isOnline = false,
    this.hasRing = false,
    this.isLoading = false,
  });

  double _getSize() {
    switch (size) {
      case EsAvatarSize.xs: return 28;
      case EsAvatarSize.sm: return 36;
      case EsAvatarSize.md: return 44;
      case EsAvatarSize.lg: return 56;
      case EsAvatarSize.xl: return 72;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: EsColors.bgSurface,
        highlightColor: EsColors.bgElevated,
        child: Container(
          width: _getSize(),
          height: _getSize(),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      );
    }

    Widget avatar;
    if (imageUrl != null) {
      avatar = CircleAvatar(
        radius: _getSize() / 2,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else {
      final String initials = (name ?? "?").split(" ").map((e) => e[0]).take(2).join().toUpperCase();
      avatar = Container(
        width: _getSize(),
        height: _getSize(),
        decoration: BoxDecoration(
          gradient: EsColors.gradientPrimary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: _getSize() * 0.4,
            ),
          ),
        ),
      );
    }

    if (hasRing) {
      avatar = Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          gradient: EsColors.gradientPrimary,
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: EsColors.bgBase, shape: BoxShape.circle),
          child: avatar,
        ),
      );
    }

    if (isOnline) {
      return Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _getSize() * 0.25,
              height: _getSize() * 0.25,
              decoration: BoxDecoration(
                color: EsColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: EsColors.bgBase, width: 2),
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }
}
