import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Fetch user data when the page is loaded
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/v1/user'),  // Adjust the endpoint for fetching user data
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      setState(() {
        _nameController.text = userData['name'] ?? '';  // Default to an empty string if null
        _emailController.text = userData['email'] ?? '';  // Default to an empty string if null
      });
    } else {
      // Handle error if needed
      print('Failed to fetch user data. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final response = await http.put(
      Uri.parse('http://localhost:8000/api/v1/user/update'),  // Adjust the endpoint for updating user data
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
      body: {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Show success notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle error if needed
      final responseData = json.decode(response.body);
      setState(() {
        _errorMessage = responseData['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            "Profil",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildTextFormField(_nameController, 'Full Name'),
        buildTextFormField(_emailController, 'Email'),
        buildTextFormField(_passwordController, 'New Password', isPassword: true),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            onPressed: updateProfile,
            child: Text('Edit'),
          ),
        ),
        if (_errorMessage.isNotEmpty)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget buildTextFormField(TextEditingController controller, String label, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: controller.text.isEmpty ? null : controller.text,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
