import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    var response = await http.post(
      Uri.parse('http://api.wasabi-labs.com/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'phone_number': _phoneController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      var token = json.decode(response.body)['token'];
      print('JWT Token: $token');
      // JWT 토큰을 다루는 로직을 여기에 추가하세요.
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid phone number or password. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  bool get isFormValid =>
      _phoneController.text.length >= 11 &&
      _passwordController.text.length >= 6;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Please enter your phone number and password",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              onPressed: isFormValid
                  ? () {
                      // Perform login logic
                      print(
                          'Logging in with phone ${_phoneController.text} and password ${_passwordController.text}');
                    }
                  : () {
                      Fluttertoast.showToast(
                        msg: 'Please fill in all fields',
                        backgroundColor: Colors.orange,
                        webBgColor: '#FFA500',
                        webPosition: "center",
                        textColor: Colors.white,
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
