import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../../theme/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);
    final tickets = eventProvider.purchasedTickets;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  "My Tickets",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            if (tickets.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.ticket, size: 80, color: isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.3) : AppColors.textSecondaryLight.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        "No tickets yet",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Events you join will appear here.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ticket = tickets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () => context.push('/ticket/${ticket.id}'),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.1) : AppColors.textSecondaryLight.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(ticket.event.bannerUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ticket.event.title,
                                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('MMM dd, yyyy').format(ticket.event.dateTime),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        ticket.tierName,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(LucideIcons.chevronRight, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: tickets.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
