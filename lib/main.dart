
import 'package:flutter/material.dart';
//TODO: Import the necessary libraries from dart::

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
  

  void _fetchPostsFromWeb() {
    //TODO: call the HTTP url provided for retrieving a single do image
    //Parse the JSON response 
    //Set the value of the dog image url to randomDogImage variable
    //remember that this variable is nullable
    
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
             //TODO: if the randomDogImage variable is null
             //Show a text indicating that the image is not retrieved
             //Else, display the Image using the Network Image
             
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          //TODO: remember we are trying to call a method on a button 
          //press event and in order for the updated variable value
          //to be displayed on the UI, you need to do something...otherwise
          //irrespective of how many times you press this button, even if the
          //randomDogImage value is set, it won't show in the UI, unless
          //you do a hot restart. 
        onPressed: _fetchPostsFromWeb,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
