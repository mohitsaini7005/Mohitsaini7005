import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/gradient_button.dart';

class ProductFilterSheet extends StatefulWidget {
  final String selectedCategory;
  final double minPrice;
  final double maxPrice;
  final Function(String, double, double) onApplyFilters;

  const ProductFilterSheet({
    super.key,
    required this.selectedCategory,
    required this.minPrice,
    required this.maxPrice,
    required this.onApplyFilters,
  });

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  late String _selectedCategory;
  late RangeValues _priceRange;
  double _selectedRating = 0.0;
  bool _handmadeOnly = false;
  bool _freeShippingOnly = false;
  String _selectedOrigin = 'All';

  final List<String> _categories = [
    'All',
    'Handicrafts',
    'Clothing',
    'Jewelry',
    'Food & Spices',
    'Art',
    'Home Decor',
    'Musical Instruments',
    'Textiles',
  ];

  final List<String> _origins = [
    'All',
    'Chhattisgarh',
    'Rajasthan',
    'Odisha',
    'Himachal Pradesh',
    'Maharashtra',
    'Gujarat',
    'Karnataka',
    'Kerala',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _priceRange = RangeValues(widget.minPrice, widget.maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryFilter(),
                  const SizedBox(height: 24),
                  _buildPriceFilter(),
                  const SizedBox(height: 24),
                  _buildRatingFilter(),
                  const SizedBox(height: 24),
                  _buildOriginFilter(),
                  const SizedBox(height: 24),
                  _buildSpecialFilters(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    ).animate()
      .slideY(begin: 1, duration: 300.ms, curve: Curves.easeOut)
      .fadeIn(duration: 300.ms);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Filters',
            style: AppTheme.headingSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: _clearFilters,
                child: Text(
                  'Clear All',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categories.map((category) {
            final isSelected = _selectedCategory == category;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected 
                    ? const LinearGradient(colors: AppTheme.secondaryGradient)
                    : null,
                  color: isSelected ? null : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected 
                    ? null
                    : Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  category,
                  style: AppTheme.bodySmall.copyWith(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price Range',
              style: AppTheme.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '₹${_priceRange.start.round()} - ₹${_priceRange.end.round()}',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 10000,
          divisions: 40,
          activeColor: AppTheme.secondaryColor,
          inactiveColor: AppTheme.secondaryColor.withOpacity(0.3),
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹0',
              style: AppTheme.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              '₹10,000',
              style: AppTheme.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Minimum Rating',
              style: AppTheme.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppTheme.warningColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  _selectedRating == 0.0 ? 'Any' : _selectedRating.toString(),
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Slider(
          value: _selectedRating,
          min: 0.0,
          max: 5.0,
          divisions: 5,
          activeColor: AppTheme.secondaryColor,
          inactiveColor: AppTheme.secondaryColor.withOpacity(0.3),
          onChanged: (double value) {
            setState(() {
              _selectedRating = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildOriginFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Origin State',
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _origins.map((origin) {
            final isSelected = _selectedOrigin == origin;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOrigin = origin;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: isSelected 
                    ? const LinearGradient(colors: AppTheme.secondaryGradient)
                    : null,
                  color: isSelected ? null : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected 
                    ? null
                    : Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  origin,
                  style: AppTheme.bodySmall.copyWith(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpecialFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Special Filters',
          style: AppTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        
        // Handmade only
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: CheckboxListTile(
            value: _handmadeOnly,
            onChanged: (value) {
              setState(() {
                _handmadeOnly = value ?? false;
              });
            },
            title: Text(
              'Handmade Products Only',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Show only authentic handcrafted items',
              style: AppTheme.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
            activeColor: AppTheme.secondaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Free shipping only
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: CheckboxListTile(
            value: _freeShippingOnly,
            onChanged: (value) {
              setState(() {
                _freeShippingOnly = value ?? false;
              });
            },
            title: Text(
              'Free Shipping Only',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              'Products with free delivery',
              style: AppTheme.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
            activeColor: AppTheme.secondaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _clearFilters,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: AppTheme.secondaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Clear',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: GradientButton(
              text: 'Apply Filters',
              onPressed: () {
                widget.onApplyFilters(
                  _selectedCategory,
                  _priceRange.start,
                  _priceRange.end,
                );
                Navigator.pop(context);
              },
              height: 56,
              gradient: const LinearGradient(
                colors: AppTheme.secondaryGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _priceRange = const RangeValues(0, 10000);
      _selectedRating = 0.0;
      _handmadeOnly = false;
      _freeShippingOnly = false;
      _selectedOrigin = 'All';
    });
  }
}