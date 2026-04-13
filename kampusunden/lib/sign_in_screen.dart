import 'package:flutter/material.dart';
import 'utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUtils.pad),
          child: Form(
            key: key1,
            child: Column(
              children: [
                SizedBox(height: 140),
                Text('KAMPUSUNDEN', style: AppUtils.title_Style),
                SizedBox(height: 60),
                Text('Sign In', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(hintText: 'email@domain.com', border: OutlineInputBorder()),
                  validator: (val) => (val == null || !val.contains('@')) ? 'Invalid email' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (key1.currentState!.validate()) {
                        // Başarılı girişte AlertDialog gösteriyoruz
                        showDialog(
                          context: context,
                          barrierDismissible: false, // Kullanıcı OK demeden kapanmasın
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Success"),
                              content: const Text("You have successfully signed in to Kampüsünden!"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Dialogu kapat
                                    Navigator.pushReplacementNamed(context, '/homepage'); // Ana sayfaya yönlendir
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
                    child: Text('Continue', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text('Don\'t have an account? Register', style: TextStyle(color: AppUtils.myColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}