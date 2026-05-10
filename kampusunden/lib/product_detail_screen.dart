import 'package:flutter/material.dart';
import '../../utils.dart';
import 'message_page.dart';

class ProductDetailScreen extends StatefulWidget {
  // Dışarıdan gelecek değişkenler
  final String title;
  final String price;
  final String imageUrl;
  final String sellerId;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.sellerId = '',
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: (widget.imageUrl.isEmpty || widget.imageUrl == "https://via.placeholder.com/150")
                  ? Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                    )
                  : Image.network(
                      widget.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('${widget.price} USD', style: AppUtils.product_card_title),
                  const SizedBox(height: 12),
                  Text(
                    'This is a detailed description for ${widget.title}. The quality and performance are top-notch for campus life!',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomMessageBar(context, widget.sellerId),
    );
  }
}
Widget _buildBottomMessageBar(BuildContext context, String sellerId) { 
  return Padding(
    padding: EdgeInsets.all(AppUtils.pad),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (sellerId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagePage(receiverId: sellerId, receiverEmail: 'Seller')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cannot contact seller for this item.')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppUtils.appBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Message', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    ),
  );
}