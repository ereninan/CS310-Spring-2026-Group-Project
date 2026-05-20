import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kampusunden/cards/product_card.dart';

void main() {
  testWidgets('ProductCard renders correct title, brand, and price', (WidgetTester tester) async {
    // Build the ProductCard in a testable environment
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProductCard(
            title: 'Dorm Fridge',
            brand: 'Beko',
            price: '2500',
            imageUrl: '',
            sellerId: 'seller123',
          ),
        ),
      ),
    );

    // Verify if the Brand name is rendered
    expect(find.text('Beko'), findsOneWidget);

    // Verify if the Price is rendered with format "Price: 2500"
    expect(find.text('Price: 2500'), findsOneWidget);

    // Verify if the image placeholder icon is rendered since imageUrl is empty
    expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
  });
}
