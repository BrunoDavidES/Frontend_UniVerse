import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:UniVerse/utils/news/article_data.dart';

import '../calendar_screen/personal_page_web_test.dart';
import '../components/not_found.dart';
import '../components/web/500_web.dart';
import '../events_screen/events_web.dart';
import '../events_screen/events_web_detail_screen.dart';
import '../faq_screen/faq_web.dart';
import '../find_screen/find_page_web.dart';
import '../info_screen/universe_info_web.dart';
import '../main_screen/homepage_web.dart';
import '../news_screen/news_web.dart';
import '../news_screen/news_web_detail_screen.dart';
import 'events/event_data.dart';

class Routing {
  static GoRouter router = GoRouter(
      errorBuilder: (BuildContext context, GoRouterState state) =>
          PageNotFound(),
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/error',
          builder: (BuildContext context, GoRouterState state) => Error500Web(),
        ),
        GoRoute(
          name: 'Início',
          path: '/home',
          builder: (BuildContext context, GoRouterState state) => WebHomePage(),
        ),
        GoRoute(
          name: 'Procurar',
          path: '/find',
          builder: (BuildContext context, GoRouterState state) => FindWebPage(),
        ),
        GoRoute(
            name: 'Notícias',
            path: '/news',
            builder: (BuildContext context, GoRouterState state) => NewsWebPage(),
            routes: [
              GoRoute(
                path: 'full/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  Article? data = state.extra as Article?;
                  if(data==null) {
                    Article.fetchNews("1", "0", {'id': id!});
                    if(Article.news.isEmpty)
                      return PageNotFound();
                    else data = Article.news[0];
                  }
                  return NewsDetailScreenWeb(id: id.toString(), data: data,);
                },
                /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
              ),
            ]
        ),
        GoRoute(
            name: 'Eventos',
            path: '/events',
            builder: (BuildContext context, GoRouterState state) =>
                EventsWebPage(),
            routes: [
              GoRoute(
                path: 'full/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  Event? data = state.extra as Event?;
                  if(data==null) {
                    Event.fetchEvents("1", "0", {'id': id!});
                    if(Event.events.isEmpty)
                      return PageNotFound();
                    else data = Event.events[0];
                  }
                  return EventsDetailScreenWeb(id: id.toString(), data: data,);
                },
              ),
            ]
        ),
        GoRoute(
          name: 'Ajuda',
          path: '/help',
          builder: (BuildContext context, GoRouterState state) => FAQWebPage(),
        ),
        GoRoute(
          name: 'Sobre nós',
          path: '/about/us',
          builder: (BuildContext context, GoRouterState state) =>
              UniverseInfoWeb(),
        ),
        GoRoute(
            name: 'Área Pessoal',
            path: '/personal',
            builder: (BuildContext context, GoRouterState state) =>
                PageNotFound(),
            routes: [
              GoRoute(
                path: 'main',
                builder: (BuildContext context, GoRouterState state) =>
                    PersonalPageWeb(i: 0,),
                /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
              ),
              GoRoute(
                  path: 'profile',
                  builder: (BuildContext context, GoRouterState state) =>
                      PersonalPageWeb(i: 1,),
                  /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  },*/
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (BuildContext context, GoRouterState state) =>
                          PersonalPageWeb(i: 1,),
                      /*redirect: (BuildContext context, GoRouterState state) {
                        if (!Authentication.userIsLoggedIn) {
                          return '/home';
                        }
                      },*/
                    ),
                  ]
              ),
              GoRoute(
                path: 'calendar',
                builder: (BuildContext context, GoRouterState state) =>
                    PersonalPageWeb(i: 3,),
                /*redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
              ),
              GoRoute(
                path: 'messages',
                builder: (BuildContext context, GoRouterState state) =>
                    PersonalPageWeb(i: 4,),
                /*redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
              ),
            ]
        ),
        GoRoute(
          path: '/report',
          builder: (BuildContext context, GoRouterState state) =>
              PersonalPageWeb(i: 2,),
          /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
        ),
      ]
  );
}