import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:confetti/confetti.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_card.dart';
import '../../shared/widgets/es_textfield.dart';

class TicketPurchaseScreen extends StatefulWidget {
  final String id;
  const TicketPurchaseScreen({super.key, required this.id});

  @override
  State<TicketPurchaseScreen> createState() => _TicketPurchaseScreenState();
}

class _TicketPurchaseScreenState extends State<TicketPurchaseScreen> {
  int _currentStep = 1;
  String _selectedTier = "General Admission";
  final ConfettiController _confettiController = ConfettiController(duration: const Duration(seconds: 3));

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: _buildStepIndicator(),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => _currentStep > 1 ? setState(() => _currentStep--) : context.pop(),
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentStep - 1,
            children: [
              _buildStep1Select(),
              _buildStep2Payment(),
              _buildStep3Confirm(),
            ],
          ),
          if (_currentStep == 3)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [EsColors.primary, EsColors.accent, Colors.white],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final step = index + 1;
        final isActive = _currentStep == step;
        final isCompleted = _currentStep > step;
        return Row(
          children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? EsColors.primary : (isActive ? Colors.transparent : EsColors.bgBorder),
                shape: BoxShape.circle,
                border: isActive ? Border.all(color: EsColors.primary, width: 2) : null,
              ),
              child: Center(
                child: isCompleted 
                  ? const Icon(LucideIcons.check, color: Colors.white, size: 14)
                  : Text("$step", style: TextStyle(color: isActive ? EsColors.primary : Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
            if (index < 2)
              Container(width: 20, height: 2, color: isCompleted ? EsColors.primary : EsColors.bgBorder, margin: const EdgeInsets.symmetric(horizontal: 4)),
          ],
        );
      }),
    );
  }

  Widget _buildStep1Select() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Your Ticket", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          _buildTierOption("General Admission", "Access to main stage and networking area", "\$49.00"),
          const SizedBox(height: 16),
          _buildTierOption("VIP Access", "Front row, VIP lounge, and lunch included", "\$149.00"),
          const SizedBox(height: 16),
          _buildTierOption("Early Bird", "Sold out", "\$29.00", isSoldOut: true),
          
          const SizedBox(height: 40),
          EsCard(
            child: Row(
              children: [
                const Icon(LucideIcons.ticket, color: EsColors.textMuted),
                const SizedBox(width: 12),
                Expanded(child: Text("Promo Code", style: Theme.of(context).textTheme.bodyMedium)),
                TextButton(onPressed: () {}, child: const Text("Apply")),
              ],
            ),
          ),
          
          const SizedBox(height: 100),
          _buildSummaryBar("Total: \$49.00", "Continue to Payment →", () => setState(() => _currentStep = 2)),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildTierOption(String title, String desc, String price, {bool isSoldOut = false}) {
    final bool isSelected = _selectedTier == title;
    return GestureDetector(
      onTap: isSoldOut ? null : () => setState(() => _selectedTier = title),
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? EsColors.primary.withValues(alpha: 0.1) : EsColors.bgElevated,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? EsColors.primary : EsColors.bgBorder, width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: isSoldOut ? EsColors.textMuted : Colors.white)),
                  Text(desc, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(price, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: isSoldOut ? EsColors.textMuted : EsColors.success)),
          ],
        ),
      ),
    );
  }

  Widget _buildStep2Payment() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Payment Method", style: Theme.of(context).textTheme.displaySmall),
           const SizedBox(height: 24),
           EsButton(text: "Google Pay", variant: EsButtonVariant.ghost, prefixIcon: LucideIcons.globe, width: double.infinity, onPressed: () {}),
           const SizedBox(height: 16),
           const Center(child: Text("— or pay with card —", style: TextStyle(color: EsColors.textMuted))),
           const SizedBox(height: 24),
           const EsTextField(label: "Card Number", hint: "0000 0000 0000 0000", prefixIcon: LucideIcons.creditCard),
           const SizedBox(height: 16),
           const Row(
             children: [
               Expanded(child: EsTextField(label: "Expiry", hint: "MM/YY")),
               SizedBox(width: 16),
               Expanded(child: EsTextField(label: "CVV", hint: "123")),
             ],
           ),
           const SizedBox(height: 16),
           const EsTextField(label: "Cardholder Name"),
           
           const SizedBox(height: 100),
           _buildSummaryBar("Total: \$49.00", "Pay \$49.00 →", () {
             setState(() => _currentStep = 3);
             _confettiController.play();
           }),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildStep3Confirm() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.circleCheck, color: EsColors.success, size: 80)
                .animate().scale(duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            Text("Ticket Confirmed! 🎉", style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 12),
            Text(
              "Your ticket has been sent to your email",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: EsColors.textSecondary),
            ),
            const SizedBox(height: 48),
            EsCard(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.calendar, color: EsColors.primary, size: 16),
                      const SizedBox(width: 8),
                      Text("Mar 15, 2026 · 10:00 AM", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, color: EsColors.primary, size: 16),
                      const SizedBox(width: 8),
                      Text("Moscone Center, SF", style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            EsButton(text: "View My Ticket", onPressed: () => context.go('/home'), width: double.infinity),
            const SizedBox(height: 16),
            EsButton(text: "Share Event", variant: EsButtonVariant.secondary, width: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryBar(String priceLabel, String btnLabel, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Text(priceLabel, style: Theme.of(context).textTheme.displaySmall),
          const Spacer(),
          EsButton(text: btnLabel, onPressed: onTap),
        ],
      ),
    );
  }
}
