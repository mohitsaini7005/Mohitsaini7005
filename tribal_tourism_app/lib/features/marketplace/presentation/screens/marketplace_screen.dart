import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/product_filter_sheet.dart';
import '../../../../features/trips/presentation/widgets/search_bar_widget.dart';

class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _sortBy = 'Popular';
  double _minPrice = 0;
  double _maxPrice = 5000;
  
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

  final List<String> _sortOptions = [
    'Popular',
    'Price: Low to High',
    'Price: High to Low',
    'Rating',
    'Newest',
    'Best Selling',
  ];

  // Mock data
  final List<Product> _mockProducts = [
    Product(
      id: '1',
      name: 'Handwoven Tribal Basket',
      description: 'Beautiful handwoven basket made by Gond artisans using traditional techniques',
      images: [
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
        'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
      ],
      price: 850,
      originalPrice: 1200,
      currency: 'INR',
      stockQuantity: 15,
      category: ProductCategory.handicrafts,
      subcategory: 'Baskets',
      rating: 4.8,
      reviewCount: 67,
      sellerId: 'seller1',
      sellerName: 'Tribal Crafts Co.',
      sellerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      tags: ['handmade', 'traditional', 'eco-friendly'],
      specifications: {'material': 'Bamboo', 'size': '30cm x 25cm', 'weight': '500g'},
      colors: ['Natural', 'Brown'],
      sizes: ['Medium', 'Large'],
      origin: 'Chhattisgarh, India',
      material: 'Bamboo',
      isHandmade: true,
      isFeatured: true,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
      shippingInfo: const ShippingInfo(
        freeShipping: true,
        shippingCost: 0,
        estimatedDays: 5,
        availableCountries: ['India', 'USA', 'UK'],
      ),
    ),
    Product(
      id: '2',
      name: 'Traditional Tribal Jewelry Set',
      description: 'Authentic silver jewelry set crafted by skilled tribal artisans',
      images: [
        'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800',
        'https://images.unsplash.com/photo-1506630448388-4e683c67ddb0?w=800',
      ],
      price: 2500,
      originalPrice: 3200,
      currency: 'INR',
      stockQuantity: 8,
      category: ProductCategory.jewelry,
      subcategory: 'Necklaces',
      rating: 4.9,
      reviewCount: 134,
      sellerId: 'seller2',
      sellerName: 'Silver Heritage',
      sellerAvatar: 'https://images.unsplash.com/photo-1494790108755-2616c9e04582?w=150',
      tags: ['silver', 'traditional', 'handcrafted'],
      specifications: {'purity': '92.5% Silver', 'weight': '45g', 'length': '18 inches'},
      colors: ['Silver'],
      sizes: ['One Size'],
      origin: 'Rajasthan, India',
      material: 'Sterling Silver',
      isHandmade: true,
      isFeatured: true,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
      shippingInfo: const ShippingInfo(
        freeShipping: false,
        shippingCost: 150,
        estimatedDays: 3,
        availableCountries: ['India'],
      ),
    ),
    Product(
      id: '3',
      name: 'Organic Tribal Spice Mix',
      description: 'Premium blend of organic spices used in traditional tribal cuisine',
      images: [
        'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800',
        'https://images.unsplash.com/photo-1505935428862-770b6f24f629?w=800',
      ],
      price: 450,
      originalPrice: 550,
      currency: 'INR',
      stockQuantity: 50,
      category: ProductCategory.food,
      subcategory: 'Spices',
      rating: 4.7,
      reviewCount: 89,
      sellerId: 'seller3',
      sellerName: 'Tribal Flavors',
      sellerAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      tags: ['organic', 'spices', 'traditional'],
      specifications: {'weight': '250g', 'shelf_life': '12 months', 'packaging': 'Glass jar'},
      colors: [],
      sizes: ['250g', '500g'],
      origin: 'Odisha, India',
      material: 'Organic spices',
      isHandmade: true,
      isFeatured: false,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
      shippingInfo: const ShippingInfo(
        freeShipping: true,
        shippingCost: 0,
        estimatedDays: 4,
        availableCountries: ['India', 'USA'],
      ),
    ),
  ];

  List<Product> get _filteredProducts {
    List<Product> filtered = List.from(_mockProducts);
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((product) =>
        product.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        product.description.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        product.tags.any((tag) => tag.toLowerCase().contains(_searchController.text.toLowerCase()))
      ).toList();
    }
    
    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((product) =>
        product.category.displayName == _selectedCategory
      ).toList();
    }
    
    // Filter by price range
    filtered = filtered.where((product) =>
      product.price >= _minPrice && product.price <= _maxPrice
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
      case 'Newest':
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Best Selling':
        filtered.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
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
    final filteredProducts = _filteredProducts;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildSearchAndFilters()),
          SliverToBoxAdapter(child: _buildCategoryTabs()),
          SliverToBoxAdapter(child: _buildResultsHeader(filteredProducts.length)),
          _buildProductsGrid(filteredProducts),
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
              colors: AppTheme.secondaryGradient,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Marketplace',
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
                      // TODO: Implement cart
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
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
              hintText: 'Search products...',
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.secondaryColor.withOpacity(0.2),
              ),
            ),
            child: IconButton(
              onPressed: () {
                _showFilterSheet();
              },
              icon: const Icon(
                Icons.tune,
                color: AppTheme.secondaryColor,
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
            '$count products found',
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
                    color: AppTheme.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppTheme.secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(List<Product> products) {
    if (products.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No products found',
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
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(
              product: products[index],
              onTap: () {
                // TODO: Navigate to product details
              },
              onAddToCart: () {
                // TODO: Add to cart functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${products[index].name} added to cart!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ).animate()
              .slideY(delay: (index * 100).ms, duration: 400.ms)
              .fadeIn(delay: (index * 100).ms, duration: 400.ms);
          },
          childCount: products.length,
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductFilterSheet(
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
                ? const Icon(Icons.check, color: AppTheme.secondaryColor)
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