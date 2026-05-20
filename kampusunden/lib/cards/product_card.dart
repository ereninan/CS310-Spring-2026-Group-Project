import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:kampusunden/product_detail_screen.dart';
class ProductCard extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final String imageUrl;
  final String sellerId;

  const ProductCard({
    super.key,
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.sellerId = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(title: title, brand: brand, price: price, imageUrl: imageUrl, sellerId: sellerId),
        ),
      );},
      child: Container(
        width: 150,
        color: const Color.fromARGB(19, 186, 186, 186),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: (imageUrl.isEmpty || imageUrl == "https://via.placeholder.com/150")
                    ? Container(
                        width: 150,
                        height: 150,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      )
                    : Image.network(
                        imageUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                brand,
                style: AppUtils.product_card_title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text("Price: $price"
              ,style: AppUtils.product_card_price,),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}