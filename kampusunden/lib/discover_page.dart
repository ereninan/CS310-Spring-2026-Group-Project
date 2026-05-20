import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';
import '../models/listing_model.dart';

class DiscoverPage extends StatefulWidget {
  final String initialCategory;
  final String initialSearchQuery;

  const DiscoverPage({
    super.key,
    this.initialCategory = 'All',
    this.initialSearchQuery = '',
  });

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late String _selectedCategory;
  late TextEditingController _searchController;
  String _searchQuery = '';
  
  String _selectedSort = 'Newest';
  double? _minPrice;
  double? _maxPrice;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _searchQuery = widget.initialSearchQuery;
    _searchController = TextEditingController(text: _searchQuery);
  }

  @override
  void didUpdateWidget(DiscoverPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCategory != oldWidget.initialCategory || widget.initialSearchQuery != oldWidget.initialSearchQuery) {
      setState(() {
        _selectedCategory = widget.initialCategory;
        _searchQuery = widget.initialSearchQuery;
        _searchController.text = _searchQuery;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
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
                    _buildCategoryButton('Wanted', Icons.pan_tool),
                    const SizedBox(width: 5),
                  ],
                ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _showFilterOptions,
                      child: Row(
                        children: [
                          Text("Filter", style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: 10), 
            
                    ElevatedButton(
                      onPressed: _showSortOptions,
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
                    
                    List<ListingModel> listings;
                    if (_selectedCategory == 'Wanted') {
                      listings = allListings.where((ad) => ad.isWanted).toList();
                    } else if (_selectedCategory == 'All') {
                      listings = allListings.where((ad) => !ad.isWanted).toList();
                    } else {
                      listings = allListings.where((ad) => !ad.isWanted && ad.category == _selectedCategory).toList();
                    }
                    
                    if (_searchQuery.trim().isNotEmpty) {
                      final query = _searchQuery.trim().toLowerCase();
                      listings = listings.where((ad) => ad.title.toLowerCase().contains(query) || ad.brand.toLowerCase().contains(query)).toList();
                    }

                    if (_minPrice != null) {
                      listings = listings.where((ad) {
                        final p = double.tryParse(ad.price);
                        return p != null && p >= _minPrice!;
                      }).toList();
                    }
                    if (_maxPrice != null) {
                      listings = listings.where((ad) {
                        final p = double.tryParse(ad.price);
                        return p != null && p <= _maxPrice!;
                      }).toList();
                    }

                    if (_selectedSort == 'Newest') {
                      listings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                    } else if (_selectedSort == 'Oldest') {
                      listings.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                    } else if (_selectedSort == 'Price_Asc') {
                      listings.sort((a, b) {
                        final pa = double.tryParse(a.price) ?? 0;
                        final pb = double.tryParse(b.price) ?? 0;
                        return pa.compareTo(pb);
                      });
                    } else if (_selectedSort == 'Price_Desc') {
                      listings.sort((a, b) {
                        final pa = double.tryParse(a.price) ?? 0;
                        final pb = double.tryParse(b.price) ?? 0;
                        return pb.compareTo(pa);
                      });
                    }

                    if (listings.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("No listings found in this category."),
                      );
                    }

                    List<Widget> rows = [];
                    for (int i = 0; i < listings.length; i += 5) {
                      int end = i + 5;
                      if (end > listings.length) end = listings.length;
                      List<ListingModel> chunk = listings.sublist(i, end);

                      rows.add(
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: chunk.map((ad) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ProductCard(
                                    title: ad.title, 
                                    brand: ad.brand,
                                    price: ad.price, 
                                    imageUrl: ad.imageUrl.isNotEmpty ? ad.imageUrl : "https://via.placeholder.com/150",
                                    sellerId: ad.createdBy,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: rows,
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

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sort By', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                title: const Text('Newest First'),
                trailing: _selectedSort == 'Newest' ? const Icon(Icons.check, color: AppUtils.appBlue) : null,
                onTap: () {
                  setState(() => _selectedSort = 'Newest');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Oldest First'),
                trailing: _selectedSort == 'Oldest' ? const Icon(Icons.check, color: AppUtils.appBlue) : null,
                onTap: () {
                  setState(() => _selectedSort = 'Oldest');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Price: Low to High'),
                trailing: _selectedSort == 'Price_Asc' ? const Icon(Icons.check, color: AppUtils.appBlue) : null,
                onTap: () {
                  setState(() => _selectedSort = 'Price_Asc');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Price: High to Low'),
                trailing: _selectedSort == 'Price_Desc' ? const Icon(Icons.check, color: AppUtils.appBlue) : null,
                onTap: () {
                  setState(() => _selectedSort = 'Price_Desc');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    );
  }

  void _showFilterOptions() {
    final TextEditingController minController = TextEditingController(text: _minPrice?.toString() ?? '');
    final TextEditingController maxController = TextEditingController(text: _maxPrice?.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16, right: 16, top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Filter by Price', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: minController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Min Price', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: maxController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Max Price', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _minPrice = null;
                        _maxPrice = null;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _minPrice = double.tryParse(minController.text);
                        _maxPrice = double.tryParse(maxController.text);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }
    );
  }
}