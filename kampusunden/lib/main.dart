import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:kampusunden/firebase_options.dart';
import 'package:kampusunden/providers/auth_provider.dart';
import 'package:kampusunden/providers/listing_provider.dart';
import 'package:kampusunden/home_page.dart';
import 'package:kampusunden/chats_page.dart';
import 'package:kampusunden/create_listing_page.dart';
import 'package:kampusunden/discover_page.dart';
import 'package:kampusunden/profile_page.dart';
import 'package:kampusunden/register_screen.dart';
import 'package:kampusunden/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kampusunden',
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const SignInScreen(),
        '/register': (context) => const RegisterScreen(),
        '/homepage': (context) => const HomePage(),
        '/discover': (context) => const DiscoverPage(),
        '/chats': (context) => const ChatsApp(),
        '/createListing': (context) => const CreateListingApp(),
        '/profile': (context) => const ProfileApp(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.user != null) {
          return const HomePage();
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}