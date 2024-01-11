import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
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
        GestureDetector(
          onTap: () {
            // Handle image click (for editing, etc.)
            // You can implement the functionality you need here
          },
          child: Column(
            children: [
              Image.asset('assets/images/example1.png'),
              SizedBox(height: 10),
              Text(
                'Tap to Edit',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        buildTextFormField('Ihsan Tampan', 'Full Name'),
        buildTextFormField('Ihsantampan123@gmail.com', 'Email'),
        buildTextFormField('', 'New Password', isPassword: true),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            onPressed: () {
              // Handle edit button click
            },
            child: Text('Edit'),
          ),
        ),
      ],
    );
  }

  Widget buildTextFormField(String hintText, String label, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: hintText,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
