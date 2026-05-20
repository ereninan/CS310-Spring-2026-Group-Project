import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/chat_service.dart';

class MessagePage extends StatefulWidget {
  final String receiverId;
  final String receiverEmail;

  const MessagePage({
    super.key,
    required this.receiverId,
    required this.receiverEmail,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text('👱', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverEmail,
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Active now',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(_auth.currentUser!.uid, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading messages'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Say hi!'));
        }

        return ListView(
          reverse: false, // You might want to reverse this and the list if you add new messages at bottom
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _auth.currentUser!.uid;
    String type = data['type'] ?? 'text';
    String? offerAmount = data['offerAmount'];

    var alignment = isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    var bubbleColor = isCurrentUser ? Colors.blue.shade800 : Colors.grey.shade200;
    var textColor = isCurrentUser ? Colors.white : Colors.black;

    Widget content;

    if (type == 'offer_accepted') {
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green.shade600,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          data['text'],
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
    } else if (type == 'offer') {
      content = Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isCurrentUser ? Colors.blue.shade300 : Colors.grey.shade400, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCurrentUser ? 'You made an offer of $offerAmount ₺' : 'User made an offer of $offerAmount ₺',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (!isCurrentUser) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _chatService.sendMessage(widget.receiverId, 'Offer of $offerAmount ₺ accepted!', type: 'offer_accepted');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Accept', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final TextEditingController offerController = TextEditingController();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Counter Offer'),
                            content: TextField(
                              controller: offerController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter your counter price (₺)',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (offerController.text.isNotEmpty) {
                                    final String price = offerController.text.trim();
                                    Navigator.pop(context); // Close dialog
                                    await _chatService.sendMessage(
                                      widget.receiverId,
                                      'Made a counter offer of $price ₺',
                                      type: 'offer',
                                      offerAmount: price,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                                child: const Text('Send Counter', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text('Counter', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 8),
              Text('Waiting for response...', style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12, fontStyle: FontStyle.italic)),
            ]
          ],
        ),
      );
    } else {
      // Regular text
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          data['text'],
          style: TextStyle(color: textColor, fontSize: 14),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
              child: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: sendMessage,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}