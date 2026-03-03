enum EventType { inPerson, virtual, hybrid }

class EventModel {
  final String id;
  final String title;
  final String description;
  final String bannerUrl;
  final String category;
  final DateTime dateTime;
  final String location;
  final double price;
  final double rating;
  final EventType type;
  final String organizerId;
  final bool isTrending;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerUrl,
    required this.category,
    required this.dateTime,
    required this.location,
    required this.price,
    required this.rating,
    required this.type,
    required this.organizerId,
    this.isTrending = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'bannerUrl': bannerUrl,
      'category': category,
      'dateTime': dateTime.toIso8601String(),
      'location': location,
      'price': price,
      'rating': rating,
      'type': type.index,
      'organizerId': organizerId,
      'isTrending': isTrending,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      bannerUrl: json['bannerUrl'] ?? '',
      category: json['category'] ?? '',
      dateTime: DateTime.parse(json['dateTime'] ?? DateTime.now().toIso8601String()),
      location: json['location'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      type: EventType.values[json['type'] ?? 0],
      organizerId: json['organizerId'] ?? '',
      isTrending: json['isTrending'] ?? false,
    );
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? bannerUrl,
    String? category,
    DateTime? dateTime,
    String? location,
    double? price,
    double? rating,
    EventType? type,
    String? organizerId,
    bool? isTrending,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      organizerId: organizerId ?? this.organizerId,
      isTrending: isTrending ?? this.isTrending,
    );
  }
}

