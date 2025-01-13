class Bag {
  final int bagBranchId;
  final int bagId;
  final String bagName;
  final String bagImage;
  final String branchName;
  final String restaurantName;
  final String restaurantLogo;
  final double originalPrice;
  final double discountedPrice;
  final double bagRating;
  final double distance;

  Bag({
    required this.bagBranchId,
    required this.bagId,
    required this.bagName,
    required this.bagImage,
    required this.branchName,
    required this.restaurantName,
    required this.restaurantLogo,
    required this.originalPrice,
    required this.discountedPrice,
    required this.bagRating,
    required this.distance,
  });

  factory Bag.fromJson(Map<String, dynamic> json) {
    return Bag(
      bagBranchId: json['bag_branch_id'],
      bagId: json['bag_id'],
      bagName: json['bag_name'],
      bagImage:
          json['bag_image'] ?? 'http://192.168.0.107/savr/imgs/default.jpg',
      branchName: json['branch_name'],
      restaurantName: json['restaurant_name'],
      restaurantLogo: json['restaurant_logo'] ??
          'http://192.168.0.107/savr/imgs/default_logo.jpg',
      originalPrice: double.parse(json['original_price']),
      discountedPrice: double.parse(json['discounted_price']),
      bagRating: double.parse(json['bag_rating']),
      distance: double.parse(json['distance']),
    );
  }
}
