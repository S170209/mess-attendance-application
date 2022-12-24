import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mess_application/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class MenunewScreen extends StatefulWidget {
  @override
  static const routeName = "/MenuScreen";
  State<MenunewScreen> createState() => _MenunewScreenState();
}

class _MenunewScreenState extends State<MenunewScreen> {
  CollectionReference messmenu =
      FirebaseFirestore.instance.collection('messmenu');
  // CollectionReference messinterest =
  //     FirebaseFirestore.instance.collection('interest');
  void statusUpdate(String date, String value1, String value2) async {
    final _auth = FirebaseAuth.instance;
    var test = "$date $value1 ${_auth.currentUser?.email?.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('interest')
        .doc(test)
        .get()
        .then((val) async {
      if (val.exists) {
        await FirebaseFirestore.instance.collection("interest").doc(test).update({
          "status": value2,
        });
      } else {
        await FirebaseFirestore.instance.collection("interest").doc(test).set({
          "status": value2,
        });
      }
      show();
    });
  }

  String date = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
  String day =
      DateFormat('EEEE').format(DateTime.now()).toString().toLowerCase();
  final List mimgs = ["bfimg", "lunchimg", "snacksimg", "dinnerimg"];
  final List mnames = ["bfname", "lunchname", "snacksname", "dinnername"];
  final List mtimes = ["bftime", "lunchtime", "snackstime", "dinnertime"];
  final List mstatusname = [
    "bfstatus",
    "lunchstatus",
    "snacksstatus",
    "dinnerstatus"
  ];
  final List mtitles = ['Breakfast', 'Lunch', 'Snacks', 'Dinner'];
  final List mstatus = ['', '', '', ''];
  void show() async {
    // breakfast
    final _auth = FirebaseAuth.instance;
    var test = "${date +" "+mstatusname[0]} ${_auth.currentUser!.email!.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('interest')
        .doc(test)
        .get()
        .then((val) {
      if (val.exists) {
        final v1 = FirebaseFirestore.instance
            .collection("interest")
            .doc(test)
            .get()
            .then((value) {
          var fields = value.data();
          setState(() {
            mstatus[0] = fields!['status'];
          });
        });
      }
    });
        // breakfast
   var test1 = "${date +" "+mstatusname[1]} ${_auth.currentUser!.email!.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('interest')
        .doc(test1)
        .get()
        .then((val) {
      if (val.exists) {
        final v1 = FirebaseFirestore.instance
            .collection("interest")
            .doc(test1)
            .get()
            .then((value) {
          var fields = value.data();
          setState(() {
            mstatus[1] = fields!['status'];
          });
        });
      }
    });
      // breakfast
    var test2 ="${date +" "+mstatusname[2]} ${_auth.currentUser!.email!.substring(0, 7)}";
    print(test);
    FirebaseFirestore.instance
        .collection('interest')
        .doc(test2)
        .get()
        .then((val) {
      if (val.exists) {
        final v1 = FirebaseFirestore.instance
            .collection("interest")
            .doc(test2)
            .get()
            .then((value) {
          var fields = value.data();
          setState(() {
            mstatus[2] = fields!['status'];
          });
        });
      }
    });
       // breakfast
    var test3 = "${date +" "+mstatusname[3]} ${_auth.currentUser!.email!.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('interest')
        .doc(test3)
        .get()
        .then((val) {
      if (val.exists) {
        final v1 = FirebaseFirestore.instance
            .collection("interest")
            .doc(test3)
            .get()
            .then((value) {
          var fields = value.data();
          setState(() {
            mstatus[3] = fields!['status'];
          });
        });
      }
    });
  }

  @override
  void initState() {
    show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // if (!snapshot.hasError) {
            //   return Center(
            //     child: Text("Menu Not Found"),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => Container(
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
                                    snapshot.data![mimgs[index]].toString(),
                                    ),
                              ),
                              title: Text(
                                mtitles[index],
                                // ignore: prefer_const_constructors
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
                                      snapshot.data![mnames[index]].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 136, 34)),
                                    ),
                                  ),
                                  Text(
                                    // '7:00PM to 8:45PM',
                                    snapshot.data![mtimes[index]].toString(),
                                    style: const TextStyle(
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
                                        mstatus[index] == "like"
                                            ? Icons.thumb_up
                                            : Icons.thumb_up,
                                        color: mstatus[index] == "like"
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        statusUpdate(
                                            date, mstatusname[index], "like");
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          mstatus[index] == "dislike"
                                              ? Icons
                                                  .thumb_down
                                              : Icons.thumb_down,
                                          color: mstatus[index] == "dislike"
                                              ? Colors.orange
                                              : Colors.black),
                                      onPressed: () {
                                        statusUpdate(date, mstatusname[index],
                                            "dislike");
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
                    itemCount: 4,
                  )
                ],
              ),
            );
          }),
    );
  }
}
