import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../home/home_screen.dart';
import '../discovery/discover_map_screen.dart';
import '../tickets/tickets_list_screen.dart';
import '../network/network_screen.dart';
import '../profile/user_profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DiscoverMapScreen(),
    const SizedBox.shrink(), // Placeholder for FAB
    const TicketsListScreen(),
    const NetworkScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        gradient: EsColors.gradientAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: EsColors.accent,
            blurRadius: 15,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push('/create-event');
          },
          borderRadius: BorderRadius.circular(32),
          child: const Center(
            child: Icon(LucideIcons.plus, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: EsColors.bgSurface.withValues(alpha: 0.8),
        border: const Border(top: BorderSide(color: EsColors.bgBorder, width: 0.5)),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, LucideIcons.house, "Home"),
              _buildNavItem(1, LucideIcons.map, "Discover"),
              const SizedBox(width: 64), // FAB Space
              _buildNavItem(3, LucideIcons.ticket, "Tickets"),
              _buildNavItem(4, LucideIcons.users, "Network"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? EsColors.primary : EsColors.textMuted;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
