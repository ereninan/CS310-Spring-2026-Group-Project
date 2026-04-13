import 'package:flutter/material.dart';
import 'package:kampusunden/utils.dart';



class CreateListingApp extends StatefulWidget {
  const CreateListingApp({super.key});

  @override
  State<CreateListingApp> createState() => _CreateListingAppState();
}

class _CreateListingAppState extends State<CreateListingApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Create Listing',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 170,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: AppUtils.appBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📦'),
                        SizedBox(width: 8),
                        Text(
                          'For Sale',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('🙏'),
                  const SizedBox(width: 8),
                  const Text('Wanted', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📷', style: TextStyle(fontSize: 24)),
                        Text('Add Image', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Center(child: Text('🖼️', style: TextStyle(fontSize: 30))),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Center(child: Text('🖼️', style: TextStyle(fontSize: 30))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text('Category:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [const Text('📚'), const SizedBox(width: 4), Text('Books', style: AppUtils.product_card_title,)]),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppUtils.appBlue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [const Text('💻'), const SizedBox(width: 4), Text('Electronics', style: AppUtils.product_card_title)]),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [const Text('🪑'), const SizedBox(width: 4), Text('Furniture', style: AppUtils.product_card_title)]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brand:', style: AppUtils.headerStyle),
                  TextField(decoration: InputDecoration(hintText: 'Enter brand name')),
                  SizedBox(height: 16),
                  Text('Title:', style: AppUtils.headerStyle),
                  TextField(decoration: InputDecoration(hintText: 'Enter product title')),
                  SizedBox(height: 16),
                  Text('Price:', style: AppUtils.headerStyle),
                  TextField(decoration: InputDecoration(hintText: 'Enter price ₺')),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppUtils.appBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                'Go Live',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      );
    
  }
}