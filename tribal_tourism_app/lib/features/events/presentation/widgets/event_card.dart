import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback onBookTicket;
  final bool showFavorite;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onBookTicket,
    this.showFavorite = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // Main Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: event.images.first,
              width: double.infinity,
              height: 200,
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
                  size: 48,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          
          // Overlay gradient
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
                stops: const [0.6, 1.0],
              ),
            ),
          ),
          
          // Top row with badges and favorite
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.category.icon,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        event.category.displayName,
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Favorite button
                if (showFavorite)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Implement favorite functionality
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Status badges
          Positioned(
            top: 60,
            left: 12,
            child: Row(
              children: [
                // Discount badge
                if (event.hasDiscount)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.errorColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${event.discountPercentage.round()}% OFF',
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    event.status,
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Date and time
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(event.startDate),
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('hh:mm a').format(event.startDate),
                    style: AppTheme.bodySmall.copyWith(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Duration
          if (event.durationInDays > 1)
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${event.durationInDays} days',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: AppTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: AppTheme.successColor,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      event.rating.toString(),
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Location and venue
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${event.venue}, ${event.location}',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            event.description,
            style: AppTheme.bodyMedium.copyWith(
              color: Colors.grey[700],
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Highlights
          if (event.highlights.isNotEmpty)
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: event.highlights.take(3).map((highlight) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    highlight,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          
          const SizedBox(height: 12),
          
          // Organizer info
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey[200],
                backgroundImage: CachedNetworkImageProvider(event.organizerAvatar),
              ),
              const SizedBox(width: 6),
              Text(
                'by ${event.organizerName}',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${event.reviewCount} reviews',
                style: AppTheme.bodySmall.copyWith(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Price and booking section
          Row(
            children: [
              // Price section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (event.hasDiscount) ...[
                          Text(
                            '₹${event.originalPrice.toInt()}',
                            style: AppTheme.bodySmall.copyWith(
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          event.price == 0 ? 'Free' : '₹${event.price.toInt()}',
                          style: AppTheme.headingSmall.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (event.price > 0)
                      Text(
                        'per ticket',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                  ],
                ),
              ),
              
              // Availability and book button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (event.availableTickets <= 20 && event.hasTicketsAvailable)
                    Text(
                      '${event.availableTickets} tickets left',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.errorColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 100,
                    height: 36,
                    child: ElevatedButton(
                      onPressed: event.hasTicketsAvailable && event.isUpcoming 
                        ? onBookTicket 
                        : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: event.hasTicketsAvailable && event.isUpcoming
                          ? AppTheme.primaryColor
                          : Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        event.hasTicketsAvailable 
                          ? (event.isUpcoming ? 'Book Now' : 'Past Event')
                          : 'Sold Out',
                        style: AppTheme.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (event.status) {
      case 'Upcoming':
        return AppTheme.primaryColor;
      case 'Ongoing':
        return AppTheme.successColor;
      case 'Past':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}