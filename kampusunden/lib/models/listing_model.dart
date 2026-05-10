import 'package:cloud_firestore/cloud_firestore.dart';

class ListingModel {
  final String id;
  final String title;
  final String price;
  final String imageUrl;
  final String category;
  final String brand;
  final String createdBy;
  final DateTime createdAt;

  ListingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.createdBy,
    required this.createdAt,
  });

  factory ListingModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ListingModel(
      id: documentId,
      title: data['title'] ?? '',
      price: data['price'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      brand: data['brand'] ?? '',
      createdBy: data['createdBy'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'brand': brand,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
