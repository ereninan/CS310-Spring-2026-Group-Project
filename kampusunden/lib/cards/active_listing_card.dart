import 'package:flutter/material.dart';
import 'package:kampusunden/active_list_detail_screen.dart';
import 'package:kampusunden/product_detail_screen.dart';
import 'package:kampusunden/utils.dart';
class activeListingCard extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final String imageUrl;
  final int index;
  const activeListingCard({super.key,
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.index});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => acticeListDetail(title: title, brand: brand, price: price, imageUrl: imageUrl, index: index),
          ),
        );
      },
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // SOL TARAF: Ürün Görseli
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: (imageUrl.isEmpty || imageUrl == 'https://via.placeholder.com/150')
                    ? const Center(child: Icon(Icons.image_not_supported, color: Colors.grey))
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                      ),
              ),
            ),
            const SizedBox(width: 10),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    brand,
                    style: AppUtils.product_card_title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$price \$",
                    style: AppUtils.product_card_price
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
