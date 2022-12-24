import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mess_application/screens/auth_screen.dart';
import '../widgets/app_drawer.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth.dart';

class ProfileScreen extends StatefulWidget {
  // const Profile({Key? key}) : super(key: key);
  static const routeName = "Profile";
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double mediaObject = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 246, 244, 244)),
        backgroundColor: Color(0xFF2661FA),
        title: Text('Profile'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 246, 244, 244),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: users.doc(user!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  height: mediaObject * 0.30,
                  width: w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                        "assets/images/profile_images/profile_background.jfif"),
                    fit: BoxFit.cover,
                  )),
                  child: Column(children: [
                    SizedBox(
                      height: mediaObject * 0.14,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage:
                          AssetImage("assets/images/profile_images/rgukt.png"),
                    )
                  ]),
                ),
                SizedBox(
                  height: 1,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          top: 20, left: 8, right: 8, bottom: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 169, 165, 165)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "UserName",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${snapshot.data!['username'].toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          top: 10, left: 8, right: 8, bottom: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 169, 165, 165)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 43,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${snapshot.data!['email'].toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          top: 10, left: 8, right: 8, bottom: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 169, 165, 165)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "ID Number",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${snapshot.data!['studentId'].toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(
                          top: 10, left: 8, right: 8, bottom: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 169, 165, 165)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "DH Number",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            ":",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${snapshot.data!['dhno'].toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: RaisedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.of(context)
                                  .pushReplacementNamed(AuthScreen.routeName));

                          // await FirebaseAuth.instance.signOut().then((value) =>
                          //     Navigator.of(context).pushAndRemoveUntil(
                          //         MaterialPageRoute(
                          //             builder: (context) => AuthScreen()),
                          //         (route) => false));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: w * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 255, 136, 34),
                                Color.fromARGB(255, 255, 177, 41)
                              ])),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
