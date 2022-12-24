import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess_application/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MenuScreen extends StatefulWidget {
  @override
  static const routeName = "/MenuScreen";
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  CollectionReference messmenu =
      FirebaseFirestore.instance.collection('messmenu');
  var bfstatus = "pending";
  var lunchstatus = "pending";
  var snacksstatus = "pending";
  var dinnerstatus = "pending";
  void statusUpdate(String value1, String value2) {
    if (value1 == "bfstatus") {
      if (value2 == "like") {
        // bfstatus = "like";
      final user = FirebaseAuth.instance.currentUser;
         FirebaseFirestore.instance
            .collection('MenuInterests')
            .doc(user!.uid)
            .update({
              "breakfastStatus":"like"
            }).then((result){
              print("new USer true");
            }).catchError((onError){
             print("onError");
            });
      } else if (bfstatus == value2) {
        bfstatus = "pending";
      } else {
        bfstatus = "dislike";
      }
      setState(() {
        bfstatus = bfstatus;
      });
    }
    if (value1 == "lunchstatus") {
      if (value2 == "like") {
        lunchstatus = "like";
      } else if (lunchstatus == value2) {
        lunchstatus = "pending";
      } else {
        lunchstatus = "dislike";
      }
      setState(() {
        lunchstatus = lunchstatus;
      });
    }
    if (value1 == "snacksstatus") {
      if (value2 == "like") {
        snacksstatus = "like";
      } else if (snacksstatus == value2) {
        snacksstatus = "pending";
      } else {
        snacksstatus = "dislike";
      }
      setState(() {
        snacksstatus = snacksstatus;
      });
    }
    if (value1 == "dinnerstatus") {
      if (value2 == "like") {
        dinnerstatus = "like";
      } else if (dinnerstatus == value2) {
        dinnerstatus = "pending";
      } else {
        dinnerstatus = "dislike";
      }
      setState(() {
        dinnerstatus = dinnerstatus;
      });
    }
  }

  String day =
      DateFormat('EEEE').format(DateTime.now()).toString().toLowerCase();

  @override
  Widget build(BuildContext context) {
    print(Navigator.of(context));
    final mediaObject = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Today menu'),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF2661FA),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 246, 244, 244)),
          title: Text('Today menu'),
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 246, 244, 244),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: messmenu.doc(day).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            // if (!snapshot.hasError) {
            //   return Center(
            //     child: Text("Menu Not Found"),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: (mediaObject.size.height -
                            appBar.preferredSize.height -
                            mediaObject.padding.top) *
                        0.20,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  // 'assets/images/today_menu/chapati.jfif'
                                  "${snapshot.data!['bfimg'].toString()}"),
                            ),
                            title: Text(
                              "Breakfast",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    // 'Chapati, Alu Curry, Egg',
                                    "${snapshot.data!['bfname'].toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 136, 34)),
                                  ),
                                ),
                                Text(
                                  // '7:00PM to 8:45PM',
                                  "${snapshot.data!['bftime'].toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 130, 128, 128)),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      bfstatus == "pending"
                                          ? Icons.thumb_up_off_alt_outlined
                                          : Icons.thumb_up,
                                      color: bfstatus == "like"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("bfstatus", "like");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        bfstatus == "pending"
                                            ? Icons.thumb_down_off_alt_outlined
                                            : Icons.thumb_down,
                                        color: bfstatus == "dislike"
                                            ? Colors.blue
                                            : Colors.black),
                                    onPressed: () {
                                      statusUpdate("bfstatus", "dislike");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      elevation: 5,
                    ),
                  ),
                  Container(
                    height: (mediaObject.size.height -
                            appBar.preferredSize.height -
                            mediaObject.padding.top) *
                        0.20,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                // 'assets/images/today_menu/biryani.jpg'
                                "${snapshot.data!['lunchimg'].toString()}",
                              ),
                            ),
                            title: Text(
                              "Lunch",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    // 'Rice,Brinjal,Sambar,Curd',
                                    "${snapshot.data!['lunchname'].toString()}",

                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 136, 34)),
                                  ),
                                ),
                                Text(
                                  // '12:30PM to 2:00PM',
                                  "${snapshot.data!['lunchtime'].toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 130, 128, 128)),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      lunchstatus == "pending"
                                          ? Icons.thumb_up_off_alt_outlined
                                          : Icons.thumb_up,
                                      color: lunchstatus == "like"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("lunchstatus", "like");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      lunchstatus == "pending"
                                          ? Icons.thumb_down_off_alt_outlined
                                          : Icons.thumb_down,
                                      color: lunchstatus == "dislike"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("lunchstatus", "dislike");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      elevation: 5,
                    ),
                  ),
                  Container(
                    height: (mediaObject.size.height -
                            appBar.preferredSize.height -
                            mediaObject.padding.top) *
                        0.20,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                // 'assets/images/today_menu/potato_fry.jfif'
                                "${snapshot.data!['snacksimg'].toString()}",
                              ),
                            ),
                            title: Text(
                              "Snacks",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    // 'Pakodi,Tea',
                                    "${snapshot.data!['snacksname'].toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 136, 34)),
                                  ),
                                ),
                                Text(
                                  // '5:00PM to 5:45AM',
                                  "${snapshot.data!['snackstime'].toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 130, 128, 128)),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      snacksstatus == "pending"
                                          ? Icons.thumb_up_off_alt_outlined
                                          : Icons.thumb_up,
                                      color: snacksstatus == "like"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("snacksstatus", "like");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      snacksstatus == "pending"
                                          ? Icons.thumb_down_off_alt_outlined
                                          : Icons.thumb_down,
                                      color: snacksstatus == "dislike"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("snacksstatus", "dislike");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      elevation: 5,
                    ),
                  ),
                  Container(
                    height: (mediaObject.size.height -
                            appBar.preferredSize.height -
                            mediaObject.padding.top) *
                        0.20,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                // 'assets/images/today_menu/potato_fry.jfif'
                                "${snapshot.data!['dinnerimg'].toString()}",
                              ),
                            ),
                            title: Text(
                              "Dinner",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    // 'Chapati, Alu curry, Banana',
                                    "${snapshot.data!['dinnername'].toString()}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 136, 34)),
                                  ),
                                ),
                                Text(
                                  // '7:00PM to 8:30PM',
                                  "${snapshot.data!['dinnertime'].toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 130, 128, 128)),
                                ),
                              ],
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      dinnerstatus == "pending"
                                          ? Icons.thumb_up_off_alt_outlined
                                          : Icons.thumb_up,
                                      color: dinnerstatus == "like"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("dinnerstatus", "like");
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      dinnerstatus == "pending"
                                          ? Icons.thumb_down_off_alt_outlined
                                          : Icons.thumb_down,
                                      color: dinnerstatus == "dislike"
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      statusUpdate("dinnerstatus", "dislike");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
