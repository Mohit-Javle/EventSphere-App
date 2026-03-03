import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_textfield.dart';
import '../../shared/widgets/es_card.dart';

class CreateEventWizard extends StatefulWidget {
  const CreateEventWizard({super.key});

  @override
  State<CreateEventWizard> createState() => _CreateEventWizardState();
}

class _CreateEventWizardState extends State<CreateEventWizard> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsColors.bgBase,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Step $_currentStep of 4", style: Theme.of(context).textTheme.labelSmall),
        leading: IconButton(
          icon: const Icon(LucideIcons.x, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _currentStep / 4,
            backgroundColor: EsColors.bgBorder,
            color: EsColors.primary,
            minHeight: 2,
          ),
          Expanded(
            child: IndexedStack(
              index: _currentStep - 1,
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Let's start with\nthe basics", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 32),
          const EsTextField(label: "Event Title", hint: "e.g. Flutter Workshop"),
          const SizedBox(height: 20),
          const EsTextField(label: "Category", hint: "Select category", prefixIcon: LucideIcons.layers),
          const SizedBox(height: 20),
          const EsTextField(label: "Description", hint: "Tell us about your event", maxLines: 4),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Where & When?", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 32),
          const EsTextField(label: "Location", hint: "Search for a venue", prefixIcon: LucideIcons.mapPin),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(child: EsTextField(label: "Date", hint: "Mar 15, 2026", prefixIcon: LucideIcons.calendar)),
              SizedBox(width: 16),
              Expanded(child: EsTextField(label: "Time", hint: "10:00 AM", prefixIcon: LucideIcons.clock)),
            ],
          ),
          const SizedBox(height: 32),
          _buildMockMapPicker(),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tickets & Capacity", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 32),
          _buildTicketTypeItem("General Admission", "Free"),
          const SizedBox(height: 16),
          _buildTicketTypeItem("VIP Experience", "\$150.00"),
          const SizedBox(height: 32),
          EsButton(text: "Add Ticket Type", variant: EsButtonVariant.secondary, prefixIcon: LucideIcons.plus, width: double.infinity),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildStep4() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Almost there!", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 32),
          Text("Add a cover photo", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          _buildPhotoUploader(),
          const SizedBox(height: 32),
          Row(
            children: [
              const Icon(LucideIcons.circleCheck, color: EsColors.success, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text("I agree to EventSphere's Community Guidelines", style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: EsColors.bgElevated, border: Border(top: BorderSide(color: EsColors.bgBorder))),
      child: Row(
        children: [
          if (_currentStep > 1)
            IconButton(
              icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
              onPressed: () => setState(() => _currentStep--),
            ),
          const Spacer(),
          EsButton(
            text: _currentStep == 4 ? "Publish Event" : "Continue",
            onPressed: () {
              if (_currentStep < 4) {
                 setState(() => _currentStep++);
              } else {
                 context.pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMockMapPicker() {
    return EsCard(
      height: 200,
      variant: EsCardVariant.normal,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
           Container(color: const Color(0xFF2A2A3A)),
           const Center(child: Icon(LucideIcons.mapPin, color: EsColors.primary, size: 32)),
        ],
      ),
    );
  }

  Widget _buildTicketTypeItem(String title, String price) {
    return EsCard(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Text(price, style: const TextStyle(color: EsColors.textMuted, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(LucideIcons.pencil, color: EsColors.textMuted, size: 18),
        ],
      ),
    );
  }

  Widget _buildPhotoUploader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: EsColors.bgSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: EsColors.bgBorder, style: BorderStyle.none), // Custom dash logic omitted for brevity
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.imagePlus, color: EsColors.primary, size: 48),
          const SizedBox(height: 16),
          Text("Tap to upload cover", style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
