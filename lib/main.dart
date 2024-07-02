import 'package:cotapp/pages/Page3.dart';
import 'package:cotapp/pages/Page4.dart';
import 'package:cotapp/pages/Page5.dart';
import 'package:cotapp/pages/Page6.dart';
import 'package:cotapp/pages/Page7.dart';
import 'package:cotapp/pages/page2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Widget> pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
    Page5(),
    Page6(),
    Page7(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar la marca de "debug"
      home: MyHomePage(pages),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Widget> pages;

  MyHomePage(this.pages);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea 6 (Couteau) OEncarnacion'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: widget.pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white, // Color blanco para íconos no seleccionados
        selectedItemColor: Colors.white, // Color blanco para íconos seleccionados
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
       items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Género',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Nombre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Escuelas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'WordPress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Acerca de',
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/caja.png'), // Muestra la imagen desde assets
    );
  }
}



