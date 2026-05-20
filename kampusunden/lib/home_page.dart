import 'package:flutter/material.dart';
import 'package:kampusunden/chats_page.dart';
import 'package:kampusunden/create_listing_page.dart';
import 'package:kampusunden/discover_page.dart';
import 'package:kampusunden/product_detail_screen.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:kampusunden/profile_page.dart';
import 'package:kampusunden/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/listing_provider.dart';
import 'providers/auth_provider.dart';
import 'models/listing_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }
  
  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }
  
  Future<void> _saveSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedIndex', index);
  }

  String _discoverCategory = 'All';
  String _discoverSearchQuery = '';

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeContent(
          onSearch: (query) {
            setState(() {
              _discoverSearchQuery = query;
              _discoverCategory = 'All';
              _selectedIndex = 1;
            });
            _saveSelectedIndex(1);
          },
          onCategorySelect: (category) {
            setState(() {
              _discoverCategory = category;
              _discoverSearchQuery = '';
              _selectedIndex = 1;
            });
            _saveSelectedIndex(1);
          },
        );
      case 1:
        return DiscoverPage(
          initialCategory: _discoverCategory,
          initialSearchQuery: _discoverSearchQuery,
        );
      case 2:
        return const CreateListingApp();
      case 3:
        return const ChatsApp();
      case 4:
        return const ProfileApp();
      default:
        return HomeContent(onSearch: (_) {}, onCategorySelect: (_) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppUtils.appBlue,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          _saveSelectedIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final Function(String) onSearch;
  final Function(String) onCategorySelect;

  const HomeContent({
    super.key,
    required this.onSearch,
    required this.onCategorySelect,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userEmail = authProvider.user?.email ?? 'User';
    String userName = userEmail;
    if (userEmail.contains('@')) {
      userName = userEmail.split('@').first;
      if (userName.isNotEmpty) {
        userName = userName[0].toUpperCase() + userName.substring(1);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Hi, $userName 👋", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
      elevation: 0,
      shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            RichText(
              text: TextSpan(

                style: AppUtils.title_Style,
                children: [
                  const TextSpan(text: "What are you looking for in the "),
                  TextSpan(
                    text: "CAMPUS ?",
                    style: const TextStyle(
                      color: AppUtils.appBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            controller: _searchController,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                widget.onSearch(value.trim());
              }
            },
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),

              filled: true,
              fillColor: const Color.fromARGB(255, 248, 245, 245),

              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
            SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => widget.onCategorySelect('Books'), child: Row(
                    children: [
                      Icon(Icons.book, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Books", style: AppUtils.smallButtons)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: () => widget.onCategorySelect('Electronics'), child: Row(
                    children: [
                      Icon(Icons.computer, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Electronics", style: AppUtils.smallButtons,)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: () => widget.onCategorySelect('Furniture'), child: Row(
                    children: [
                      Icon(Icons.chair, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Furniture", style: AppUtils.smallButtons,)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: () => widget.onCategorySelect('Clothes'), child: Row(
                    children: [
                      Icon(Icons.man, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Clothes", style: AppUtils.smallButtons,)
                    ],
                  )),
                  SizedBox(width: 5,),
                ],
              ),
            ),
            Text("Latest Requests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            StreamBuilder<List<ListingModel>>(
              stream: Provider.of<ListingProvider>(context).listingsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("No listings available."),
                  );
                }
                
                final allListings = snapshot.data!;
                
                final wantedListings = allListings.where((ad) => ad.isWanted).toList();
                wantedListings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                
                final saleListings = allListings.where((ad) => !ad.isWanted).toList();
                saleListings.sort((a, b) => b.createdAt.compareTo(a.createdAt));

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (wantedListings.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No requests right now."),
                      )
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: wantedListings.map((ad) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ProductCard(
                              title: ad.title,
                              brand: ad.brand,
                              price: ad.price,
                              imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : "https://via.placeholder.com/150",
                              sellerId: ad.createdBy,
                            ),
                          )).toList(),
                        ),
                      ),
                      
                    const SizedBox(height: 20,),
                    const Text("Latest For Sale", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    
                    if (saleListings.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("No items for sale right now."),
                      )
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: saleListings.map((ad) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ProductCard(
                              title: ad.title,
                              brand: ad.brand,
                              price: ad.price,
                              imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : "https://via.placeholder.com/150",
                              sellerId: ad.createdBy,
                            ),
                          )).toList(),
                        ),
                      ),
                  ],
                );
              }
            ),

          ],
          ),
        ),
      ),
    );
  }
}