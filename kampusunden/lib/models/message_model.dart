import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final Timestamp timestamp;
  final String type; // 'text', 'offer', 'offer_accepted'
  final String? offerAmount;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
    this.type = 'text',
    this.offerAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
      'type': type,
      'offerAmount': offerAmount,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] as Timestamp,
      type: map['type'] ?? 'text',
      offerAmount: map['offerAmount'],
    );
  }
}
