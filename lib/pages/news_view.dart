import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List _news = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() async {
    setState(() {
      _loading = true;
    });
    final response = await http.get(Uri.parse('API_URL_FOR_NEWS'));
    final data = jsonDecode(response.body);

    setState(() {
      _news = data['articles'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias Recientes'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_news[index]['title']),
                  subtitle: Text(_news[index]['description']),
                  trailing: IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () {
                      launchURL(_news[index]['url']);
                    },
                  ),
                );
              },
            ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
