import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Page6 extends StatefulWidget {
  @override
  _Page6State createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://techcrunch.com/wp-json/wp/v2/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.take(3).map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de TechCrunch'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    child: Image.network(
                      'assets/logo.png',
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Error loading logo');
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.excerpt.replaceAll(RegExp(r'<[^>]*>'), ''),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  child: Text(
                                    'Leer más',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () {
                                    launch(post.link);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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

class Post {
  final String title;
  final String excerpt;
  final String link;

  Post({
    required this.title,
    required this.excerpt,
    required this.link,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title']['rendered'] ?? 'No title',
      excerpt: json['excerpt']['rendered'] ?? 'No excerpt',
      link: json['link'] ?? '',
    );
  }
}