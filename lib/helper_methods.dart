import 'dart:convert';
import 'dart:io';

/// Fetch List of URL(s) for dog image(s) from Dog API
Future<List<String>> fetchURLListFromDogApi({int numDogs = 1}) async {
  var client = HttpClient();
  final url = Uri.https('dog.ceo', '/api/breeds/image/random/$numDogs');
  List<String> urlList = [];

  try {
    HttpClientRequest request = await client.getUrl(url);
    HttpClientResponse response = await request.close();

    // Process the response
    final stringData = await response.transform(utf8.decoder).join();

    var msg = jsonDecode(stringData);
    msg['message'].forEach((value) => urlList.add(value));

    return urlList;
  } finally {
    client.close();
  }
}
