import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../models/listing_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Discover", style: AppUtils.headerStyle,),centerTitle: true,
      elevation: 0.0,
      shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: TextField(
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
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildCategoryButton('All', Icons.apps),
                    const SizedBox(width: 5),
                    _buildCategoryButton('Books', Icons.book),
                    const SizedBox(width: 5),
                    _buildCategoryButton('Electronics', Icons.computer),
                    const SizedBox(width: 5),
                    _buildCategoryButton('Furniture', Icons.chair),
                    const SizedBox(width: 5),
                    _buildCategoryButton('Clothes', Icons.man),
                    const SizedBox(width: 5),
                  ],
                ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Filter", style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: 10), 
            
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Sort", style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text("Marketplace", style: AppUtils.headerStyle,),
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
                    final listings = _selectedCategory == 'All'
                        ? allListings
                        : allListings.where((ad) => ad.category == _selectedCategory).toList();

                    if (listings.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("No listings found in this category."),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: listings.map((ad) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ProductCard(
                              title: ad.title, 
                              price: ad.price, 
                              imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : "https://via.placeholder.com/150",
                              sellerId: ad.createdBy,
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String categoryName, IconData icon) {
    bool isSelected = _selectedCategory == categoryName;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedCategory = categoryName;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppUtils.appBlue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 5),
          Text(categoryName, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}