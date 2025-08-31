import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final double originalPrice;
  final String currency;
  final int stockQuantity;
  final ProductCategory category;
  final String subcategory;
  final double rating;
  final int reviewCount;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final List<String> tags;
  final Map<String, dynamic> specifications;
  final List<String> colors;
  final List<String> sizes;
  final String origin;
  final String material;
  final bool isHandmade;
  final bool isFeatured;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ShippingInfo shippingInfo;
  final List<ProductVariant>? variants;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.originalPrice,
    required this.currency,
    required this.stockQuantity,
    required this.category,
    required this.subcategory,
    required this.rating,
    required this.reviewCount,
    required this.sellerId,
    required this.sellerName,
    required this.sellerAvatar,
    required this.tags,
    required this.specifications,
    required this.colors,
    required this.sizes,
    required this.origin,
    required this.material,
    required this.isHandmade,
    required this.isFeatured,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingInfo,
    this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  double get discountPercentage => 
    ((originalPrice - price) / originalPrice * 100);

  bool get hasDiscount => originalPrice > price;

  bool get inStock => stockQuantity > 0;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    double? price,
    double? originalPrice,
    String? currency,
    int? stockQuantity,
    ProductCategory? category,
    String? subcategory,
    double? rating,
    int? reviewCount,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    List<String>? tags,
    Map<String, dynamic>? specifications,
    List<String>? colors,
    List<String>? sizes,
    String? origin,
    String? material,
    bool? isHandmade,
    bool? isFeatured,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    ShippingInfo? shippingInfo,
    List<ProductVariant>? variants,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      currency: currency ?? this.currency,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      tags: tags ?? this.tags,
      specifications: specifications ?? this.specifications,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      origin: origin ?? this.origin,
      material: material ?? this.material,
      isHandmade: isHandmade ?? this.isHandmade,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shippingInfo: shippingInfo ?? this.shippingInfo,
      variants: variants ?? this.variants,
    );
  }
}

@JsonSerializable()
class ShippingInfo {
  final bool freeShipping;
  final double shippingCost;
  final int estimatedDays;
  final List<String> availableCountries;

  const ShippingInfo({
    required this.freeShipping,
    required this.shippingCost,
    required this.estimatedDays,
    required this.availableCountries,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => _$ShippingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInfoToJson(this);
}

@JsonSerializable()
class ProductVariant {
  final String id;
  final String name;
  final double price;
  final int stockQuantity;
  final String? color;
  final String? size;
  final List<String> images;

  const ProductVariant({
    required this.id,
    required this.name,
    required this.price,
    required this.stockQuantity,
    this.color,
    this.size,
    required this.images,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => _$ProductVariantFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantToJson(this);
}

enum ProductCategory {
  @JsonValue('handicrafts')
  handicrafts,
  @JsonValue('clothing')
  clothing,
  @JsonValue('jewelry')
  jewelry,
  @JsonValue('food')
  food,
  @JsonValue('art')
  art,
  @JsonValue('home_decor')
  homeDecor,
  @JsonValue('musical_instruments')
  musicalInstruments,
  @JsonValue('textiles')
  textiles,
}

extension ProductCategoryExtension on ProductCategory {
  String get displayName {
    switch (this) {
      case ProductCategory.handicrafts:
        return 'Handicrafts';
      case ProductCategory.clothing:
        return 'Clothing';
      case ProductCategory.jewelry:
        return 'Jewelry';
      case ProductCategory.food:
        return 'Food & Spices';
      case ProductCategory.art:
        return 'Art';
      case ProductCategory.homeDecor:
        return 'Home Decor';
      case ProductCategory.musicalInstruments:
        return 'Musical Instruments';
      case ProductCategory.textiles:
        return 'Textiles';
    }
  }

  String get icon {
    switch (this) {
      case ProductCategory.handicrafts:
        return '🏺';
      case ProductCategory.clothing:
        return '👗';
      case ProductCategory.jewelry:
        return '💍';
      case ProductCategory.food:
        return '🌶️';
      case ProductCategory.art:
        return '🎨';
      case ProductCategory.homeDecor:
        return '🏠';
      case ProductCategory.musicalInstruments:
        return '🎵';
      case ProductCategory.textiles:
        return '🧶';
    }
  }
}