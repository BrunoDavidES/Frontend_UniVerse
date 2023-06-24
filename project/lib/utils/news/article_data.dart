import 'dart:convert';
import 'dart:io';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:http/http.dart' as http;


class Article {
  static List<Article> news = <Article>[];
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
    urlToImage = "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png";
    text="Olá";
    print(id);
    print(title);
    print(author);
    print("OLÁ");
  }

  static Future<int> fetchNews(int limit, int offset) async {
   /*String newsUrl = '/feed/query/News?limit=$limit&offset=$offset';
    print(newsUrl);
    final response = await http.post(
      Uri.parse(baseUrl + newsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, Map<String, String>>{
       //'filters': {'validated_backoffice':'true'},
      }),
    );
    if(response.statusCode==200) {
      var decodedNews = json.decode(response.body);
      print(decodedNews);
      for (var decoded in decodedNews) {
        news.add(Article.fromJson(decoded));
      }
      print("DONE");
    }
    print(response.statusCode);
    print(news[0].id);
    print(news[0].title);
    print(news[0].author);
    print(news[0].date);
    print("OLÁ");
    return response.statusCode;*/
   return 200;
  }


  /*static List<Article> news = [
    Article("Carmona Rodrigues é o novo Presidente do Conselho Consultivo da ERSAR", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/crodrigues_1.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    ];*/
}
