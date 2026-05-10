import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key2 = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text("Register", style: AppUtils.title_Style), centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUtils.pad),
          child: Form(
            key: key2,
            child: Column(
              children: [
                SizedBox(height: 120),
                Text('KAMPUSUNDEN', style: AppUtils.titleStyle),
                SizedBox(height: 50),
                Text('Register', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Enter your email to sign up for this app', style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'email@domain.com', border: OutlineInputBorder()),
                  validator: (val) => (val == null || !val.contains('@')) ? 'Valid email required' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (val) => (val == null || val.length < 6) ? 'Min 6 characters' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(hintText: 'confirm password', border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Confirm password';
                    if (val != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading ? null : () async {
                      if (key2.currentState!.validate()) {
                        try {
                          await authProvider.register(_emailController.text.trim(), _passwordController.text.trim());
                          if (!mounted) return;
                          showDialog(
                            context: context,
                            barrierDismissible: false, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Registration Successful"),
                                content: const Text("Your account has been created. You can now sign in!"),
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
                SizedBox(height: 20),
                socialBtn(),
                SizedBox(height: 12),
                socialBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialBtn() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
        child: Text(''),
      ),
    );
  }
}