import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:kampusunden/product_detail_screen.dart';
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailScreen(title: title, price: price, imageUrl: imageUrl),
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
              child: Image.network(
                imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
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