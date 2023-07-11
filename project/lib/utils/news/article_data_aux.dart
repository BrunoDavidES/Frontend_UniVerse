import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ArticleAux {
  static List<ArticleAux> news = <ArticleAux>[];
  static Map<String?, ArticleAux> newsAux = Map<String?, ArticleAux>();
  static int numNews = 0;
  static String cursor = "EMPTY";
  String? id;
  String? title;
  String? text;
  String urlToImage = "https://www.fct.unl.pt/sites/default/files/imagens/noticias/2018/11/campus.jpg";
  String? date;
  String? author;

  ArticleAux(
      this.id,
      this.title,
      this.date,
      this.author,
      );

  //POR DATA CERTA, URL DA IMAGEM, E TEXTO
  ArticleAux.fromJson(Map<String, dynamic> json ) {
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
        print(numNews);
      }
      else return 500;
    }
    newsUrl = '/feed/query/News?limit=$limit&offset=$offset';
    print(newsUrl);
    response = await http.post(
        Uri.parse(baseUrl + newsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: "{}"
    );
    if(response.statusCode==200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      cursor = decodedJson['cursor'];
      var decodedNews = decodedJson['results'];
      for (var decoded in decodedNews) {
        newsAux.putIfAbsent(ArticleAux.fromJson(decoded).id, () => ArticleAux.fromJson(decoded));
        /*if(!news.contains(ArticleAux.fromJson(decoded))){
          news.add(ArticleAux.fromJson(decoded));
        }*/
      }
    }
    return response.statusCode;
  }

  String formatTimestamp(int seconds, int nanos) {
    final milliseconds = seconds * 1000 + (nanos / 1000000).round();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}