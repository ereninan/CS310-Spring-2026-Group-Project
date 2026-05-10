import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final key1 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
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
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'email@domain.com', border: OutlineInputBorder()),
                  validator: (val) => (val == null || !val.contains('@')) ? 'Invalid email' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (val) => (val == null || val.isEmpty) ? 'Required' : null,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading ? null : () async {
                      if (key1.currentState!.validate()) {
                        try {
                          await authProvider.signIn(_emailController.text.trim(), _passwordController.text.trim());
                          if (!mounted) return;
                          showDialog(
                            context: context,
                            barrierDismissible: false, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Success"),
                                content: const Text("You have successfully signed in to Kampüsünden!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); 
                                      Navigator.pushReplacementNamed(context, '/homepage'); 
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
                    child: authProvider.isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Continue', style: TextStyle(color: Colors.white)),
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