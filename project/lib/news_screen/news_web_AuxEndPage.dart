import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../Components/default_button.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/about_bottom.dart';
import 'news_web_Aux.dart';

class NewsWebPageAuxEnd extends StatelessWidget {
  final int indexAux;

  NewsWebPageAuxEnd({required this.indexAux}) : super();

  @override
  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            color: cDirtyWhite,
            child: Stack(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: size.height/6),
                  child: Column(
                    children: [
                      Container(                //Zona do Feed
                        height: 950,
                        width: 1100,
                        color: cDirtyWhite,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            final item = _articles[index + 3 * indexAux];
                            return Container(
                              height: 280,
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color: const Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                      width: size.width/5,
                                      height: 220,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(item.imageUrl),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      )
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: size.width/3.2,
                                    child: Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(
                                              "${item.title}".toUpperCase(),
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${item.preNews}",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(), const Spacer(),
                                            Text("  ${item.author} · ${item.postedOn}",
                                                style: Theme.of(context).textTheme.caption),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icons.bookmark_border_rounded,
                                                Icons.share,
                                                Icons.more_vert
                                              ].map((e) {
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: Icon(e, size: 16),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),Spacer(),Spacer(),Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icons.arrow_back_ios_rounded,
                              ].map((e) {
                                return InkWell(
                                  onTap: () {
                                    indexAux - 3 > 3?
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewsWebPageAux(indexAux: -1))):
                                    Navigator.pushNamed(context, '/news');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(e, size: 30),
                                  ),
                                );
                              }).toList(),
                            ),
                            DefaultButton(
                                text: "Página Anterior",
                                press: () {
                                  indexAux - 3 > 3?
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsWebPageAux(indexAux: -1))):
                                  Navigator.pushNamed(context, '/news');
                                }),
                            Spacer(),Spacer(),Spacer(),Spacer()
                          ],
                        ),
                      ),
                      BottomAbout(size: size),
                    ],
                  ),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String preNews;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {
        required this.title,
        required this.preNews,
        required this.imageUrl,
        required this.author,
        required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "Instagram quietly limits ‘daily time limit’ option",
    preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
    author: "MacRumors",
    imageUrl: "https://picsum.photos/id/1000/960/540",
    postedOn: "Yesterday",
  ),
  Article(
      title: "Google Search dark theme goes fully black for some on the web",
      preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
      imageUrl: "https://picsum.photos/id/1010/960/540",
      author: "9to5Google",
      postedOn: "4 hours ago"),
  Article(
    title: "Check your iPhone now: warning signs someone is spying on you",
    preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
    author: "New York Times",
    imageUrl: "https://picsum.photos/id/1001/960/540",
    postedOn: "2 days ago",
  ),
  Article(
    title:
    "Amazon’s incredibly popular Lost Ark MMO is ‘at capacity’ in central Europe",
    preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
    author: "MacRumors",
    imageUrl: "https://picsum.photos/id/1002/960/540",
    postedOn: "22 hours ago",
  ),
  Article(
    title:
    "Panasonic's 25-megapixel GH6 is the highest resolution Micro Four Thirds camera yet",
    preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
    author: "Polygon",
    imageUrl: "https://picsum.photos/id/1020/960/540",
    postedOn: "2 hours ago",
  ),
  Article(
    title:
    "Isto e a noticia final da Universe, infelizmente e assim que as coisas acontecem",
    preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim...",
    author: "Um dos donos da universe",
    imageUrl: "https://picsum.photos/id/1020/960/540",
    postedOn: "1 second ago",
  ),
];