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
        title: const Text('Multiple Random Dogs'),
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
  int numDogs = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'How many images would you like to view? (1-50)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the number of images you wish to view (1-50).';
                }

                int? valueAsInt = int.tryParse(value);
                if (valueAsInt != null) {
                  if (valueAsInt < 1 || valueAsInt > 50) {
                    return 'Please enter a number between 1 and 50.';
                  }

                  numDogs = valueAsInt;
                }

                return null;
              },
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    var urlList = await fetchURLListFromDogApi(numDogs: numDogs);
                    Navigator.pushNamed(context, '/MultipleDogsDisplay', arguments: urlList);

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

class MultipleDogsDisplay extends StatefulWidget {
  const MultipleDogsDisplay({Key? key}) : super(key: key);

  @override
  _MultipleDogsDisplayState createState() => _MultipleDogsDisplayState();
}

class _MultipleDogsDisplayState extends State<MultipleDogsDisplay> {
  @override
  Widget build(BuildContext context) {

    final urlList = ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Multiple Random Dogs'),
        ),
        body: Center(
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: urlList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                      ),
                      itemBuilder: (context, index) {
                        return Image.network(urlList[index]);
                      }
                  )
                )
              ],
            )
        )
    );
  }
}


