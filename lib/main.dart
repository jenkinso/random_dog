import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dog Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? randomDogImage;
  final String randomDogHost = 'dog.ceo';
  final String randomDogPath = '/api/breeds/image/random';

  /// Fetch URL for dog image from Dog API
  void _fetchPostsFromWeb() async {
    var client = HttpClient();

    try {
      var url = Uri.https(randomDogHost, randomDogPath);
      HttpClientRequest request = await client.getUrl(url);
      HttpClientResponse response = await request.close();

      // Process the response
      final stringData = await response.transform(utf8.decoder).join();
      var data = jsonDecode(stringData);

      // Extract the URL of the dog image provided by Dog API. Update UI.
      setState(() {
        randomDogImage = data['message'];
      });
    } finally {
      client.close();
    }
  }

  /// Return Image widget if available, otherwise error Text
  Widget _displayDog() {
    if (randomDogImage == null) {
      //return const Text('Please refresh to load a new dog image!', style: TextStyle(fontSize: 22));
      return AlertDialog(
        title: const Text('No image available'),
        content: const Text('Press Refresh to load a new dog!'),
        actions: <Widget>[
          TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
          )
        ]
      );
    }
    else {
      return Image.network(randomDogImage as String);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dog Image'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
             child: _displayDog(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchPostsFromWeb,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
