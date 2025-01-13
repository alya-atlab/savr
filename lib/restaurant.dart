class Restaurant {
  final int restaurantID;
  final String restaurantName;
  final String ownerID;
  final String logoImg;

  Restaurant({
    required this.restaurantID,
    required this.restaurantName,
    required this.ownerID,
    required this.logoImg,
  });

  // From JSON map to Restaurant object
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantID: json['restaurantID'],
      restaurantName: json['restaurant_name'],
      ownerID: json['ownerID'],
      logoImg: json['logo_img'],
    );
  }

  // Convert Restaurant object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'restaurantID': restaurantID,
      'restaurant_name': restaurantName,
      'ownerID': ownerID,
      'logo_img': logoImg,
    };
  }
}
