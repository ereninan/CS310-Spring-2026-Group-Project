import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of messages for a specific chat room
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Send a message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      receiverId: receiverId,
      text: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // Add message to chat room
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    // Update or create chat room metadata
    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'users': ids,
      'lastMessage': message,
      'lastMessageTime': timestamp,
    }, SetOptions(merge: true));
  }

  // Stream of chat rooms for current user
  Stream<QuerySnapshot> getUserChats() {
    final String currentUserId = _auth.currentUser!.uid;
    return _firestore
        .collection('chat_rooms')
        .where('users', arrayContains: currentUserId)
        .snapshots();
  }
}
