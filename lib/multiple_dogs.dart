import 'package:flutter/material.dart';
import 'package:random_dog/helper_methods.dart';

class MultipleDogs extends StatefulWidget {
  const MultipleDogs({Key? key}) : super(key: key);

  @override
  _MultipleDogsState createState() => _MultipleDogsState();
}

class _MultipleDogsState extends State<MultipleDogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Random Dogs'),
      ),
      body: Center(
        child: Column(
          children: [
            DogsForm(),
          ],
        )
      )
    );
  }
}

class DogsForm extends StatefulWidget {
  const DogsForm({Key? key}) : super(key: key);

  @override
  _DogsFormState createState() => _DogsFormState();
}

class _DogsFormState extends State<DogsForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: '20',
                labelText: 'How many images would you like to view? (1-50)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the number of images you wish to view (1-50).';
                }
                //TODO: check for 1-50
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Go'),
              ),
            ),
          ],
        )
    );
  }
}

