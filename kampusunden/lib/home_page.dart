import 'package:flutter/material.dart';
import 'package:kampusunden/chats_page.dart';
import 'package:kampusunden/create_listing_page.dart';
import 'package:kampusunden/discover_page.dart';
import 'package:kampusunden/product_detail_screen.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:kampusunden/profile_page.dart';
import 'package:kampusunden/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final List<Widget> _pages = [
    const HomeContent(),
    const DiscoverPage(),
    const CreateListingApp(),
    const ChatsApp(),
    const ProfileApp(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hi, Baran 👋", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
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
                  ElevatedButton(onPressed: (){}, child: Row(
                    children: [
                      Icon(Icons.book, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Books", style: AppUtils.smallButtons)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: (){}, child: Row(
                    children: [
                      Icon(Icons.computer, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("electronics", style: AppUtils.smallButtons,)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: (){}, child: Row(
                    children: [
                      Icon(Icons.chair, color: Colors.black,),
                      SizedBox(width: 5,),
                      Text("Furnitures", style: AppUtils.smallButtons,)
                    ],
                  )),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: (){}, child: Row(
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
            Text("Discovery", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductCard(title: "Macbook M3", price: "621", imageUrl: "https://static.ticimax.cloud/cdn-cgi/image/width=574,quality=85/54992/uploads/urunresimleri/buyuk/macbook-pro-13-8-core-cpu-8-core-gpu-a-b45b-4.jpeg"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Ipad Air", price: "251", imageUrl: "https://www.pt.com.tr/wp-content/uploads/2024/06/M1eCfV58teDUe1tkUWBxBZjOPq5bi3UeKiDhjG39-2048x2048.webp"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Airpods Pro", price: "321", imageUrl: "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-4-select-202409_FV1?wid=976&hei=916&fmt=jpeg&qlt=90&.v=WnVKRVRUTFVsYThXaWkydWViL1Q3ZDZGTE9TV3RDcGJJclBqdUtzdTJYYjNHc3NlSmU2dzJyR1kxZEwyTE1neUJkRlpCNVhYU3AwTldRQldlSnpRa0NZZXAxWFNjRXhITDI1RVE5YVpyU0E"),
                  ],
                ),
              ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ProductCard(title: "Macbook M3", price: "621", imageUrl: "https://static.ticimax.cloud/cdn-cgi/image/width=574,quality=85/54992/uploads/urunresimleri/buyuk/macbook-pro-13-8-core-cpu-8-core-gpu-a-b45b-4.jpeg"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Ipad Air", price: "251", imageUrl: "https://www.pt.com.tr/wp-content/uploads/2024/06/M1eCfV58teDUe1tkUWBxBZjOPq5bi3UeKiDhjG39-2048x2048.webp"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Airpods Pro", price: "321", imageUrl: "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-4-select-202409_FV1?wid=976&hei=916&fmt=jpeg&qlt=90&.v=WnVKRVRUTFVsYThXaWkydWViL1Q3ZDZGTE9TV3RDcGJJclBqdUtzdTJYYjNHc3NlSmU2dzJyR1kxZEwyTE1neUJkRlpCNVhYU3AwTldRQldlSnpRa0NZZXAxWFNjRXhITDI1RVE5YVpyU0E"),
                  ],
                  ),
                ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ProductCard(title: "Macbook M3", price: "621", imageUrl: "https://static.ticimax.cloud/cdn-cgi/image/width=574,quality=85/54992/uploads/urunresimleri/buyuk/macbook-pro-13-8-core-cpu-8-core-gpu-a-b45b-4.jpeg"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Ipad Air", price: "251", imageUrl: "https://www.pt.com.tr/wp-content/uploads/2024/06/M1eCfV58teDUe1tkUWBxBZjOPq5bi3UeKiDhjG39-2048x2048.webp"),
                  SizedBox(width: 10,),
                  ProductCard(title: "Airpods Pro", price: "321", imageUrl: "https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-4-select-202409_FV1?wid=976&hei=916&fmt=jpeg&qlt=90&.v=WnVKRVRUTFVsYThXaWkydWViL1Q3ZDZGTE9TV3RDcGJJclBqdUtzdTJYYjNHc3NlSmU2dzJyR1kxZEwyTE1neUJkRlpCNVhYU3AwTldRQldlSnpRa0NZZXAxWFNjRXhITDI1RVE5YVpyU0E"),
                  ],
                  ),
                ),

              ],
            ),

          ],
          ),
        ),
      ),
    );
  }
}