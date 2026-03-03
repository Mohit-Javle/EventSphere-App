import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Organize Events\nLike a Pro",
      description: "Create and manage your events with ease. From ticketing to networking, we've got you covered.",
      illustration: _FloatingCardsIllustration(),
    ),
    OnboardingData(
      title: "Tickets with\nSmart QR",
      description: "Instant QR generation for seamless entry. Your digital ticket wallet, always in your pocket.",
      illustration: _SmartTicketIllustration(),
    ),
    OnboardingData(
      title: "Network with\nAttendees",
      description: "Connect with like-minded people. Exchange contacts and grow your professional network.",
      illustration: _NetworkIllustration(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      body: Stack(
        children: [
          // Content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _pages.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Column(
                children: [
                  // Illustration Area (60%)
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(child: page.illustration),
                    ),
                  ),
                  // Text Area (40%)
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            page.title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                          ).animate().slideX(begin: 0.2, end: 0).fadeIn(),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EsColors.textSecondary),
                          ).animate(delay: 100.ms).slideX(begin: 0.2, end: 0).fadeIn(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Page Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (index) {
                    final isSelected = _currentPage == index;
                    return AnimatedContainer(
                      duration: 300.ms,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        gradient: isSelected ? EsColors.gradientPrimary : null,
                        color: isSelected ? null : EsColors.bgBorder,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                // Button
                EsButton(
                  text: _currentPage == _pages.length - 1 ? "Get Started" : "Continue",
                  onPressed: () {
                    if (_currentPage < _pages.length - 1) {
                      _pageController.nextPage(duration: 500.ms, curve: Curves.easeOutCubic);
                    } else {
                      context.read<AuthProvider>().completeOnboarding();
                      context.go('/login');
                    }
                  },
                ),
                const SizedBox(height: 16),
                if (_currentPage < _pages.length - 1)
                  GestureDetector(
                    onTap: () {
                      context.read<AuthProvider>().completeOnboarding();
                      context.go('/login');
                    },
                    child: Text(
                      "Skip",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: EsColors.textMuted),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final Widget illustration;
  OnboardingData({required this.title, required this.description, required this.illustration});
}

class _FloatingCardsIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 40, top: 60,
          child: _MockCard(color: EsColors.primaryLight).animate(onPlay: (c) => c.repeat(reverse: true)).slideY(begin: 0, end: 0.05, duration: 2.seconds),
        ),
        Positioned(
          right: 40, top: 100,
          child: _MockCard(color: EsColors.accent).animate(onPlay: (c) => c.repeat(reverse: true)).slideY(begin: 0, end: -0.05, duration: 2.5.seconds, delay: 500.ms),
        ),
        Center(
          child: _MockCard(color: EsColors.primary, width: 220, height: 140)
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .slideY(begin: 0, end: 0.03, duration: 3.seconds),
        ),
      ],
    );
  }
}

class _MockCard extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  const _MockCard({required this.color, this.width = 180, this.height = 110});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 12),
            Container(width: double.infinity, height: 8, decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4))),
            const SizedBox(height: 8),
            Container(width: 100, height: 8, decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4))),
          ],
        ),
      ),
    );
  }
}

class _SmartTicketIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200, height: 320,
        decoration: BoxDecoration(
          gradient: EsColors.gradientPrimary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(width: 120, height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12))),
            const SizedBox(height: 20),
            Text("SCAN ME", style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.bold, letterSpacing: 2)),
          ],
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 2.seconds),
    );
  }
}

class _NetworkIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(6, (index) {
            return Transform.translate(
              offset: Offset(80 * (index % 2 == 0 ? 1 : 1.2) * (index % 3 == 0 ? -1 : 1), 60 * (index % 2 == 0 ? -1 : 1)),
              child: const CircleAvatar(radius: 20, backgroundColor: EsColors.bgElevated),
            ).animate().slide(begin: const Offset(0, 0), end: const Offset(0.1, 0.1), duration: 2.seconds).fadeIn();
          }),
          const CircleAvatar(radius: 30, backgroundColor: EsColors.primary),
        ],
      ),
    );
  }
}
