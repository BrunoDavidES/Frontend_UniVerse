import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:hash_password/hashing_functionalities.dart';
import 'package:hash_password/password_hasher.dart';
import 'package:http/http.dart' as http;


class Article {
  //static List<Article> news = <Article>[];
  String? title;
  String? text;
  String? urlToImage;
  String? date;
  String? author;

  Article(
      this.title,
      this.text,
      this.urlToImage,
      this.date,
      this.author,
      );

  /*Article.fromJson(Map<String, dynamic> json ) {
    title = json['title'];
  }

  static Future<List<Article>> fetchNews(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl + newsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{

      }),
    );
    if(response.statusCode==200) {
      var decodedNews = json.decode(response.body);
      for(var decoded in decodedNews) {
        news.add(Article.fromJson(decoded));
      }
    }
    return news;
  }*/


  static List<Article> news = [
    Article("Carmona Rodrigues é o novo Presidente do Conselho Consultivo da ERSAR", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/crodrigues_1.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
    Article("Teste de notícias", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png", "31 de maio 2023", "Bruno"),
  ];
}
