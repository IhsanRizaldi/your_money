import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool isPemasukanSelected = true;
  TextEditingController nominalController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? bearerToken;

  @override
  void initState() {
    super.initState();
    _fetchBearerToken();
  }

  Future<void> _fetchBearerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bearerToken = prefs.getString('bearerToken');
    });
  }

  Future<void> tambahData() async {
    if (!formKey.currentState!.validate()) {
      // Form is not valid, do not proceed
      return;
    }

    if (bearerToken == null || bearerToken!.isEmpty) {
      // Handle the case when the token is not available
      print('Bearer token not available');
      return;
    }

    String apiUrl = isPemasukanSelected
        ? 'http://localhost:8000/api/v1/pemasukan'
        : 'http://localhost:8000/api/v1/pengeluaran';

    Map<String, String> headers = {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    };

    Map<String, dynamic> data = {
      'nominal': nominalController.text,
      'tanggal': tanggalController.text,
      'keterangan': keteranganController.text,
    };

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        // Handle success, if needed
        print('Data added successfully');

        // Show a SnackBar notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Reset the form
        formKey.currentState!.reset();
        nominalController.clear();
        tanggalController.clear();
        keteranganController.clear();
      } else {
        // Handle errors, if needed
        print('Failed to add data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions, if any
      print('Error: $error');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        tanggalController.text = pickedDate.toString();
      });
    }
  }

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
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nominalController,
                    decoration: InputDecoration(labelText: 'Nominal'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter nominal';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: tanggalController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal',
                      suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: keteranganController,
                    decoration: InputDecoration(labelText: 'Keterangan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter keterangan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      tambahData();
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
