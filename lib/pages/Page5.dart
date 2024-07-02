import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=dominican%20republic&appid=09d2de46fdb05ddf9967f00f90df09a1'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Republica Dominicana'),
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Clima en ${weather.place}',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '${weather.temperature} °C',
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    weather.description,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              );
            } else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}

class Weather {
  final String place;
  final double temperature;
  final String description;

  Weather({
    required this.place,
    required this.temperature,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      place: json['name'] ?? 'Desconocido',
      temperature: json['main']?['temp']?.toDouble() ?? 0.0,
      description: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['description']
          : 'No disponible',
    );
  }
}
