import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:kampusunden/product_detail_screen.dart';
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
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
                    // Arka plan rengini görseldeki gibi açık gri yapar
                    filled: true,
                    fillColor: const Color.fromARGB(255, 248, 245, 245), 
                    // Kenarlıkları tamamen kaldırır ve yuvarlar
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
                Row(
                  children: [
                    // FİLTRE BUTONU
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Filter", style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_drop_down, color: Colors.grey),
                        ],
                      ),
                    ),
                    
                    SizedBox(width: 10), // İki buton arası boşluk
            
                    // SIRALAMA BUTONU
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
        ),
      ),
    );
  }
}