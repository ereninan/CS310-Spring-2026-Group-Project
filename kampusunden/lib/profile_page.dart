import 'package:flutter/material.dart';
import 'package:kampusunden/cards/active_listing_card.dart';
import 'package:kampusunden/data/my_listings.dart';
class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.blueAccent, width: 3),
                ),
                child: const Center(
                  child: Text(
                    '🧑‍🎓',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Baran Rıfat',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                'Computer Science | Senior | SU',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'My Active Listings:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: dummyAds.length,
                itemBuilder: (context, index) {

                  final ad = dummyAds[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: activeListingCard(
                      title: ad['title'] ?? 'No Title',
                      price: ad['price'] ?? '0',
                      imageUrl: ad['imageUrl'] ?? '',
                      index: index,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'My Active Requests:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('📚', style: TextStyle(fontSize: 35)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('👕', style: TextStyle(fontSize: 35)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text('📦', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Text(
                        'Order History',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text('🏛️', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Text(
                        'Campus',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text('🔔', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Text(
                        'Notifications',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Text('⚙️', style: TextStyle(fontSize: 20)),
                      SizedBox(width: 12),
                      Text(
                        'Settings',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    
  }
}