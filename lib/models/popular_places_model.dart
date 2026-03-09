class PopularPlacesModel {
  int? id;
  String? name;
  String? city;
  String? country;
  double? lat;
  double? lng;
  double? rating;
  String? description;
  String? image;
  Gallery? gallery;

  PopularPlacesModel({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.description,
    required this.image,
    required this.gallery,
  });

  factory PopularPlacesModel.fromJson(Map<String, dynamic> json) {
    return PopularPlacesModel(
      id: json["id"],
      name: json["name"],
      city: json["city"],
      country: json["country"],
      lat: json["lat"],
      lng: json["lng"],
      rating: json["rating"],
      description: json["description"],
      image: json["image"],
      gallery: json["gallery"] != null
          ? Gallery.fromJson(json["gallery"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "country": country,
      "lat": lat,
      "lng": lng,
      "rating": rating,
      "description": description,
      "image": image,
      "gallery": gallery?.toJson(),
    };
  }
}

class Gallery {
  final String? img1;
  final String? img2;
  final String? img3;

  Gallery({this.img1, this.img2, this.img3});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(img1: json['img1'], img2: json['img2'], img3: json['img3']);
  }

  Map<String, dynamic> toJson() {
    return {'img1': img1, 'img2': img2, 'img3': img3};
  }
}
