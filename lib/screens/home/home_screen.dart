import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/location_provider.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_avatar.dart';
import '../../shared/widgets/es_chip.dart';
import '../../shared/widgets/es_event_card.dart';
import '../../shared/widgets/es_card.dart';
import '../discovery/search_filter_sheet.dart';
import '../../shared/widgets/es_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Tech", "Music", "Business", "Sports", "Art"];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          backgroundColor: Colors.transparent,
          floating: true,
          expandedHeight: 0,
          leadingWidth: 0,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<LocationProvider>(
                    builder: (context, location, _) => Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: 10, color: EsColors.primary),
                        const SizedBox(width: 4),
                        Text(location.currentAddress, style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ),
                  Text("Alex Rivera", style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context.push('/notifications'),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: EsColors.bgElevated, shape: BoxShape.circle),
                      child: const Icon(LucideIcons.bell, color: Colors.white, size: 20),
                    ),
                    Positioned(
                      right: 0, top: 0,
                      child: Container(
                        width: 10, height: 10,
                        decoration: const BoxDecoration(color: EsColors.accent, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => context.push('/profile'),
                child: const EsAvatar(size: EsAvatarSize.sm),
              ),
            ],
          ),
        ),

        // Search Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const SearchFilterSheet(),
                );
              },
              child: EsCard(
                variant: EsCardVariant.normal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Icon(LucideIcons.search, color: EsColors.textMuted, size: 20),
                    const SizedBox(width: 12),
                    Text("Search events, organizers...", style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    const Icon(LucideIcons.slidersHorizontal, color: EsColors.primary, size: 20),
                  ],
                ),
              ),
            ).animate().slideY(begin: 0.2, end: 0).fadeIn(),
          ),
        ),

        // Categories
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return EsChip(
                  label: cat,
                  variant: EsChipVariant.filter,
                  isSelected: _selectedCategory == cat,
                  onTap: () => setState(() => _selectedCategory = cat),
                );
              },
            ),
          ).animate(delay: 100.ms).fadeIn(),
        ),

        // Featured Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Featured Events", "See all"),
                const SizedBox(height: 16),
                SizedBox(
                  height: 220,
                  child: PageView(
                    children: [
                      EsEventCard(
                        title: "Flutter Forward 2026",
                        category: "Tech",
                        date: "Mar 15, 2026",
                        location: "San Francisco",
                        isLive: true,
                        onTap: () => context.push('/event/evt001'),
                      ),
                      EsEventCard(
                        title: "AI Summit 2026",
                        category: "Tech",
                        date: "Apr 5, 2026",
                        location: "Virtual",
                        onTap: () => context.push('/event/evt002'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Tonight Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("Tonight", "See all", hasPulse: true),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      EsEventCard(
                        variant: EsEventCardVariant.compact,
                        title: "Jazz Night NYC",
                        category: "Music",
                        date: "Tonight, 8:00 PM",
                        price: "Free",
                        onTap: () => context.push('/event/evt003'),
                      ),
                      const SizedBox(width: 16),
                      EsEventCard(
                        variant: EsEventCardVariant.compact,
                        title: "Startup Pitch",
                        category: "Business",
                        date: "Tonight, 6:30 PM",
                        price: "\$29",
                        onTap: () => context.push('/event/evt004'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Upcoming
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: _isLoading
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: EsShimmer(width: double.infinity, height: 100, borderRadius: 16),
                  ),
                  childCount: 3,
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) return _buildSectionHeader("Upcoming Near You", "See all");
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: EsEventCard(
                        variant: EsEventCardVariant.compact,
                        title: "Electronic Beats Festival",
                        category: "Music",
                        date: "Apr 12, 2026",
                        location: "Brooklyn Warehouse",
                        price: "\$75",
                        onTap: () => context.push('/event/evt005'),
                      ),
                    );
                  },
                  childCount: 4,
                ),
              ),
        ),
        
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String action, {bool hasPulse = false}) {
    return Row(
      children: [
        if (hasPulse) ...[
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: EsColors.accent, shape: BoxShape.circle),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.5),
          const SizedBox(width: 8),
        ],
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(action, style: const TextStyle(color: EsColors.primary, fontSize: 13)),
        ),
      ],
    );
  }
}
