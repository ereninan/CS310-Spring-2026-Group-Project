import 'package:flutter/material.dart';


class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arda *****',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Active 11m ago',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16, bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'This is the main chat template',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            const Center(
              child: Text(
                'Waiting for approve ...',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const Center(
              child: Text(
                'Approved by user ...',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Oh?'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Cool'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                const Text('👱', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('How does it work?'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16, bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'You just edit any text to type in the conversation you want to show, and delete any bubbles you don\'t want to use',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16, bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Boom!',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Hmmm'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('I think I get it'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8),
                const Text('👱', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Will head to the Help Center if I have more questions tho'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                suffixIcon: SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.sentiment_satisfied_alt, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Icon(Icons.image_outlined, color: Colors.grey),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
     
    );
  }
}