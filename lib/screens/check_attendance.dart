import 'package:flutter/material.dart';
import 'package:mess_application/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';

class CheckAttendance extends StatefulWidget {
  // const Home({Key key}) : super(key: key);
  static const routeName = '/checkattendance';

  @override
  State<CheckAttendance> createState() => _CheckAttendanceState();
}

class _CheckAttendanceState extends State<CheckAttendance> {
  // String selectedDate = DateFormat.E().format(DateTime.now());
  String selectedDate =
      DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = DateFormat("dd-MM-yyyy").format(pickedDate).toString();
        show();
      });
    });
  }

  final List titles = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  final List status = ["Not Attended", "Not Attended", "Not Attended", "Not Attended"];

  @override
  void initState() {
    show();
    super.initState();
  }

  void show() async {
    final _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final uid = _auth.currentUser?.uid;
    final user = firebaseFirestore
        .collection('users')
        .doc(uid)
        .get(const GetOptions(source: Source.cache));
    String breakfast = selectedDate + ' ' + "Breakfast";
    String Lunch = selectedDate + ' ' + "Lunch";
    String Dinner = selectedDate + ' ' + "Dinner";
    String snacks = selectedDate + ' ' + "Snacks";

    //Breakfast Logic
    // ignore: deprecated_member_use
    final db = FirebaseDatabase.instance.reference().child(breakfast);
    db.once().then((snapshot) {
      if (snapshot.snapshot.exists) {
        dynamic values = snapshot.snapshot.value;
        values.forEach((key, values) {
          if (key == _auth.currentUser?.email?.substring(0, 7)) {
            setState(() {
              status[0] = values["exit_time"];
            });
          } 
        });
      } else {
        setState(() {
          status[0] = "Not Attended";
        });
      }
    });
    //Lunch Logic
    // ignore: deprecated_member_use
    final db1 = FirebaseDatabase.instance.reference().child(Lunch);
    db1.once().then((snapshot) {
      if (snapshot.snapshot.exists) {
        dynamic values = snapshot.snapshot.value;
        values.forEach((key, values) {
          if (key == _auth.currentUser?.email?.substring(0, 7)) {
            setState(() {
              status[1] = values["exit_time"];
            });
          }
        });
      } else {
        setState(() {
          status[1] = "Not Attended";
        });
      }
    });
    //Snacks Logic
    // ignore: deprecated_member_use
    final db2 = FirebaseDatabase.instance.reference().child(snacks);
    db2.once().then((snapshot) {
      if (snapshot.snapshot.exists) {
        dynamic values = snapshot.snapshot.value;
        values.forEach((key, values) {
          if (key == _auth.currentUser?.email?.substring(0, 7)) {
            setState(() {
              status[2] = values["exit_time"];
            });
          }
        });
      } else {
        setState(() {
          status[2] = "Not Attended";
        });
      }
    });

    // Dinner logic
    // ignore: deprecated_member_use
    final db3 = FirebaseDatabase.instance.reference().child(Dinner);
    db3.once().then((snapshot) {
      if (snapshot.snapshot.exists) {
        dynamic values = snapshot.snapshot.value;
        values.forEach((key, values) {
          if (key == _auth.currentUser?.email?.substring(0, 7)) {
            setState(() {
              status[3] = values["exit_time"];
            });
          }
        });
      } else {
        setState(() {
          status[3] = "Not Attended";
        });
      }
    });
  }

  Future<void> refreshshow() async {
    show();
  }

  @override
  Widget build(BuildContext context) {
    final mediaObject = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Check Attendance'),
    );
    return RefreshIndicator(
      onRefresh: refreshshow,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromARGB(255, 246, 244, 244)),
            backgroundColor: Color(0xFF2661FA),
            title: Text('Check Atendance'),
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 246, 244, 244),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.calendar_month_outlined),
                onPressed: _presentDatePicker,
                // color:  Color.fromARGB(255, 255, 136, 34),
              )
            ],
          ),
          drawer: AppDrawer(),
          body: SingleChildScrollView(
            child: Container(
              // height: (mediaObject.size.height -
              //         appBar.preferredSize.height -
              //         mediaObject.padding.top) *
              //     0.40,
              child: Column(
                children: [
                  Container(
                    // color: Color.fromARGB(255, 225, 243, 242),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Special Items',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 57, 55, 55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ImageSlideshow(
                                indicatorColor: Colors.blue,
                                onPageChanged: (value) {
                                  debugPrint('Page changed: $value');
                                },
                                autoPlayInterval: 3000,
                                isLoop: true,
                                children: [
                                  Image.asset(
                                    'assets/images/special_items_slideshow/biryani.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/special_items_slideshow/dosa.jfif',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/special_items_slideshow/pulihora.jfif',
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    'assets/images/special_items_slideshow/chicken.webp',
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: (mediaObject.size.height -
                              appBar.preferredSize.height -
                              mediaObject.padding.top) *
                          0.70,
                      // color: Color.fromARGB(255, 225, 243, 242),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Your Attendance',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 57, 55, 55),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (ctx, i) => Container(
                                  margin: EdgeInsets.all(8),
                                  child: Card(
                                    color: Color.fromARGB(255, 225, 243, 242),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text("${titles[i]}",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "${status[i]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 255, 136, 34),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "$selectedDate",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                itemCount: 4,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
