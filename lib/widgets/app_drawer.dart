import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mess_application/screens/auth_screen.dart';
import 'package:mess_application/screens/complaints_screen.dart';
import 'package:mess_application/screens/feedback_screen.dart';
import 'package:mess_application/screens/menunew_screen.dart';
// import 'package:mess_application/screens/menunew_screen.dart';
import 'package:mess_application/screens/profile_screen.dart';
import '../screens/check_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mas_application/screens/menu_screen.dart';
// import 'package:mas_application/screens/profile_screen.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  // const AppDrawer({Key key}) : super(key: key);
  static int c = 0;
  Future<void> poping(BuildContext context) async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          backgroundColor: Color(0xFF2661FA),
          title: Text(
            'Hello Friends!',
            style: TextStyle(
                color: Color.fromARGB(255, 249, 246, 246),
                fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Check Attendance',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () {
            c = 1;
            Navigator.of(context)
                .pushReplacementNamed(CheckAttendance.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.dataset_sharp),
          title: Text('Mess Menu',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () {
            c = 1;
            Navigator.of(context).pushReplacementNamed(MenunewScreen.routeName);
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (c) => MenuScreen()),
            //     (route) => false);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.upload_file),
          title: Text('Post Complaint',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () {
            c = 1;
            Navigator.of(context)
                .pushReplacementNamed(ComplaintsScreen.routeName);
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (c) => ComplaintsScreen()),
            //     (route) => false);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text('Feedback',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(FeedbackScreen.routename);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('User Profile',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () {
            c = 1;
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (c) => ProfileScreen()),
            //     (route) => false);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17)),
          onTap: () async {
            if (c == 0) {
              FirebaseAuth.instance.signOut();
            } else {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(context,
                      AuthScreen.routeName, (Route<dynamic> route) => false));
            }
          },
        ),
      ]),
    );
  }
}
