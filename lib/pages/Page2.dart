import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final TextEditingController _controller = TextEditingController();
  String _gender = '';
  bool _loading = false;

  void _predictGender(String name) async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    final data = jsonDecode(response.body);

    setState(() {
      _gender = data['gender'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Búsqueda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _predictGender(_controller.text),
              child: Text('Predecir'),
            ),
            SizedBox(height: 20),
            if (_loading) CircularProgressIndicator(),
            if (_gender.isNotEmpty)
              Container(
                color: _gender == 'male' ? Colors.blue : Colors.pink,
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    _gender == 'male' ? 'Masculino' : 'Femenino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}