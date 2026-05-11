import 'package:flutter/material.dart';
import 'package:kampusunden/cards/active_listing_card.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../providers/auth_provider.dart';
import '../models/listing_model.dart';
import '../active_list_detail_screen.dart';

class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

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
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: () async {
                await authProvider.signOut();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
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
                child: Center(
                  child: Image.asset(
                    'lib/data/images/profileImg.png', 
                    width: 80,                
                    height: 80,                
                    fit: BoxFit.contain,       
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                user?.email?.split('@').first ?? 'User',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              child: user == null ? const Center(child: Text("Please sign in")) : StreamBuilder<List<ListingModel>>(
                stream: Provider.of<ListingProvider>(context).userListingsStream(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("No active listings."),
                    );
                  }
                  final listings = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: listings.length,
                    itemBuilder: (context, index) {
                      final ad = listings[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => acticeListDetail(
                                  title: ad.title,
                                  price: ad.price,
                                  imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : 'https://via.placeholder.com/150',
                                  index: index,
                                  id: ad.id,
                                  createdBy: ad.createdBy,
                                ),
                              ),
                            );
                          },
                          child: IgnorePointer(
                            child: activeListingCard(
                              title: ad.title,
                              price: ad.price,
                              imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : 'https://via.placeholder.com/150',
                              index: index,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
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