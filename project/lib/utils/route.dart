import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/find_screen/find_test.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/find_screen/organizations_screen/organizations_info_web.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/tester/tester.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:UniVerse/utils/news/article_data.dart';

import '../components/web/not_found.dart';
import '../components/web/500_web.dart';
import '../events_screen/events_web.dart';
import '../events_screen/events_web_detail_screen.dart';
import '../faq_screen/faq_web.dart';
import '../find_screen/find_page_web.dart';
import '../find_screen/services_screen/info_web.dart';
import '../info_screen/universe_info_web.dart';
import '../main_screen/homepage_web.dart';
import '../news_screen/news_web.dart';
import '../news_screen/news_web_detail_screen.dart';
import '../personal_page_screen/web/personal_page_web.dart';
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
            builder: (BuildContext context, GoRouterState state) => FindWebPage(rightSide: RightSide()),
            routes: [
              GoRoute(
              path: 'services/:id',
              builder: (BuildContext context, GoRouterState state) {
                var id = state.pathParameters['id'];
                final found = services.where((element) => element.keys.first==id);
                if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first, image: AssetImage("assets/images/welcome_photo.jpg"),));
              },
            ),
              GoRoute(
                path: 'departments/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = departments.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first, image: AssetImage("assets/images/welcome_photo.jpg"),));
                },
              ),
              GoRoute(
                path: 'buildings/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = buildings.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first, image: AssetImage("assets/images/welcome_photo.jpg"),));
                },
              ),
              GoRoute(
                path: 'restaurants/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = restaurants.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first, image: AssetImage("assets/images/welcome_photo.jpg"),));
                },
              ),
              GoRoute(
                path: 'organizations/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = organizations.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: OrganizationsInfoWeb(id: found.first.keys.first, data: found.first.values.first));
                },
              ),
              /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
            ]
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
                    Article.fetchNews(1, Article.cursor, {'id': id!});
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
                    Event.fetchEvents(1, 0, {'id': id!});
                    if(Event.events.isEmpty)
                      return PageNotFound();
                    else data = Event.events[0];
                  }
                  return EventsDetailScreenWeb(id: id.toString(), data: data,);
                },
              ),
              GoRoute(
                path: 'submit',
                builder: (BuildContext context, GoRouterState state) =>
                    PersonalPageWeb(i: 4,),
                /* redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
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
          path: '/map',
          builder: (BuildContext context, GoRouterState state) =>
              MapPage(),
        ),
        GoRoute(
            name: 'Área Pessoal',
            path: '/personal',
            builder: (BuildContext context, GoRouterState state) =>
                PersonalPageWeb(i: 0,),
            routes: [
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
            ]
        ),
        GoRoute(
          path: '/report',
          builder: (BuildContext context, GoRouterState state) =>
              PersonalPageWeb(i: 2,),
          /*redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn) {
                      return '/home';
                    }
                  }*/
        ),
      ]
  );
}