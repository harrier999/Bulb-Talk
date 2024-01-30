import 'package:bulbtalk/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.orange,
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
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Let's talk with BulbTalk",
                      style: TextStyle(
                        color: Colors.white,
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.orange[800],
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Get.to(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Text("Sign up",
                        style: TextStyle(color: Colors.orange[800])),
                  ),
                ),
              ),
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                  TextButton(
                    onPressed: () => Get.to(
                      () => LoginPage(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Text("Login",
                        style: TextStyle(color: Colors.orange[900])),
                  ),
                ],
              ))
            ],
          ),
        ),
      );
}
