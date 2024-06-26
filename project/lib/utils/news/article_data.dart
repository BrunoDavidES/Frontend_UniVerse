import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Article {
  static List<Article> news = <Article>[];
  static int numNews = 0;
  static String cursor = "EMPTY";
  String? id;
  String? title;
  String? text;
  String urlToImage = "https://www.fct.unl.pt/sites/default/files/imagens/noticias/2018/11/campus.jpg";
  String? date;
  String? author;

  Article(
      this.id,
      this.title,
      this.date,
      this.author,
      );

  //POR DATA CERTA, URL DA IMAGEM, E TEXTO
  Article.fromJson(Map<String, dynamic> json ) {
    var properties = json['properties'];
    id = properties['id']['value'];
    title = properties['title']['value'];
    author = properties['authorName']['value'];
    var dateAux = properties['time_creation']['value']['seconds'];
    var dateAux2 = properties['time_creation']['value']['nanos'];
    var dateAux3 = formatTimestamp(dateAux, dateAux2);
    DateTime originalDate = DateTime.parse(dateAux3);
    final newDateFormat = DateFormat('dd-MM-yyyy');
    date = newDateFormat.format(originalDate);
  }

  static Future<int> fetchNews(int limit, String offset, Map<String, String> filters) async {
    String newsUrl = '/feed/numberOf/News';
    var response;
    var token;

    if(offset == ''){
      return 200;
    }

    if(Authentication.getTokenID() == ""){
      token = "notLogged";
    }
    else {
      token = await Authentication.getTokenID();
    }

    if(numNews == 0) {
      response = await http.post(
          Uri.parse(baseUrl + newsUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: "{}"
      );

      if(response.statusCode==200) {
        numNews = json.decode(response.body);
      }
      else return 500;
    }
    newsUrl = '/feed/query/News?limit=$limit&offset=$offset';
    if(filters.isEmpty)
    response = await http.post(
        Uri.parse(baseUrl + newsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: "{}"
    );
    else  response = await http.post(
        Uri.parse(baseUrl + newsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({"filters": filters})
    );
    if(response.statusCode==200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      cursor = decodedJson['cursor'];
      var decodedNews = decodedJson['results'];
      for (var decoded in decodedNews) {
        news.add(Article.fromJson(decoded));
      }
    }
    return response.statusCode;
  }




  /*static List<Article> news = [
    Article("Carmona Rodrigues é o novo Presidente do Conselho Consultivo da ERSAR", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/crodrigues_1.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias1", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias2", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias3", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias4", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias5", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias6", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias7", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias8", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias9", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias10", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno")
  ];*/

  /*static List<String> images = [
    "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/06/santanderexpresso.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/samsung_madeira_website.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/laqv_equipa.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/esports.png",
  ];*/

  String formatTimestamp(int seconds, int nanos) {
    final milliseconds = seconds * 1000 + (nanos / 1000000).round();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
