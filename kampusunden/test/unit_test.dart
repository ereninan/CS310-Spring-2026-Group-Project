import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kampusunden/models/listing_model.dart';
import 'package:kampusunden/models/message_model.dart';

void main() {
  group('ListingModel Tests', () {
    test('ListingModel.fromMap should correctly deserialize data', () {
      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);

      final Map<String, dynamic> data = {
        'title': 'Test Item',
        'price': '150',
        'imageUrl': 'https://example.com/image.png',
        'category': 'Electronics',
        'brand': 'Sony',
        'createdBy': 'user123',
        'createdAt': timestamp,
        'isWanted': false,
      };

      final listing = ListingModel.fromMap(data, 'docId123');

      expect(listing.id, 'docId123');
      expect(listing.title, 'Test Item');
      expect(listing.price, '150');
      expect(listing.imageUrl, 'https://example.com/image.png');
      expect(listing.category, 'Electronics');
      expect(listing.brand, 'Sony');
      expect(listing.createdBy, 'user123');
      expect(listing.createdAt.year, now.year);
      expect(listing.isWanted, false);
    });

    test('ListingModel.toMap should correctly serialize data', () {
      final now = DateTime.now();
      final listing = ListingModel(
        id: 'docId123',
        title: 'Another Item',
        price: '200',
        imageUrl: 'https://example.com/another.png',
        category: 'Books',
        brand: 'Pearson',
        createdBy: 'user456',
        createdAt: now,
        isWanted: true,
      );

      final map = listing.toMap();

      expect(map['title'], 'Another Item');
      expect(map['price'], '200');
      expect(map['imageUrl'], 'https://example.com/another.png');
      expect(map['category'], 'Books');
      expect(map['brand'], 'Pearson');
      expect(map['createdBy'], 'user456');
      expect(map['isWanted'], true);
      expect(map['createdAt'], isA<Timestamp>());
    });
  });

  group('MessageModel Tests', () {
    test('MessageModel.fromMap and toMap should serialize and deserialize correctly', () {
      final now = Timestamp.now();
      final Map<String, dynamic> map = {
        'senderId': 'sender123',
        'receiverId': 'receiver456',
        'text': 'I want to offer 120 ₺',
        'timestamp': now,
        'type': 'offer',
        'offerAmount': '120',
      };

      final message = MessageModel.fromMap(map);

      expect(message.senderId, 'sender123');
      expect(message.receiverId, 'receiver456');
      expect(message.text, 'I want to offer 120 ₺');
      expect(message.timestamp, now);
      expect(message.type, 'offer');
      expect(message.offerAmount, '120');

      final serialized = message.toMap();
      expect(serialized['senderId'], 'sender123');
      expect(serialized['receiverId'], 'receiver456');
      expect(serialized['text'], 'I want to offer 120 ₺');
      expect(serialized['timestamp'], now);
      expect(serialized['type'], 'offer');
      expect(serialized['offerAmount'], '120');
    });
  });
}
