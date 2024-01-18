import 'package:flutter/material.dart';
import 'package:your_money/pages/add.dart';
import 'package:your_money/pages/home.dart';
import 'package:your_money/pages/profil.dart';
import 'package:your_money/pages/history.dart'; // Import your history page
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_money/pages/login.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AddPage(),
    HistoryPage(), // Added HistoryPage
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Your Money App',
          ),
        ),
        backgroundColor: Colors.purple.shade900,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple.shade900,
        unselectedItemColor: Colors.purple.shade900.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Add',
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            label: 'History', // Added History label
            icon: Icon(Icons.history), // Added History icon
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final response = await http.post(
      Uri.parse('http://localhost:8000/api/v1/logout'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Clear token from SharedPreferences
      await prefs.remove('bearerToken');

      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Handle logout failure if needed
      print('Failed to logout. Status code: ${response.statusCode}');
    }
  }
}
