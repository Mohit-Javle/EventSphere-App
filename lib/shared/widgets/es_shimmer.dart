import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/es_colors.dart';

class EsShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const EsShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: EsColors.bgSurface,
      highlightColor: EsColors.bgElevated,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  static Widget card() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EsShimmer(width: double.infinity, height: 180, borderRadius: 20),
          const SizedBox(height: 12),
          EsShimmer(width: 200, height: 20),
          const SizedBox(height: 8),
          EsShimmer(width: 150, height: 16),
        ],
      ),
    );
  }
}
