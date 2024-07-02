import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final TextEditingController _controller = TextEditingController();
  int _age = 0;
  bool _loading = false;

  void _predictAge(String name) async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    final data = jsonDecode(response.body);

    setState(() {
      _age = data['age'];
      _loading = false;
    });
  }

  String _getAgeCategory(int age) {
    if (age < 18) {
      return 'Joven';
    } else if (age < 60) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  String _getImageUrl(int age) {
    if (age < 18) {
      return 'assets/nene.jpg'; // URL de la imagen para jóvenes
    } else if (age < 60) {
      return 'assets/joven.jpg'; // URL de la imagen para adultos
    } else {
      return 'assets/viejo.jpg'; // URL de la imagen para ancianos
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Perfil'),
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
              onPressed: () => _predictAge(_controller.text),
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20),
            if (_loading) CircularProgressIndicator(),
            if (_age != 0)
              Column(
                children: [
                  Text(
                    'Edad: $_age años',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Categoría de edad: ${_getAgeCategory(_age)}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Image.network(
                    _getImageUrl(_age),
                    height: 150,
                    width: 150,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}