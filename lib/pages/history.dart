import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              "History Budget",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildTransactionItem("Pemasukan", "500000", "2024-01-01"),
            _buildTransactionItem("Pengeluaran", "250000", "2024-01-05"),
            // Add more transaction items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String type, String amount, String date) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(type),
        subtitle: Text(
          "Nominal: $amount\nTanggal: $date",
        ),
      ),
    );
  }
}
