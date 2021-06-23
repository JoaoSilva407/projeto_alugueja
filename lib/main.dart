import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'pages/bem_vindo/bem_vindo_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlugueJá',
      theme: ThemeData(
        primarySwatch: azul,
        backgroundColor: quintaCor,
        accentColor: quartaCor,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: primeiraCor,
          textTheme: ButtonTextTheme.primary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BemVindoPage(),
    );
  }
}

const MaterialColor azul = const MaterialColor(
  0xff004CA3,
  const <int, Color>{
    50: Color(0xff004CA3),
    100: Color(0xff004CA3),
    200: Color(0xff004CA3),
    300: Color(0xff004CA3),
    400: Color(0xff004CA3),
    500: Color(0xff004CA3),
    600: Color(0xff004CA3),
    700: Color(0xff004CA3),
    800: Color(0xff004CA3),
    900: Color(0xff004CA3),
  },
);
