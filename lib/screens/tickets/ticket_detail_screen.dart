import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../providers/event_provider.dart';
import '../../theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class TicketDetailScreen extends StatelessWidget {
  final String ticketId;
  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);
    final ticket = eventProvider.purchasedTickets.firstWhere((t) => t.id == ticketId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Details"),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: isDark ? AppColors.textSecondaryDark.withValues(alpha: 0.1) : AppColors.textSecondaryLight.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  // QR Code
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: QrImageView(
                      data: ticket.qrCodeData,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Scan this QR at the venue",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 32),
                  _buildDetailRow(context, "Event", ticket.event.title),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, "Date", DateFormat('MMMM dd, yyyy').format(ticket.event.dateTime)),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, "Time", "09:00 AM"),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, "Category", ticket.event.category),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, "Ticket Tier", ticket.tierName),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, "Price", ticket.price),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Ticket ID: ${ticket.id.substring(0, 8).toUpperCase()}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
