import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'home.dart';
import 'user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final String uid; // TODO: Change to provider
  Future<bool> _login(userProvider) async {
    const String url = 'http://localhost:8080/login';
    final Map<String, String> data = {
      'email': "dorikatere@mailinator.com",
      'password': "Pa\$\$w0rd!",
    };
    final response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 302) {
      final jsonData = json.decode(response.body);
      uid = jsonData['user']['_id'];
      userProvider.setUser(uid);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _login(userProvider).then((value) {
                  if (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login failed'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
