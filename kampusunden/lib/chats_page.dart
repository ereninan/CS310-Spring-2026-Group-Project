import 'package:flutter/material.dart';
import 'package:kampusunden/message_page.dart';
import 'package:kampusunden/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/chat_service.dart';

class ChatsApp extends StatefulWidget {
  const ChatsApp({super.key});

  @override
  State<ChatsApp> createState() => _ChatsAppState();
}

class _ChatsAppState extends State<ChatsApp> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          _buildTabs(),
          const SizedBox(height: 24),
          Expanded(
            child: _buildChatList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppUtils.appBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Messages',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Offers',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Requests',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getUserChats(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Chat List Error: ${snapshot.error}");
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No active chats yet.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildChatListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildChatListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    
    // Find the other user's ID
    List<dynamic> users = data['users'];
    String currentUserId = _auth.currentUser!.uid;
    String otherUserId = users.firstWhere((id) => id != currentUserId, orElse: () => '');

    if (otherUserId.isEmpty) return const SizedBox();

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
      builder: (context, userSnapshot) {
        String displayName = "User";
        if (userSnapshot.hasData && userSnapshot.data!.exists) {
          Map<String, dynamic> userData = userSnapshot.data!.data() as Map<String, dynamic>;
          displayName = userData['email'] ?? 'User';
        }

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagePage(
                  receiverId: otherUserId,
                  receiverEmail: displayName,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text('👱', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['lastMessage'] ?? 'Send a message',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}