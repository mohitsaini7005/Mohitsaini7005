import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  final String id;
  final String title;
  final String description;
  final String location;
  final String region;
  final List<String> images;
  final double price;
  final double originalPrice;
  final int duration; // in days
  final int maxGuests;
  final double rating;
  final int reviewCount;
  final List<String> highlights;
  final List<String> inclusions;
  final List<String> exclusions;
  final String difficulty;
  final List<String> tags;
  final String hostId;
  final String hostName;
  final String hostAvatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isFeatured;
  final TripCategory category;
  final Map<String, dynamic>? coordinates;

  const Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.region,
    required this.images,
    required this.price,
    required this.originalPrice,
    required this.duration,
    required this.maxGuests,
    required this.rating,
    required this.reviewCount,
    required this.highlights,
    required this.inclusions,
    required this.exclusions,
    required this.difficulty,
    required this.tags,
    required this.hostId,
    required this.hostName,
    required this.hostAvatar,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isFeatured,
    required this.category,
    this.coordinates,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);

  double get discountPercentage => 
    ((originalPrice - price) / originalPrice * 100);

  bool get hasDiscount => originalPrice > price;

  Trip copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? region,
    List<String>? images,
    double? price,
    double? originalPrice,
    int? duration,
    int? maxGuests,
    double? rating,
    int? reviewCount,
    List<String>? highlights,
    List<String>? inclusions,
    List<String>? exclusions,
    String? difficulty,
    List<String>? tags,
    String? hostId,
    String? hostName,
    String? hostAvatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isFeatured,
    TripCategory? category,
    Map<String, dynamic>? coordinates,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      region: region ?? this.region,
      images: images ?? this.images,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      duration: duration ?? this.duration,
      maxGuests: maxGuests ?? this.maxGuests,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      highlights: highlights ?? this.highlights,
      inclusions: inclusions ?? this.inclusions,
      exclusions: exclusions ?? this.exclusions,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      hostId: hostId ?? this.hostId,
      hostName: hostName ?? this.hostName,
      hostAvatar: hostAvatar ?? this.hostAvatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      category: category ?? this.category,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}

enum TripCategory {
  @JsonValue('cultural_tour')
  culturalTour,
  @JsonValue('homestay')
  homestay,
  @JsonValue('adventure')
  adventure,
  @JsonValue('festival')
  festival,
  @JsonValue('trekking')
  trekking,
  @JsonValue('wildlife')
  wildlife,
  @JsonValue('food_tour')
  foodTour,
  @JsonValue('craft_workshop')
  craftWorkshop,
}

extension TripCategoryExtension on TripCategory {
  String get displayName {
    switch (this) {
      case TripCategory.culturalTour:
        return 'Cultural Tour';
      case TripCategory.homestay:
        return 'Homestay';
      case TripCategory.adventure:
        return 'Adventure';
      case TripCategory.festival:
        return 'Festival';
      case TripCategory.trekking:
        return 'Trekking';
      case TripCategory.wildlife:
        return 'Wildlife';
      case TripCategory.foodTour:
        return 'Food Tour';
      case TripCategory.craftWorkshop:
        return 'Craft Workshop';
    }
  }

  String get icon {
    switch (this) {
      case TripCategory.culturalTour:
        return '🏛️';
      case TripCategory.homestay:
        return '🏠';
      case TripCategory.adventure:
        return '🏔️';
      case TripCategory.festival:
        return '🎭';
      case TripCategory.trekking:
        return '🥾';
      case TripCategory.wildlife:
        return '🦌';
      case TripCategory.foodTour:
        return '🍽️';
      case TripCategory.craftWorkshop:
        return '🎨';
    }
  }
}