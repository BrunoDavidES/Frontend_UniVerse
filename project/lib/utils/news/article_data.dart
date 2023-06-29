import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:http/http.dart' as http;

import '../../tester/utils/FirebaseAuthentication.dart';


class Article {
  static List<Article> news = <Article>[];
  static int numNews = 0;
  String? id;
  String? title;
  String? text;
  String? urlToImage;
  String? date;
  String? author;

  Article(
      //this.id,
      this.title,
      this.text,
      this.urlToImage,
      this.date,
      this.author,
      );

  //POR DATA CERTA, URL DA IMAGEM, E TEXTO
  Article.fromJson(Map<String, dynamic> json ) {
    var properties = json['properties'];
    id = properties['id']['value'];
    title = properties['title']['value'];
    author = properties['authorName']['value'];
    date = 'Teste Data';//json['properties']['time_creation']['value'].toString();
    urlToImage = images[Random().nextInt(images.length)];
    text="Olá";
    print(id);
    print(title);
    print(author);
    print("OLÁ");
  }

  static Future<int> fetchNews(String limit, String offset, Map<String, String> filters) async {
    String apiUrl = '$feedsUrl/numberOf/News';

    String token = await FirebaseAuthentication.getIdToken();
    if(token.isEmpty) {
      return 403;
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(filters);

    try {
      final http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: headers,
          body: requestBody
      );

      if (response.statusCode == 200) {
        numNews = json.decode(response.body);
        print(numNews);
      } else {
        return 500;
      }
    } catch (e) {
      return 500;
    }

    apiUrl = '$feedsUrl/query/News';

    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> queryParameters = {
      if (limit.isNotEmpty) 'limit': limit,
      if (offset.isNotEmpty) 'offset': offset,
    };

    try {
      final http.Response response = await http.post(
          uri.replace(queryParameters: queryParameters),
          headers: headers,
          body: requestBody
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);

        print('Query results: $results');
        print(response.statusCode);
        print(news[0].id);
        print(news[0].title);
        print(news[0].author);
        print(news[0].date);
        print("OLÁ");
        print(news.length);

        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return 405;
    }
  }

static List<String> images = [
  "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/06/santanderexpresso.png",
  "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/samsung_madeira_website.png",
  "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/laqv_equipa.png",
  "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/esports.png"
];
}
