import 'package:flutter/material.dart';

class BagCard extends StatelessWidget {
  final String? bagName;
  final String? bagImage;
  final String? restaurantName;
  final String? restaurantLogo;
  final double? distance;
  final double? oldPrice;
  final double? discountedPrice;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const BagCard({
    Key? key,
    required this.bagName,
    required this.bagImage,
    required this.restaurantName,
    required this.restaurantLogo,
    required this.distance,
    required this.oldPrice,
    required this.discountedPrice,
    required this.isFavorite,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  image: bagImage != null
                      ? DecorationImage(
                          image: NetworkImage(bagImage!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage(
                              'assets/images/default_placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavoritePressed,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: CircleAvatar(
                  backgroundImage: restaurantLogo != null
                      ? NetworkImage(restaurantLogo!)
                      : const AssetImage(
                              'assets/images/default_placeholder.jpg')
                          as ImageProvider,
                  radius: 20,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName ?? "Unknown Restaurant",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bagName ?? "Unknown Bag",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (distance != null)
                    Text(
                      "${distance!.toStringAsFixed(1)} km away",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const Spacer(),
                  Row(
                    children: [
                      if (oldPrice != null)
                        Text(
                          "\$${oldPrice!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (discountedPrice != null)
                        Text(
                          "\$${discountedPrice!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
