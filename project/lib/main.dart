import 'dart:async';

import 'package:UniVerse/components/web/500_web.dart';
import 'package:UniVerse/events_screen/events_web.dart';
import 'package:UniVerse/find_screen/services_screen/info_web.dart';
import 'package:UniVerse/info_screen//universe_info_web.dart';
import 'package:UniVerse/services/firebase_messaging_service.dart';
import 'package:UniVerse/services/notification_service.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/news_screen/news_web.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'components/web/not_found.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'faq_screen/faq_web.dart';
import 'find_screen/find_page_web.dart';
import 'main_screen/app/homepage_app.dart';
import 'main_screen/homepage_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:UniVerse/utils/route.dart';

import 'news_screen/news_web_detail_screen.dart';

Future main() async{
  //setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    var data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if(data.size.shortestSide<600) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    }
  }
  /*await Hive.initFlutter();
  if(!Hive.isBoxOpen('cache')) {
    await Hive.openBox('cache');
  }*/
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(FirebaseAuth.instance.currentUser!=null) {
    Authentication.userIsLoggedIn = true;
    String token = await Authentication.getTokenID();
    Authentication.role = JwtDecoder.decode(token)['role'];
    Authentication.assignUserFriendlyText();
  }
  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<FirebaseMessagingService>(
          create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    checkNotifications();
  }

  initializeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false)
        .initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotificaitons();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
      return MaterialApp.router(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: Routing.router,
      ).animate().fadeIn(duration: 500.ms);
    } else {
      return MaterialApp(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppHomePage(),
      );
    }
  }
}