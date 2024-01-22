import 'package:bulbtalk/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'beforeLogin/firstPage.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) => GetMaterialApp(
//         home: Scaffold(
//           appBar: AppBar(),
//           body: LoginPage(),
//         ),
//       );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            //1
            primarySwatch: Colors.orange, //2
            accentColor: Colors.orangeAccent, //4
          ).copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: FirstPage(),
      );
}
