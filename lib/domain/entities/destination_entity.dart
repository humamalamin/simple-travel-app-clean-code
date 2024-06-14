import 'package:equatable/equatable.dart';

class DestinationEntity extends Equatable {
    final String id;
    final String name;
    final String category;
    final String cover;
    final double rate;
    final int rateCount;
    final String location;
    final String description;
    final List<String> images;
    final List<String> facilities;

    const DestinationEntity({
        required this.id,
        required this.name,
        required this.category,
        required this.cover,
        required this.rate,
        required this.rateCount,
        required this.location,
        required this.description,
        required this.images,
        required this.facilities,
    });

    factory DestinationEntity.fromJson(Map<String, dynamic> json) => DestinationEntity(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        cover: json["cover"],
        rate: json["rate"],
        rateCount: json["rate_count"],
        location: json["location"],
        description: json["description"],
        images: json["images"],
        facilities: json["facilities"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover": cover,
        "rate": rate,
        "rate_count": rateCount,
        "location": location,
        "description": description,
        "images": images,
        "facilities": facilities,
    };
    
      @override
      List<Object?> get props => [
        id,
        name,
        category,
        cover,
        rate,
        rateCount,
        location,
        description,
        images,
        facilities,
      ];
}
