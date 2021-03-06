import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/post_api_service.dart';
import 'package:mobile/screens/screen_profile.dart';
import 'package:mobile/screens/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utils/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:google_fonts/google_fonts.dart';


class Routes {
  Routes(){
    _setupLogging();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      if (kReleaseMode)
        exit(1);
    };
      runApp(Application());

    }
  }


void _setupLogging(){
  Logger.root.level  = Level.ALL;
  Logger.root.onRecord.listen((rec){
    print('${rec.level.name}: ${rec.time} : ${rec.message}');
  });
}
    


class Application extends StatefulWidget{
  @override
  _ApplicationState createState()=> _ApplicationState();

  static _ApplicationState? of(BuildContext context) => context.findAncestorStateOfType<_ApplicationState>();
}

class _ApplicationState extends State<Application>{
  // ThemeMode _themeMode = ThemeMode.system;
  ThemeMode _themeMode = ThemeMode.light;
  final routes = <String, WidgetBuilder>{
      '/home': (BuildContext context) => HomeScreen(),
      '/login': (BuildContext context) => LoginScreen(),
      '/profile': (BuildContext context) => ProfileScreen(),
      '/help': (BuildContext context) => HelpScreen(),
      '/contacts': (BuildContext context) => ContactsScreen(),
      '/consultations':(BuildContext context) => HomeScreen(),

    };

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

    
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Provider(
      create:(_) => PostApiService.create() ,
      dispose: (_, PostApiService service) => service.client.dispose(),
      child:  MaterialApp(
            navigatorKey: NavigationService.instance.navigationKey,
            theme: ThemeData(
                fontFamily: 'FiraSans',
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
                textTheme: GoogleFonts.firaSansTextTheme(textTheme).copyWith(
                  headline1: GoogleFonts.firaSans(textStyle: textTheme.headline1),
                  bodyText2: GoogleFonts.firaSans(textStyle: textTheme.bodyText2),
                  bodyText1: GoogleFonts.firaSans(textStyle: textTheme.bodyText1),
                )
            ),
            darkTheme: ThemeData.dark(),
            themeMode: _themeMode,
            debugShowCheckedModeBanner: false,
            routes: routes,
            title: '',
            home: SplashScreen(),
          )

    );
  }
  
}