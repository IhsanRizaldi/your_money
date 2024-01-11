import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isPemasukanSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPemasukanSelected = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: isPemasukanSelected
                        ? MaterialStateProperty.all(Colors.green)
                        : null,
                  ),
                  child: Text('Pemasukan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPemasukanSelected = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: !isPemasukanSelected
                        ? MaterialStateProperty.all(Colors.red)
                        : null,
                  ),
                  child: Text('Pengeluaran'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              isPemasukanSelected ? 'Form Pemasukan' : 'Form Pengeluaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nominal'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tanggal'),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Keterangan'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implementasi aksi saat tombol "Tambah" ditekan
                    },
                    child: Text('Tambah'),
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

void main() {
  runApp(MaterialApp(
    home: AddPage(),
  ));
}
