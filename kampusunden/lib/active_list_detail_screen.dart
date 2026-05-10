import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../providers/auth_provider.dart';

class acticeListDetail extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  final int index;
  final String id; 
  final String createdBy;

  const acticeListDetail({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.index,
    this.id = '',
    this.createdBy = '',
  });

  @override
  State<acticeListDetail> createState() => _acticeListDetailState();
}

class _acticeListDetailState extends State<acticeListDetail> {
  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<AuthProvider>(context, listen: false).user?.uid;
    final isOwner = currentUserId != null && currentUserId == widget.createdBy;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          if (isOwner && widget.id.isNotEmpty)
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ListingProvider>(context, listen: false).deleteListing(widget.id);
                  if (!mounted) return;
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete: $e')));
                }
              }, 
              icon: const Icon(Icons.delete)
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: (widget.imageUrl.isEmpty || widget.imageUrl == 'https://via.placeholder.com/150')
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
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 250,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
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
      bottomNavigationBar: _buildBottomMessageBar(),
    );
  }

  Widget _buildBottomMessageBar() {
    return Padding(
      padding: EdgeInsets.all(AppUtils.pad),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {

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
}