import 'package:flutter/material.dart';
import 'package:kampusunden/home_page.dart';
import 'package:kampusunden/chats_page.dart';
import 'package:kampusunden/create_listing_page.dart';
import 'package:kampusunden/discover_page.dart';
import 'package:kampusunden/product_detail_screen.dart';
import 'package:kampusunden/cards/product_card.dart';
import 'package:kampusunden/profile_page.dart';
import 'package:kampusunden/register_screen.dart';
import 'package:kampusunden/sign_in_screen.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, 
    initialRoute: '/', 
    routes: {
      '/': (context) => const SignInScreen(),
      '/register': (context) => const RegisterScreen(),
      '/homepage': (context) => const HomePage(),
      '/discover': (context) => const DiscoverPage(),
      '/chats': (context) => const ChatsApp(),
      '/createListing': (context) => const CreateListingApp(),
      '/profile': (context) => const ProfileApp(),
    },
  ));
}