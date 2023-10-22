import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 40,
                  spreadRadius: 0.0,
                )
              ]
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Apa Yang Kamu Cari?",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black26,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                )
              ),
            ),
          ),
          CarouselSlider(
            items: [
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('assets/images/images1.png'),                
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('assets/images/images2.jpg'),                
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('assets/images/images3.jpg'),                
                fit: BoxFit.cover,
              ),
            ),
          ),
        ], 
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.keyboard_arrow_left_sharp),
              Text(
                "Januari 2024",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Icon(Icons.keyboard_arrow_right_sharp),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 55, left: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Pemasukan"),
                Padding(
                  padding: EdgeInsets.only(left: 185),
                  child: Text(
                  "20000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                )
                
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 55, left: 55),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                ),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text("Pengeluaran"),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 180,bottom: 20),
                  child: Text(
                  "10000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                )
                
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 55, left: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Total"),
                Padding(
                  padding: EdgeInsets.only(left: 225),
                  child: Text(
                  "10000",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                )
                
              ],
            ),         
          ),
        ],
      );
  }
}