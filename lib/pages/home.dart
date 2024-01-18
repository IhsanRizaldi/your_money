import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pemasukan = [];
  List<Map<String, dynamic>> pengeluaran = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final pemasukanResponse = await http.get(
      Uri.parse('http://localhost:8000/api/v1/pemasukan'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    final pengeluaranResponse = await http.get(
      Uri.parse('http://localhost:8000/api/v1/pengeluaran'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    if (pemasukanResponse.statusCode == 200 &&
        pengeluaranResponse.statusCode == 200) {
      final pemasukanData =
          jsonDecode(pemasukanResponse.body) as List<dynamic>;
      final pengeluaranData =
          jsonDecode(pengeluaranResponse.body) as List<dynamic>;

      setState(() {
        pemasukan = pemasukanData
            .map((item) => item as Map<String, dynamic>)
            .toList();
        pengeluaran = pengeluaranData
            .map((item) => item as Map<String, dynamic>)
            .toList();
      });
    }
  }

  Future<void> deleteData(String id, String jenis) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('bearerToken') ?? '';

    final response = await http.delete(
      Uri.parse('http://localhost:8000/api/v1/$jenis/$id'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Refresh data after successful deletion
      fetchData();

      // Show success notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data deleted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle error if needed
      print('Failed to delete data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[100],
              child: Column(
                children: [
                  Text(
                    'Tabel Pemasukan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Nominal',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tanggal',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Keterangan',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Aksi',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: pemasukan
                        .map(
                          (transaction) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(transaction['nominal'].toString())),
                              DataCell(Text(transaction['tanggal'])),
                              DataCell(Text(transaction['keterangan'])),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    deleteData(
                                      transaction['id'].toString(),
                                      'pemasukan',
                                    );
                                  },
                                  child: Text('Hapus'),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Text(
                    'Tabel Pengeluaran',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Nominal',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Tanggal',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Keterangan',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Aksi',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: pengeluaran
                        .map(
                          (transaction) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(transaction['nominal'].toString())),
                              DataCell(Text(transaction['tanggal'])),
                              DataCell(Text(transaction['keterangan'])),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {
                                    deleteData(
                                      transaction['id'].toString(),
                                      'pengeluaran',
                                    );
                                  },
                                  child: Text('Hapus'),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
