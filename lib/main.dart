import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'layout/layout.dart';
import 'modules/Entry/OnBordingEntryStates.dart';
import 'modules/sign in/sign in.dart';

bool isSignIn = FirebaseAuth.instance.currentUser != null;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  userFirstPage(){
    if (!isSignIn) {
      return OnboardingEntryMode();
    } else {
      return NavigationBottom();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            toolbarHeight: 80,
            backgroundColor: Colors.red[700],
            iconTheme: IconThemeData(
              size: 40,
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.red[700],

            selectedIconTheme: IconThemeData(
              color: Colors.white,
              size: 30,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 15,
            ),
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,

          ),
          // buttonTheme: ButtonThemeData(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(40),
          //       topRight: Radius.circular(40),
          //     ),
          //   ),
          //     buttonColor: Colors.red[700],
          // ),

        ),

        home: SafeArea(
            child:userFirstPage()
        )
    );
  }
}

