import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: hexToColor('#f3f3f2'),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 51,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/zvolt_icon.png',
                  )
                ],
              ),
              const SizedBox(height: 64),
              const Text('Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                style: TextStyle(color: hexToColor('#575757'), fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle:
                      TextStyle(fontSize: 14, color: hexToColor('#ababab')),
                  hintStyle:
                      TextStyle(fontSize: 18, color: hexToColor('#575757')),
                  labelText: 'Username',
                  hintText: "Username",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                style: TextStyle(color: hexToColor('#575757'), fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle:
                      TextStyle(fontSize: 14, color: hexToColor('#ababab')),
                  hintStyle:
                      TextStyle(fontSize: 18, color: hexToColor('#575757')),
                  labelText: 'Password',
                  hintText: "Password",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Primary"),
                  style: ElevatedButton.styleFrom(
                      primary: hexToColor('#2167ae'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 31),
              Text("Forgot Password?",
                  style: TextStyle(fontSize: 16, color: hexToColor('#2167ae'))),
              const SizedBox(height: 31),
              Text("Create Account",
                  style: TextStyle(fontSize: 16, color: hexToColor('#2167ae'))),
              const SizedBox(height: 67),
              Text.rich(
                TextSpan(
                  text: 'By using the App, you agree to the ',
                  style: TextStyle(fontSize: 12, color: hexToColor('#575757')),
                  children: <InlineSpan>[
                    TextSpan(
                        text: 'Terms of Use ',
                        style: TextStyle(color: hexToColor('#2167ae')),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('Terms of Use')),
                    const TextSpan(
                      text: '\n and confirm that you have read the ',
                    ),
                    TextSpan(
                        text: ' Privacy Policies.',
                        style: TextStyle(color: hexToColor('#2167ae')),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('Privacy Policies')),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      )),
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
