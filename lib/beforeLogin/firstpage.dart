import 'package:bulbtalk/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 10,
                child: Lottie.asset(
                  'assets/lottie/bulb-lottie.json',
                  repeat: false,
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      "BulbTalk",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Let's talk with BulbTalk",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Text("Sign up"),
                  ),
                ),
              ),
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Get.to(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Text("Login",
                        style: TextStyle(color: Colors.amber[900])),
                  ),
                ],
              ))
            ],
          ),
        ),
      );
}
