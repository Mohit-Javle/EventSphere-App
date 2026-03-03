import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_tab_bar.dart';
import '../../shared/widgets/es_event_card.dart';
import '../../shared/widgets/es_shimmer.dart';
import '../../shared/widgets/es_empty_state.dart';


class TicketsListScreen extends StatefulWidget {
  const TicketsListScreen({super.key});

  @override
  State<TicketsListScreen> createState() => _TicketsListScreenState();
}

class _TicketsListScreenState extends State<TicketsListScreen> {
  int _selectedTab = 0;
  bool _isLoading = false;
  bool _isEmpty = false;

  void _simulateState() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _simulateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Your Tickets", style: Theme.of(context).textTheme.displaySmall),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: EsTabBar(
              tabs: const ["Upcoming", "Past"],
              selectedIndex: _selectedTab,
              onTabChanged: (index) => setState(() => _selectedTab = index),
            ),
          ),
          Expanded(
            child: _isLoading 
              ? _buildLoading()
              : (_isEmpty ? _buildEmpty() : (_selectedTab == 0 ? _buildUpcoming() : _buildPast())),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 3,
      itemBuilder: (context, index) => EsShimmer.card(),
    );
  }

  Widget _buildEmpty() {
    return EsEmptyState(
      title: "No tickets found",
      description: "You haven't purchased any tickets yet. Explore trending events to get started!",
      actionLabel: "Explore Events",
      onAction: () => setState(() => _isEmpty = false),
    );
  }

  Widget _buildUpcoming() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return EsEventCard(
          variant: EsEventCardVariant.compact,
          title: "Flutter Forward 2026",
          category: "Tech",
          date: "Mar 15, 2026",
          location: "Moscone Center, SF",
          price: "Ticket #ES-2401",
          onTap: () => context.push('/ticket/tk001'),
        );
      },
    );
  }

  Widget _buildPast() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: 1,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return Opacity(
          opacity: 0.6,
          child: const EsEventCard(
            variant: EsEventCardVariant.compact,
            title: "Global AI Summit 2025",
            category: "Tech",
            date: "Nov 12, 2025",
            location: "Virtual",
            price: "Completed",
          ),
        );
      },
    );
  }
}
