import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Discover Amazing Events",
      "description": "Find and attend the best events happening around you or globally online.",
      "image": "assets/images/ob1.png" // Placeholder
    },
    {
      "title": "Seamless Ticketing",
      "description": "Purchase tickets with a tap, and use secure QR codes for check-ins.",
      "image": "assets/images/ob2.png" // Placeholder
    },
    {
      "title": "Connect & Network",
      "description": "Meet like-minded people, chat, and build your professional circle.",
      "image": "assets/images/ob3.png" // Placeholder
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Placeholder for image/illustration
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            index == 0
                                ? LucideIcons.calendar
                                : index == 1
                                    ? LucideIcons.ticket
                                    : LucideIcons.users,
                            size: 100,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          onboardingData[index]["title"]!,
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          onboardingData[index]["description"]!,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondaryLight,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: _currentPage == onboardingData.length - 1 ? "Get Started" : "Continue",
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        context.go('/login');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                  if (_currentPage != onboardingData.length - 1) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primary
            : (Theme.of(context).brightness == Brightness.dark
                ? AppColors.surfaceDark
                : AppColors.textSecondaryLight.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
