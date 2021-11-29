import '/screens/mid_screen.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 300,
              child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(MidScreen.routename, arguments: 'doctor'),
                  child: Card(
                    child: Image.asset('assets/doctor.png'),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(MidScreen.routename, arguments: 'patient'),
                child: Card(child: Image.asset('assets/images/dn.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
