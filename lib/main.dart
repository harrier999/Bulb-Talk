import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'beforeLogin/FirstPage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        title: "Bulb Talk",
        home: FirstPage(),
      );
}
