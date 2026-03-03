import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pill_tag.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/event_provider.dart';
import '../../models/event.dart';

import '../../providers/location_provider.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    final trendingEvents = eventProvider.trendingEvents;
    final filteredEvents = eventProvider.events;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Location",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              locationProvider.currentAddress,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(width: 4),
                            Icon(LucideIcons.chevronDown, size: 20, color: AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark 
                                ? AppColors.textSecondaryDark.withValues(alpha: 0.1) 
                                : AppColors.textSecondaryLight.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(LucideIcons.search, size: 20, color: AppColors.textSecondaryDark),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                  hintText: "Find events...",
                                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                      ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                onChanged: (value) => eventProvider.setSearchQuery(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(LucideIcons.slidersHorizontal, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // Filter Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      _buildCategoryChip(context, "All"),
                      const SizedBox(width: 12),
                      _buildCategoryChip(context, "Tech"),
                      const SizedBox(width: 12),
                      _buildCategoryChip(context, "Music"),
                      const SizedBox(width: 12),
                      _buildCategoryChip(context, "Workshops"),
                      const SizedBox(width: 12),
                      _buildCategoryChip(context, "Business"),
                    ],
                  ),
                ),
              ),
            ),

            // Trending Events Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending Features",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Text(
                      "See All",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),

            // Horizontal Events List
            SliverToBoxAdapter(
              child: SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: trendingEvents.length,
                  itemBuilder: (context, index) {
                    final event = trendingEvents[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () => context.push('/event/${event.id}'),
                        child: _buildEventCard(context, event),
                      ),
                    );
                  },
                ),
              ),
            ),

            // All Events Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "Explore Events",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),

            // Responsive Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : (MediaQuery.of(context).size.width > 600 ? 2 : 1),
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1.5,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final event = filteredEvents[index];
                    return GestureDetector(
                      onTap: () => context.push('/event/${event.id}'),
                      child: _buildEventCard(context, event),
                    );
                  },
                  childCount: filteredEvents.length,
                ),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);
    final isSelected = eventProvider.selectedCategory == label;
    
    return GestureDetector(
      onTap: () => eventProvider.setCategory(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary 
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : (isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.2) : AppColors.textSecondaryLight.withValues(alpha: 0.2)),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, EventModel event) {
    return Hero(
      tag: 'event_image_${event.id}',
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: CachedNetworkImageProvider(event.bannerUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  PillTag(
                    text: event.category,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.8),
                    textColor: Colors.white,
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.transparent,
                child: Text(
                  event.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(LucideIcons.mapPin, size: 14, color: Colors.white70),
                  const SizedBox(width: 4),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      event.location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
