import "restaurant.dart";
class Branch {
  final int branchID;
  final String contactInfo;
  final int restaurantID;
  final double latitude;
  final double longitude;

  Branch({
    required this.branchID,
    required this.contactInfo,
    required this.restaurantID,
    required this.latitude,
    required this.longitude,
  });

  // From JSON map to Branch object
  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchID: json['branch_ID'],
      contactInfo: json['contact_Info'],
      restaurantID: json['restaurant_ID'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // Convert Branch object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'branch_ID': branchID,
      'contact_Info': contactInfo,
      'restaurant_ID': restaurantID,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
Future<Restaurant> getRestaurantDetails(int restaurantID) async {

  return Restaurant(
    restaurantID: restaurantID,
    restaurantName: "Restaurant Name",
    ownerID: "Owner ID",
    logoImg: "logo_url.png",
  );
}

