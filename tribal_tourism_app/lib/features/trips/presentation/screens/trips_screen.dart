import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/trip.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../widgets/trip_card.dart';
import '../widgets/trip_filter_sheet.dart';
import '../widgets/search_bar_widget.dart';

class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Popular';
  double _minPrice = 0;
  double _maxPrice = 10000;
  
  final List<String> _categories = [
    'All',
    'Cultural Tour',
    'Homestay',
    'Adventure',
    'Festival',
    'Trekking',
    'Wildlife',
    'Food Tour',
    'Craft Workshop',
  ];

  final List<String> _sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
    'Duration',
    'Recent',
  ];

  // Mock data - In real app, this would come from a provider/repository
  final List<Trip> _mockTrips = [
    Trip(
      id: '1',
      title: 'Authentic Tribal Village Experience',
      description: 'Immerse yourself in the rich culture and traditions of the Gond tribe',
      location: 'Chhattisgarh, India',
      region: 'Central India',
      images: [
        'https://images.unsplash.com/photo-1539650116574-75c0c6d93d91?w=800',
        'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=800',
      ],
      price: 2500,
      originalPrice: 3500,
      duration: 3,
      maxGuests: 8,
      rating: 4.8,
      reviewCount: 127,
      highlights: ['Traditional cooking class', 'Local craft workshop', 'Cultural performance'],
      inclusions: ['Accommodation', 'All meals', 'Local guide'],
      exclusions: ['Transport to location', 'Personal expenses'],
      difficulty: 'Easy',
      tags: ['Cultural', 'Authentic', 'Educational'],
      hostId: 'host1',
      hostName: 'Ramesh Kumar',
      hostAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      isActive: true,
      isFeatured: true,
      category: TripCategory.culturalTour,
      coordinates: {'lat': 22.0797, 'lng': 82.1391},
    ),
    Trip(
      id: '2',
      title: 'Himalayan Tribal Trek',
      description: 'Trek through remote tribal villages in the Himalayas',
      location: 'Himachal Pradesh, India',
      region: 'Northern India',
      images: [
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        'https://images.unsplash.com/photo-1605538883669-825200433431?w=800',
      ],
      price: 4500,
      originalPrice: 5200,
      duration: 7,
      maxGuests: 12,
      rating: 4.9,
      reviewCount: 89,
      highlights: ['High altitude trekking', 'Tribal village stays', 'Mountain views'],
      inclusions: ['Trekking guide', 'Camping equipment', 'All meals'],
      exclusions: ['Travel insurance', 'Personal trekking gear'],
      difficulty: 'Moderate',
      tags: ['Trekking', 'Adventure', 'Mountains'],
      hostId: 'host2',
      hostName: 'Priya Sharma',
      hostAvatar: 'https://images.unsplash.com/photo-1494790108755-2616c9e04582?w=150',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
      isActive: true,
      isFeatured: true,
      category: TripCategory.trekking,
      coordinates: {'lat': 32.2432, 'lng': 77.1892},
    ),
    Trip(
      id: '3',
      title: 'Traditional Craft Workshop',
      description: 'Learn traditional pottery and weaving from master artisans',
      location: 'Rajasthan, India',
      region: 'Western India',
      images: [
        'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
        'https://images.unsplash.com/photo-1571115764595-644a1f56a55c?w=800',
      ],
      price: 1800,
      originalPrice: 2200,
      duration: 2,
      maxGuests: 15,
      rating: 4.7,
      reviewCount: 203,
      highlights: ['Hands-on pottery', 'Traditional weaving', 'Take home crafts'],
      inclusions: ['All materials', 'Refreshments', 'Certificate'],
      exclusions: ['Accommodation', 'Transportation'],
      difficulty: 'Easy',
      tags: ['Crafts', 'Workshop', 'Traditional'],
      hostId: 'host3',
      hostName: 'Kailash Patel',
      hostAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
      isActive: true,
      isFeatured: false,
      category: TripCategory.craftWorkshop,
      coordinates: {'lat': 26.9124, 'lng': 75.7873},
    ),
  ];

  List<Trip> get _filteredTrips {
    List<Trip> filtered = List.from(_mockTrips);
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((trip) =>
        trip.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        trip.location.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        trip.description.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }
    
    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((trip) =>
        trip.category.displayName == _selectedCategory
      ).toList();
    }
    
    // Filter by price range
    filtered = filtered.where((trip) =>
      trip.price >= _minPrice && trip.price <= _maxPrice
    ).toList();
    
    // Sort
    switch (_sortBy) {
      case 'Price: Low to High':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Duration':
        filtered.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case 'Recent':
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Popular':
      default:
        filtered.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTrips = _filteredTrips;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildSearchAndFilters()),
          SliverToBoxAdapter(child: _buildCategoryTabs()),
          SliverToBoxAdapter(child: _buildResultsHeader(filteredTrips.length)),
          _buildTripsList(filteredTrips),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppTheme.primaryGradient,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Discover Trips',
                    style: AppTheme.headingMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Implement map view
                    },
                    icon: const Icon(
                      Icons.map_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: SearchBarWidget(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: IconButton(
              onPressed: () {
                _showFilterSheet();
              },
              icon: const Icon(
                Icons.tune,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          
          return Container(
            margin: EdgeInsets.only(right: index < _categories.length - 1 ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected 
                    ? const LinearGradient(colors: AppTheme.primaryGradient)
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildResultsHeader(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count trips found',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              _showSortOptions();
            },
            child: Row(
              children: [
                Text(
                  'Sort by: $_sortBy',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList(List<Trip> trips) {
    if (trips.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No trips found',
                style: AppTheme.headingSmall.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters or search terms',
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index < trips.length - 1 ? 16 : 0),
              child: TripCard(
                trip: trips[index],
                onTap: () {
                  // TODO: Navigate to trip details
                },
              ).animate()
                .slideY(delay: (index * 100).ms, duration: 400.ms)
                .fadeIn(delay: (index * 100).ms, duration: 400.ms),
            );
          },
          childCount: trips.length,
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TripFilterSheet(
        selectedCategory: _selectedCategory,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        onApplyFilters: (category, minPrice, maxPrice) {
          setState(() {
            _selectedCategory = category;
            _minPrice = minPrice;
            _maxPrice = maxPrice;
          });
        },
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: AppTheme.headingSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._sortOptions.map((option) => ListTile(
              title: Text(option),
              trailing: _sortBy == option 
                ? const Icon(Icons.check, color: AppTheme.primaryColor)
                : null,
              onTap: () {
                setState(() {
                  _sortBy = option;
                });
                Navigator.pop(context);
              },
            )).toList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}