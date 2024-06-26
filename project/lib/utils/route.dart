import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/find_screen/info_with_list_web.dart';
import 'package:UniVerse/find_screen/organizations_screen/organizations_info_web.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/tester/tester.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:UniVerse/utils/user/user_data.dart';
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
import '../profile_screen/profile_page_app.dart';
import '../profile_screen/user_list.dart';
import 'events/event_data.dart';

class Routing {
  static GoRouter router = GoRouter(
      errorBuilder: (BuildContext context, GoRouterState state) =>
          PageNotFound(),
      initialLocation: '/home',
      routes: [
        // TODO ONLY FOR TESTING
        /*GoRoute(
          path: '/userlist',
          builder: (BuildContext context, GoRouterState state) => UserListPage(),
        ),*/
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
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first[0], link: found.first.values.first[1], id: found.first.keys.first, toShowMap: true, image: AssetImage("assets/images/photo_3.jpg"),));
              },
            ),
              GoRoute(
                path: 'departments/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = departments.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first[0], link:found.first.values.first[1], id: found.first.keys.first, toShowMap: true, image: AssetImage("assets/images/photo_7.jpg"),));
                },
              ),
              GoRoute(
                path: 'buildings/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = buildings.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  final divisions = buildingsWithDivisions.where((element) => element.keys.first==id).first.values.first;
                  return FindWebPage(rightSide: InfoWithListWeb(name: found.first.values.first, id:found.first.keys.first, divisions: divisions, image: AssetImage("assets/images/photo_4.jpg"),));
                },
              ),
              GoRoute(
                path: 'restaurants/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = restaurants.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: InfoWeb(name: found.first.values.first, toShowMap:true, id: found.first.keys.first, image: AssetImage("assets/images/photo_6.jpg"),));
                },
              ),
              GoRoute(
                path: 'organizations/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = organizations.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide: OrganizationsInfoWeb(id: found.first.keys.first, info:found.first.values.first,));
                },
              ),
              GoRoute(
                path: 'agencies/:id',
                builder: (BuildContext context, GoRouterState state) {
                  var id = state.pathParameters['id'];
                  final found = fctAgencies.where((element) => element.keys.first==id);
                  if(found.isEmpty)
                    return PageNotFound();
                  else return FindWebPage(rightSide:InfoWeb(name: found.first.values.first[0], toShowMap:false, id: found.first.keys.first, link: found.first.values.first[1], image: AssetImage("assets/images/photo_1.jpg"),));
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
                    Article.fetchNews(1, "EMPTY", {'id': id!});
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
                    Event.fetchEvents(1, "EMPTY", {'id': id!});
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
                redirect: (BuildContext context, GoRouterState state) {
                  if(!Authentication.userIsLoggedIn){
                    print(Authentication.role);
                    if (Authentication.role!='T' || Authentication.role!='W' || Authentication.role != 'A') {
                      return '/home';
                    }
                    return '/home';
                  }
                  }
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
                PersonalPageWeb(i: 0,),
            redirect: (BuildContext context, GoRouterState state) {
              if (!Authentication.userIsLoggedIn) {
                return '/home';
              }
            },
            routes: [
              GoRoute(
                  path: 'profile',
                  builder: (BuildContext context, GoRouterState state) =>
                      PersonalPageWeb(i: 1,),
                  redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn || !UniverseUser.isVerified()) {
                      return '/home';
                    }
                  },
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (BuildContext context, GoRouterState state) =>
                          PersonalPageWeb(i: 1,),
                      redirect: (BuildContext context, GoRouterState state) {
                        if (!Authentication.userIsLoggedIn || !UniverseUser.isVerified()) {
                          return '/home';
                        }
                      },
                    ),
                  ]
              ),
              /*GoRoute(
                path: 'calendar',
                builder: (BuildContext context, GoRouterState state) =>
                    PersonalPageWeb(i: 3,),
                redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn || !UniverseUser.isVerified()) {
                      return '/home';
                    }
                  }
              ),*/
            ]
        ),
        GoRoute(
          path: '/report',
          builder: (BuildContext context, GoRouterState state) =>
              PersonalPageWeb(i: 2,),
          redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn || !UniverseUser.isVerified()) {
                      return '/home';
                    }
                  }
        ),
        GoRoute(
          path: '/feedback',
          builder: (BuildContext context, GoRouterState state) =>
              PersonalPageWeb(i: 5,),
          redirect: (BuildContext context, GoRouterState state) {
                    if (!Authentication.userIsLoggedIn || !UniverseUser.isVerified()) {
                      return '/home';
                    }
                  }
        ),
      ]
  );
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}