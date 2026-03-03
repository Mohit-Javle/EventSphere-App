import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../shared/theme/es_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Router now handles navigation automatically based on AuthProvider state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: Stack(
        children: [
          // Background Decoration
          Positioned(
            top: -100,
            right: -50,
            child: _BlurredCircle(color: EsColors.primary.withValues(alpha: 0.05)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _BlurredCircle(color: EsColors.primary.withValues(alpha: 0.05)),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                _EsLogo()
                  .animate()
                  .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.0, 1.0), duration: 600.ms, curve: Curves.elasticOut)
                  .fadeIn(),
                
                const SizedBox(height: 24),
                
                // Name
                Text(
                  "EventSphere",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                )
                .animate()
                .slideY(begin: 1.0, end: 0, delay: 300.ms, duration: 400.ms)
                .fadeIn(delay: 300.ms),
                
                const SizedBox(height: 8),
                
                // Tagline
                Text(
                  "Connect. Experience. Remember.",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 400.ms),
              ],
            ),
          ),
          
          // Version
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                "v1.0.0",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EsLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: EsColors.primary,
        shape: BoxShape.circle, // Simplified for now, can be Hexagon later with CustomPainter
        gradient: EsColors.gradientPrimary,
        boxShadow: [
          BoxShadow(
            color: EsColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: const Center(
        child: Text(
          "ES",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w900,
            fontFamily: 'Syne',
          ),
        ),
      ),
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  final Color color;
  const _BlurredCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
