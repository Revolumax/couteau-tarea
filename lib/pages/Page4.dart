import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];

  void _searchUniversities() async {
    String countryName = _countryController.text.trim();
    if (countryName.isEmpty) return;

    String apiUrl = 'http://universities.hipolabs.com/search?country=$countryName';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _universities = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load universities');
      }
    } catch (e) {
      print('Error fetching universities: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Ingresa tu pais en ingles',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchUniversities,
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  var uni = _universities[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(uni['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Domain: ${uni['domains'].join(', ')}'),
                          SizedBox(height: 4.0),
                          Text('Website: ${uni['web_pages'][0]}'),
                        ],
                      ),
                      onTap: () {
                        // Handle tapping on each university if needed
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}