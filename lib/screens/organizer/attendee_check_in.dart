import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';

class AttendeeCheckIn extends StatefulWidget {
  const AttendeeCheckIn({super.key});

  @override
  State<AttendeeCheckIn> createState() => _AttendeeCheckInState();
}

class _AttendeeCheckInState extends State<AttendeeCheckIn> {
  bool _isScanning = true;
  bool _hasResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark scanner feel
      body: Stack(
        children: [
          // Mock Camera View
          _MockCameraView(isScanning: _isScanning),
          
          // Scanner Overlay
          if (_isScanning) _buildScannerOverlay(),
          
          // Results Card
          if (_hasResult) _buildSuccessCard(),
          
          // Header
          Positioned(
            top: 60, left: 20, right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.x, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                const Spacer(),
                const Text("Scan Ticket", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const Spacer(),
                const SizedBox(width: 48), // Balance
              ],
            ),
          ),
          
          // Manual Entry Button
          if (!_hasResult)
            Positioned(
              bottom: 60, left: 40, right: 40,
              child: EsButton(
                text: "Manual Entry",
                variant: EsButtonVariant.secondary,
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250, height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: EsColors.primary, width: 2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                _buildCorner(0, 0, 20, 0), // Top Left
                _buildCorner(null, 0, 0, 20), // Top Right
                _buildCorner(0, null, 20, 0), // Bottom Left
                _buildCorner(null, null, 0, 20), // Bottom Right
                
                // Scanning Line
                Container(
                  width: double.infinity,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [EsColors.primary.withValues(alpha: 0), EsColors.primary, EsColors.primary.withValues(alpha: 0)],
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat()).moveY(begin: 0, end: 250, duration: 2.seconds),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("Align QR code within frame", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 40),
          EsButton(
            text: "Simulate Scan",
            onPressed: () {
              setState(() { _isScanning = false; _hasResult = true; });
            },
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildCorner(double? left, double? top, double rL, double rR) {
    return Positioned(
      left: left, top: top,
      child: Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          border: Border(
             left: left != null ? const BorderSide(color: EsColors.primary, width: 4) : BorderSide.none,
             top: top != null ? const BorderSide(color: EsColors.primary, width: 4) : BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: EsColors.bgBase, borderRadius: BorderRadius.circular(30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.circleCheck, color: EsColors.success, size: 80),
            const SizedBox(height: 24),
            Text("Verified!", style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 12),
            Text("Attendee: Alex Rivera", style: Theme.of(context).textTheme.bodyLarge),
            Text("VIP Ticket #ES-99420", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.textMuted)),
            const SizedBox(height: 32),
            EsButton(
              text: "Next Scan",
              width: double.infinity,
              onPressed: () => setState(() { _isScanning = true; _hasResult = false; }),
            ),
          ],
        ),
      ).animate().scale(curve: Curves.elasticOut, duration: 800.ms),
    );
  }
}

class _MockCameraView extends StatelessWidget {
  final bool isScanning;
  const _MockCameraView({required this.isScanning});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: double.infinity,
      color: const Color(0xFF121212),
      child: Opacity(
        opacity: isScanning ? 0.3 : 0.1,
        child: CustomPaint(painter: _CameraGlitchPainter()),
      ),
    );
  }
}

class _CameraGlitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.05);
    for (int i = 0; i < 20; i++) {
        canvas.drawRect(Rect.fromLTWH(0, i * size.height / 20, size.width, 1), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
