import 'dart:math';

import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/news_screen/news_web_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import '../Components/default_button.dart';
import '../components/500.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../news_screen/news_web_Aux.dart';
import '../news_screen/news_web_AuxEndPage.dart';
import '../utils/events/event_data.dart';
import '../utils/news/article_data.dart';

class EventsWebPage extends StatefulWidget {
  EventsWebPage({super.key});

  @override
  State<EventsWebPage> createState() => _EventsWebPageState();
}

class _EventsWebPageState extends State<EventsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  @override
  void initState() {
    fetchDone = Event.fetchEvents(4, 0, {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
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
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 7),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 20),
                          child:
                          Authentication.userIsLoggedIn
                ?Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset("assets/titles/events.png", scale: 4,)
                          )
                          : Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/titles/events.png", scale: 4,)
                  ),
                          Spacer(),
                          Icon(Icons.info_outline,),
                          Text(
                              "Inicia sessão na tua conta UniVerse para poderes aceder a mais eventos e guardares no teu calendário pessoal.",
                              style: TextStyle(
                                  fontSize: 15
                              )
                          ),
                          SizedBox(width: 50)
              ],
            )
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          //Zona do Feed
                          height: size.height * 1.60,
                          width: size.width - 300,
                          color: cDirtyWhite,

                          child: FutureBuilder(
                              future: fetchDone,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == 500) {
                                    return Error500();
                                  }
                                  return ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, int index) {
                                      final event = Event.events[index];

                                      return Column(
                                        children: [
                                          SizedBox(
                                            child: Divider(
                                              thickness: 2,
                                              color: toRandom[cindex],
                                            ),
                                          ),
                                          Container(
                                            height: size.height / 3,
                                            decoration: BoxDecoration(
                                              color: cDirtyWhiteColor,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            margin: EdgeInsets.only(top: 5, bottom: 5),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: size.width / 4,
                                                    height: size.height / 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                          15.0),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(event.urlToImage!),
                                                      ),
                                                      border: Border.all(
                                                        color: cHeavyGrey,
                                                      ),
                                                      boxShadow: [ BoxShadow(
                                                        color: Colors.grey.withOpacity(0.75),
                                                        spreadRadius: 3,
                                                        blurRadius: 7,
                                                        offset: const Offset(0, 0),
                                                      ),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(width: 15,),
                                                Container(
                                                    width: size.width / 1.95,
                                                    height: size.height / 3,
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Text(
                                                          "${event.title}".toUpperCase(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: [
                                                            Text("${event.startDate} · ${event.endDate}",
                                                              style: TextStyle(
                                                                  color: cHeavyGrey
                                                              ),
                                                            ),
                                                            SizedBox(width: 10,),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.location_on_outlined, color: cHeavyGrey),
                                                                Text(
                                                                  event.location!,
                                                                  style: TextStyle(
                                                                      color: cHeavyGrey
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10,),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.people, color: cHeavyGrey),
                                                                Text(
                                                                  event.capacity!,
                                                                  style: TextStyle(
                                                                      color: cHeavyGrey
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10,),
                                                            if(event.isPaid=="yes")
                                                            Row(
                                                              children: [
                                                                Icon(Icons.euro_outlined, color: cHeavyGrey),
                                                                Text(
                                                                  "PAGO",
                                                                  style: TextStyle(
                                                                      color: cHeavyGrey
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text(
                                                          "${event.description}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${event.planner} · ${event.department}",
                                                              style: TextStyle(
                                                                  color: cHeavyGrey
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            if(Authentication.userIsLoggedIn)
                                                              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark, color: cHeavyGrey,)),
                                                            IconButton(onPressed: () {}, icon: Icon(Icons.share, color: cHeavyGrey,)),
                                                            IconButton(onPressed: () =>context.go("/events/full/${event.id}", extra: event), icon: Icon(Icons.remove_red_eye, color: cHeavyGrey,))
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return Center(
                                    child: LinearProgressIndicator());
                              }
                          ),
                        ),
                        SizedBox(
                          width: size.width - 300,
                          child: Divider(
                            thickness: 2,
                            color: toRandom[cindex],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultButton(
                                  text: "Próxima Página",
                                  press: () {
                                    Article.news.length > 6 ?
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWebPageAux(indexAux: 1))) :
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWebPageAuxEnd(indexAux: 1)));
                                  }),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icons.navigate_next_outlined,
                                ].map((e) {
                                  return InkWell(
                                    onTap: () {
                                      Article.news.length > 6 ?
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsWebPageAux(indexAux: 1))) :
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsWebPageAuxEnd(indexAux: 1)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(e, size: 50, color: cPrimaryColor),
                                    ),
                                  );
                                }).toList(),
                              )
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
        )
    );
  }

}

/*class Article {
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
    postedOn: "1 seconds ago",
  ),
];

 */