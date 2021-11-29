import 'package:shopapp/screens/patienthomepage.dart';

import '/provider/doc_auth.dart';
import '/provider/patient_auth.dart';
import '/screens/doc_auth_screen.dart';
import '/screens/dochomepage.dart';
import '/screens/patient_auth_screen.dart';
import '/screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MidScreen extends StatefulWidget {
  const MidScreen({Key? key}) : super(key: key);
  static const routename = 'midscreen';

  @override
  _MidScreenState createState() => _MidScreenState();
}

class _MidScreenState extends State<MidScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    final docauthcheck = Provider.of<DocAuth>(context);
    final patientauthcheck = Provider.of<PatientAuth>(context);
    print(arg);
    if (arg == 'doctor') {
      if (docauthcheck.isAuth) {
        return DocHomePage();
      } else {
        return FutureBuilder(
          future: docauthcheck.tryAutoLogin(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : DocAuthScreen(),
        );
      }
    } else {
      if (patientauthcheck.isAuth) {
        return PatientHomePage();
      } else {
        return FutureBuilder(
          future: patientauthcheck.tryAutoLogin(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : PatientAuthScreen(),
        );
      }
    }
  }
}

// class PatientMidScreen extends StatefulWidget {
//   const PatientMidScreen({Key? key}) : super(key: key);
//   static const routename = 'Patientmidscreen';

//   @override
//   _PatientMidScreenState createState() => _PatientMidScreenState();
// }

// class _PatientMidScreenState extends State<PatientMidScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final arg = ModalRoute.of(context)!.settings.arguments;

//     final patientAuthScreen = Provider.of<PatientAuth>(context);

//     if (arg == 'doctor') {
//       if (docauthcheck.isAuth) {
//         return DocHomePage();
//       } else {
//         return FutureBuilder(
//           future: docauthcheck.tryAutoLogin(),
//           builder: (context, snapshot) =>
//               snapshot.connectionState == ConnectionState.waiting
//                   ? SplashScreen()
//                   : DocAuthScreen(),
//         );
//       }
//     } else {
//       if (docauthcheck.isAuth) {
//         return PatientHomePage();
//       } else {
//         return FutureBuilder(
//           future: patientAuthScreen.tryAutoLogin(),
//           builder: (context, snapshot) =>
//               snapshot.connectionState == ConnectionState.waiting
//                   ? SplashScreen()
//                   : PatientAuthScreen(),
//         );
//       }
//     }
//   }
// }
