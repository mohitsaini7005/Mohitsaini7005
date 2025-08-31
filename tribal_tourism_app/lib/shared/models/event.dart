import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String id;
  final String title;
  final String description;
  final String location;
  final String venue;
  final List<String> images;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final double originalPrice;
  final String currency;
  final int availableTickets;
  final int totalTickets;
  final EventCategory category;
  final EventType type;
  final double rating;
  final int reviewCount;
  final String organizerId;
  final String organizerName;
  final String organizerAvatar;
  final List<String> tags;
  final List<String> highlights;
  final String ageRestriction;
  final bool isRefundable;
  final bool isFeatured;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TicketInfo ticketInfo;
  final Map<String, dynamic>? coordinates;
  final List<EventSchedule> schedule;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.venue,
    required this.images,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.originalPrice,
    required this.currency,
    required this.availableTickets,
    required this.totalTickets,
    required this.category,
    required this.type,
    required this.rating,
    required this.reviewCount,
    required this.organizerId,
    required this.organizerName,
    required this.organizerAvatar,
    required this.tags,
    required this.highlights,
    required this.ageRestriction,
    required this.isRefundable,
    required this.isFeatured,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.ticketInfo,
    this.coordinates,
    required this.schedule,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  double get discountPercentage => 
    ((originalPrice - price) / originalPrice * 100);

  bool get hasDiscount => originalPrice > price;

  bool get hasTicketsAvailable => availableTickets > 0;

  bool get isUpcoming => startDate.isAfter(DateTime.now());

  bool get isOngoing => DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);

  bool get isPast => endDate.isBefore(DateTime.now());

  String get status {
    if (isPast) return 'Past';
    if (isOngoing) return 'Ongoing';
    if (isUpcoming) return 'Upcoming';
    return 'Unknown';
  }

  int get durationInDays => endDate.difference(startDate).inDays + 1;

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? venue,
    List<String>? images,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    double? originalPrice,
    String? currency,
    int? availableTickets,
    int? totalTickets,
    EventCategory? category,
    EventType? type,
    double? rating,
    int? reviewCount,
    String? organizerId,
    String? organizerName,
    String? organizerAvatar,
    List<String>? tags,
    List<String>? highlights,
    String? ageRestriction,
    bool? isRefundable,
    bool? isFeatured,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    TicketInfo? ticketInfo,
    Map<String, dynamic>? coordinates,
    List<EventSchedule>? schedule,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      venue: venue ?? this.venue,
      images: images ?? this.images,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      currency: currency ?? this.currency,
      availableTickets: availableTickets ?? this.availableTickets,
      totalTickets: totalTickets ?? this.totalTickets,
      category: category ?? this.category,
      type: type ?? this.type,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      organizerId: organizerId ?? this.organizerId,
      organizerName: organizerName ?? this.organizerName,
      organizerAvatar: organizerAvatar ?? this.organizerAvatar,
      tags: tags ?? this.tags,
      highlights: highlights ?? this.highlights,
      ageRestriction: ageRestriction ?? this.ageRestriction,
      isRefundable: isRefundable ?? this.isRefundable,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ticketInfo: ticketInfo ?? this.ticketInfo,
      coordinates: coordinates ?? this.coordinates,
      schedule: schedule ?? this.schedule,
    );
  }
}

@JsonSerializable()
class TicketInfo {
  final String ticketType;
  final bool isDigital;
  final bool requiresID;
  final String cancellationPolicy;
  final DateTime lastBookingDate;

  const TicketInfo({
    required this.ticketType,
    required this.isDigital,
    required this.requiresID,
    required this.cancellationPolicy,
    required this.lastBookingDate,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) => _$TicketInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TicketInfoToJson(this);
}

@JsonSerializable()
class EventSchedule {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final List<String> performers;

  const EventSchedule({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    this.location,
    required this.performers,
  });

  factory EventSchedule.fromJson(Map<String, dynamic> json) => _$EventScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$EventScheduleToJson(this);
}

enum EventCategory {
  @JsonValue('festival')
  festival,
  @JsonValue('concert')
  concert,
  @JsonValue('workshop')
  workshop,
  @JsonValue('cultural_show')
  culturalShow,
  @JsonValue('exhibition')
  exhibition,
  @JsonValue('fair')
  fair,
  @JsonValue('ceremony')
  ceremony,
  @JsonValue('competition')
  competition,
}

enum EventType {
  @JsonValue('indoor')
  indoor,
  @JsonValue('outdoor')
  outdoor,
  @JsonValue('virtual')
  virtual,
  @JsonValue('hybrid')
  hybrid,
}

extension EventCategoryExtension on EventCategory {
  String get displayName {
    switch (this) {
      case EventCategory.festival:
        return 'Festival';
      case EventCategory.concert:
        return 'Concert';
      case EventCategory.workshop:
        return 'Workshop';
      case EventCategory.culturalShow:
        return 'Cultural Show';
      case EventCategory.exhibition:
        return 'Exhibition';
      case EventCategory.fair:
        return 'Fair';
      case EventCategory.ceremony:
        return 'Ceremony';
      case EventCategory.competition:
        return 'Competition';
    }
  }

  String get icon {
    switch (this) {
      case EventCategory.festival:
        return '🎭';
      case EventCategory.concert:
        return '🎵';
      case EventCategory.workshop:
        return '🎨';
      case EventCategory.culturalShow:
        return '🎪';
      case EventCategory.exhibition:
        return '🖼️';
      case EventCategory.fair:
        return '🎠';
      case EventCategory.ceremony:
        return '🙏';
      case EventCategory.competition:
        return '🏆';
    }
  }
}

extension EventTypeExtension on EventType {
  String get displayName {
    switch (this) {
      case EventType.indoor:
        return 'Indoor';
      case EventType.outdoor:
        return 'Outdoor';
      case EventType.virtual:
        return 'Virtual';
      case EventType.hybrid:
        return 'Hybrid';
    }
  }
}