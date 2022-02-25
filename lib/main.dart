import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:random_dog/multiple_dogs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Dog Image',
      initialRoute: '/',
      routes: {
        '/': (context) => const RandomDog(),
        '/MultipleDogs': (context) => const MultipleDogs(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class RandomDog extends StatefulWidget {
  const RandomDog({Key? key}) : super(key: key);

  @override
  _RandomDogState createState() => _RandomDogState();
}

class _RandomDogState extends State<RandomDog> {
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
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 20),
              child: ElevatedButton(
                  onPressed: () { Navigator.pushNamed(context, '/MultipleDogs'); },
                  child: Text('View multiple dogs', style: TextStyle(fontSize: 18))
              ),
            )
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
