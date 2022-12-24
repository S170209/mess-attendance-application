import 'package:mess_application/screens/check_attendance.dart';
import 'package:mess_application/screens/complaints_screen.dart';
import 'package:mess_application/screens/menu_screen.dart';
import 'package:mess_application/screens/menunew_screen.dart';
import 'package:mess_application/screens/profile_screen.dart';

import './screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/feedback_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initilization of Firebase app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAs_Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: feedback_screen(),
       home: StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (ctx, userSnapshot) {
             if (userSnapshot.hasData) {
               return CheckAttendance();
             }
             return AuthScreen();
           }),
       routes: {
         AuthScreen.routeName: (ctx) => AuthScreen(),
         CheckAttendance.routeName: (ctx) => CheckAttendance(),
         MenuScreen.routeName: (ctx) => MenuScreen(),
         ProfileScreen.routeName: (ctx) => ProfileScreen(),
         ComplaintsScreen.routeName: (ctx) => ComplaintsScreen(),
         FeedbackScreen.routename:(ctx)=>FeedbackScreen(),
         MenunewScreen.routeName:(ctx)=>MenunewScreen(),
       },
    );
  }
}
