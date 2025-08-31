import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final bool showFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
    this.showFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
            _buildPriceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 140,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Stack(
        children: [
          // Main Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: product.images.first,
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  size: 32,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          
          // Top badges
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Discount badge
                if (product.hasDiscount)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.errorColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${product.discountPercentage.round()}% OFF',
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                
                // Favorite button
                if (showFavorite)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Implement favorite functionality
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 28,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Stock status
          if (!product.inStock)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Out of Stock',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              product.category.displayName,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 6),
          
          // Product name
          Text(
            product.name,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 4),
          
          // Rating and reviews
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppTheme.warningColor,
                size: 12,
              ),
              const SizedBox(width: 2),
              Text(
                product.rating.toString(),
                style: AppTheme.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${product.reviewCount})',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.grey[600],
                  fontSize: 10,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          // Origin
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 12,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  product.origin,
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 4),
          
          // Handmade badge
          if (product.isHandmade)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: AppTheme.successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Handmade',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.successColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Price row
          Row(
            children: [
              // Current price
              Text(
                '₹${product.price.toInt()}',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(width: 6),
              
              // Original price (if discounted)
              if (product.hasDiscount)
                Text(
                  '₹${product.originalPrice.toInt()}',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.grey[500],
                    decoration: TextDecoration.lineThrough,
                    fontSize: 11,
                  ),
                ),
              
              const Spacer(),
              
              // Stock count
              if (product.stockQuantity <= 5 && product.inStock)
                Text(
                  '${product.stockQuantity} left',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.errorColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Add to cart button
          SizedBox(
            width: double.infinity,
            height: 32,
            child: ElevatedButton(
              onPressed: product.inStock ? onAddToCart : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: product.inStock 
                  ? AppTheme.primaryColor 
                  : Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    product.inStock ? 'Add to Cart' : 'Out of Stock',
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}