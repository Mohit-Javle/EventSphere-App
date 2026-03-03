import 'package:flutter/material.dart';
import '../../shared/theme/es_colors.dart';
import '../../shared/widgets/es_button.dart';
import '../../shared/widgets/es_chip.dart';

class SearchFilterSheet extends StatefulWidget {
  const SearchFilterSheet({super.key});

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  String _selectedDate = "All Time";
  String _selectedCategory = "All";
  RangeValues _priceRange = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: EsColors.bgBase,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filters", style: Theme.of(context).textTheme.displaySmall),
              TextButton(onPressed: () {}, child: const Text("Reset", style: TextStyle(color: EsColors.textMuted))),
            ],
          ),
          const SizedBox(height: 24),
          
          Text("Category", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ["All", "Tech", "Music", "Art", "Business", "Sports", "Networking"].map((cat) {
              return EsChip(
                label: cat,
                variant: EsChipVariant.filter,
                isSelected: _selectedCategory == cat,
                onTap: () => setState(() => _selectedCategory = cat),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          Text("Date Range", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ["All Time", "Today", "This Week", "This Month"].map((date) {
              return EsChip(
                label: date,
                variant: EsChipVariant.filter,
                isSelected: _selectedDate == date,
                onTap: () => setState(() => _selectedDate = date),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Price Range", style: Theme.of(context).textTheme.headlineMedium),
              Text("\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}", style: const TextStyle(color: EsColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 1000,
            activeColor: EsColors.primary,
            inactiveColor: EsColors.bgBorder,
            onChanged: (val) => setState(() => _priceRange = val),
          ),
          
          const SizedBox(height: 40),
          
          EsButton(
            text: "Apply Filters",
            onPressed: () => Navigator.pop(context),
            width: double.infinity,
          ),
          
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
