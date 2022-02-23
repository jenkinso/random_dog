import 'dart:convert';
import 'dart:io';

void main() {
  http();
}

void http() async {
  var client = HttpClient();
  try {
    var url = Uri.https('dog.ceo', '/api/breeds/image/random');
    HttpClientRequest request = await client.getUrl(url);
    HttpClientResponse response = await request.close();
    // Process the response
    final stringData = await response.transform(utf8.decoder).join();
    print(stringData);

    var msg = jsonDecode(stringData);
    print(msg['message']);
  } finally {
    client.close();
  }
}
