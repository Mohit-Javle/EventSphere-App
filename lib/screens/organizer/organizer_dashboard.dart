import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_card.dart';

class OrganizerDashboard extends StatelessWidget {
  const OrganizerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dashboard", style: Theme.of(context).textTheme.displaySmall),
        actions: [
          IconButton(icon: const Icon(LucideIcons.settings, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                Expanded(child: _buildQuickStat("Total Revenue", "\$12,480", "+12%", LucideIcons.dollarSign, EsColors.success)),
                const SizedBox(width: 16),
                Expanded(child: _buildQuickStat("Tickets Sold", "842", "+5%", LucideIcons.ticket, EsColors.primary)),
              ],
            ),
            const SizedBox(height: 24),
            
            // Sales Chart
            Text("Sales Overview", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            EsCard(
              height: 250,
              padding: const EdgeInsets.all(20),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3), FlSpot(1, 1), FlSpot(2, 4), FlSpot(3, 2), FlSpot(4, 5), FlSpot(5, 3), FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: EsColors.primary,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [EsColors.primary.withValues(alpha: 0.3), EsColors.primary.withValues(alpha: 0)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(begin: 0.1).fadeIn(),
            
            const SizedBox(height: 32),
            
            // Active Events
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Active Events", style: Theme.of(context).textTheme.headlineMedium),
                TextButton(onPressed: () {}, child: const Text("View all")),
              ],
            ),
            const SizedBox(height: 12),
            _buildEventLegacyItem("Flutter Forward 2026", "540/600 Tickets", 0.9),
            _buildEventLegacyItem("UI/UX Workshop", "120/150 Tickets", 0.8),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/create-event'), // Navigate to create event
        backgroundColor: EsColors.primary,
        icon: const Icon(LucideIcons.plus, color: Colors.white),
        label: const Text("Create Event", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildQuickStat(String title, String val, String trend, IconData icon, Color color) {
    return EsCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: EsColors.textMuted, fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(trend, style: TextStyle(color: EsColors.success, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventLegacyItem(String title, String subtitle, double progress) {
    return EsCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: EsColors.bgSurface, borderRadius: BorderRadius.circular(12)),
                child: const Icon(LucideIcons.image, color: EsColors.textMuted),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(color: EsColors.textMuted, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(LucideIcons.chevronRight, color: EsColors.textMuted),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: EsColors.bgBorder,
            color: EsColors.primary,
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
