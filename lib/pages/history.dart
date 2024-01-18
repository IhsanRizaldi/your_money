import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<TransactionItem> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final response = await http.get(
      Uri.parse('http://localhost:8000/api/v1/history'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and update the transactions list
      // Replace this with your actual parsing logic
      // Assuming your API response is a list of transactions
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        transactions = jsonResponse
            .map((item) => TransactionItem.fromJson(item))
            .toList();
      });
    } else {
      // Handle error fetching transactions
      print('Failed to fetch transactions. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return TransactionCard(transaction: transactions[index]);
        },
      ),
    );
  }
}

class TransactionItem {
  final int nominal; // Change to int
  final DateTime time;
  final String keterangan;
  final String kategori;

  TransactionItem({
    required this.nominal,
    required this.time,
    required this.keterangan,
    required this.kategori,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      nominal: json['nominal'],
      time: DateTime.parse(json['tanggal']),
      keterangan: json['keterangan'],
      kategori: json['kategori'],
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionItem transaction;

  TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          transaction.nominal > 0 ? Icons.arrow_upward : Icons.arrow_downward,
          color: transaction.nominal > 0 ? Colors.green : Colors.red,
        ),
        title: Text('${transaction.nominal}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${transaction.time.toString()}'),
            Text('Description: ${transaction.keterangan}'),
            Text('Category: ${transaction.kategori}'),
          ],
        ),
      ),
    );
  }
}
