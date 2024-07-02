import 'package:flutter/material.dart';

class Page7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('assets/oscar.png'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Oscar Alexander Encarnacion',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Ocupación / Desarrollador de Software',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Correo electrónico: oscaralexander520@gmail.com',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Teléfono: +8094234245',
              style: TextStyle(fontSize: 16.0),
            ),
           
          ],       
        ),
      ),
    );
  }
}