import 'dart:convert';
import 'dart:io';

void main() async {
  var m = await http();

  for (var url in m) {
    print(url);
  }
}

Future<List<String>> http({int numDogs = 10}) async {
  var client = HttpClient();
  final url = Uri.https('dog.ceo', '/api/breeds/image/random/$numDogs');
  List<String> imageList = [];

  try {
    HttpClientRequest request = await client.getUrl(url);
    HttpClientResponse response = await request.close();

    // Process the response
    final stringData = await response.transform(utf8.decoder).join();
    print(stringData);

    var msg = jsonDecode(stringData);
    msg['message'].forEach(
  (value) => imageList.add(value)
  );
    return imageList;
  } finally {
    client.close();
  }
}
