import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/event.dart';
import '../widgets/event_card.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  String _selectedFilter = 'Upcoming';
  
  final List<String> _filterOptions = [
    'All',
    'Upcoming',
    'This Weekend',
    'This Month',
    'Free Events',
  ];

  // Mock data
  final List<Event> _mockEvents = [
    Event(
      id: '1',
      title: 'Gond Tribal Festival',
      description: 'Experience the vibrant culture of the Gond tribe with traditional music, dance, and art exhibitions.',
      location: 'Chhattisgarh, India',
      venue: 'Cultural Heritage Park',
      images: [
        'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800',
        'https://images.unsplash.com/photo-1543832923-44667a44c807?w=800',
      ],
      startDate: DateTime.now().add(const Duration(days: 15)),
      endDate: DateTime.now().add(const Duration(days: 17)),
      price: 500,
      originalPrice: 750,
      currency: 'INR',
      availableTickets: 150,
      totalTickets: 300,
      category: EventCategory.festival,
      type: EventType.outdoor,
      rating: 4.8,
      reviewCount: 245,
      organizerId: 'org1',
      organizerName: 'Tribal Culture Foundation',
      organizerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      tags: ['traditional', 'music', 'dance', 'art'],
      highlights: ['Traditional performances', 'Art exhibitions', 'Local cuisine', 'Craft workshops'],
      ageRestriction: 'All ages',
      isRefundable: true,
      isFeatured: true,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      ticketInfo: TicketInfo(
        ticketType: 'Digital',
        isDigital: true,
        requiresID: false,
        cancellationPolicy: 'Full refund up to 7 days before event',
        lastBookingDate: DateTime.now().add(const Duration(days: 10)),
      ),
      coordinates: {'lat': 21.2787, 'lng': 81.8661},
      schedule: [
        EventSchedule(
          id: 's1',
          title: 'Opening Ceremony',
          description: 'Traditional welcome ceremony with tribal elders',
          startTime: DateTime.now().add(const Duration(days: 15, hours: 10)),
          endTime: DateTime.now().add(const Duration(days: 15, hours: 11)),
          location: 'Main Stage',
          performers: ['Tribal Council', 'Local Musicians'],
        ),
      ],
    ),
    Event(
      id: '2',
      title: 'Himalayan Folk Music Concert',
      description: 'An evening of soulful folk music from the Himalayan region featuring renowned tribal musicians.',
      location: 'Himachal Pradesh, India',
      venue: 'Mountain View Amphitheater',
      images: [
        'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=800',
        'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
      ],
      startDate: DateTime.now().add(const Duration(days: 7)),
      endDate: DateTime.now().add(const Duration(days: 7)),
      price: 800,
      originalPrice: 800,
      currency: 'INR',
      availableTickets: 80,
      totalTickets: 200,
      category: EventCategory.concert,
      type: EventType.outdoor,
      rating: 4.9,
      reviewCount: 156,
      organizerId: 'org2',
      organizerName: 'Mountain Music Society',
      organizerAvatar: 'https://images.unsplash.com/photo-1494790108755-2616c9e04582?w=150',
      tags: ['music', 'folk', 'himalayan', 'acoustic'],
      highlights: ['Live performances', 'Traditional instruments', 'Mountain backdrop', 'Local food stalls'],
      ageRestriction: '12+',
      isRefundable: true,
      isFeatured: true,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
      ticketInfo: TicketInfo(
        ticketType: 'Physical',
        isDigital: false,
        requiresID: true,
        cancellationPolicy: '80% refund up to 3 days before event',
        lastBookingDate: DateTime.now().add(const Duration(days: 5)),
      ),
      coordinates: {'lat': 31.1048, 'lng': 77.1734},
      schedule: [
        EventSchedule(
          id: 's2',
          title: 'Folk Music Performance',
          description: 'Traditional Himalayan folk songs and instruments',
          startTime: DateTime.now().add(const Duration(days: 7, hours: 18)),
          endTime: DateTime.now().add(const Duration(days: 7, hours: 21)),
          location: 'Main Stage',
          performers: ['Karma Band', 'Local Folk Artists'],
        ),
      ],
    ),
  ];

  List<Event> get _filteredEvents {
    List<Event> filtered = List.from(_mockEvents);
    
    switch (_selectedFilter) {
      case 'Upcoming':
        filtered = filtered.where((event) => event.isUpcoming).toList();
        break;
      case 'This Weekend':
        final now = DateTime.now();
        final weekend = now.add(Duration(days: (6 - now.weekday) % 7));
        final nextMonday = weekend.add(const Duration(days: 2));
        filtered = filtered.where((event) =>
          event.startDate.isAfter(weekend) && event.startDate.isBefore(nextMonday)
        ).toList();
        break;
      case 'This Month':
        final now = DateTime.now();
        filtered = filtered.where((event) =>
          event.startDate.year == now.year && event.startDate.month == now.month
        ).toList();
        break;
      case 'Free Events':
        filtered = filtered.where((event) => event.price == 0).toList();
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = _filteredEvents;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildFilterTabs()),
          SliverToBoxAdapter(child: _buildResultsHeader(filteredEvents.length)),
          _buildEventsList(filteredEvents),
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
              colors: AppTheme.neonGradient,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Events & Festivals',
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
                      // TODO: Implement calendar view
                    },
                    icon: const Icon(
                      Icons.calendar_month,
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

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: EdgeInsets.only(right: index < _filterOptions.length - 1 ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected 
                    ? const LinearGradient(colors: AppTheme.neonGradient)
                    : null,
                  color: isSelected ? null : Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected 
                    ? null
                    : Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  filter,
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
            '$count events found',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              // TODO: Implement filter options
            },
            icon: const Icon(Icons.filter_list, size: 16),
            label: Text(
              'Filters',
              style: AppTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(List<Event> events) {
    if (events.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No events found',
                style: AppTheme.headingSmall.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your filters or check back later',
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
              padding: EdgeInsets.only(bottom: index < events.length - 1 ? 16 : 0),
              child: EventCard(
                event: events[index],
                onTap: () {
                  // TODO: Navigate to event details
                },
                onBookTicket: () {
                  // TODO: Book ticket functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking ${events[index].title}!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ).animate()
                .slideY(delay: (index * 100).ms, duration: 400.ms)
                .fadeIn(delay: (index * 100).ms, duration: 400.ms),
            );
          },
          childCount: events.length,
        ),
      ),
    );
  }
}