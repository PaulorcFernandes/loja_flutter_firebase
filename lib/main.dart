import 'package:flutter/material.dart';
import 'package:loja_flutter_firebase/screens/base/base_screen.dart';
import 'package:loja_flutter_firebase/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja Online',
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 4, 125, 141),
            scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(elevation: 0),
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
              );
            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}
