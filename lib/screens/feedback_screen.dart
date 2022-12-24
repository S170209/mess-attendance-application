import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends StatefulWidget {
  // const feedbackScreen({Key? key}) : super(key: key);
  static const routename = '/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double q1rating = 0;
  double q2rating = 0;
  double q3rating = 0;
  double q4rating = 0;
  double q5rating = 0;
  final q6 = TextEditingController();
  @override
  void dispose() {
    q6.dispose();
    super.dispose();
  }

  void submitRating(BuildContext ctx){
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    final _auth = FirebaseAuth.instance;
    var test = "$date ${_auth.currentUser?.email?.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('feedback')
        .doc(test)
        .get()
        .then((val) async {
      if (val.exists) {
        print("already posted");
        const snackBar = SnackBar(
          content: Text('Already FeedBack Posted!'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      } else {
        // FirebaseFirestore.instance.collection("interest").doc(test).set({
        //   "status": value2,
        // });
        await FirebaseFirestore.instance.collection("feedback").doc(test).set({
          "question1": q1rating,
          "question2": q2rating,
          "question3": q3rating,
          "question4": q4rating,
          "question5": q5rating,
          "Query": q6.text,
        });
         const snackBar = SnackBar(
          content: Text('FeedBack Posted Successfully!'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

        
      }
      Navigator.of(ctx).pushNamed(FeedbackScreen.routename);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 246, 244, 244)),
        backgroundColor: Color(0xFF2661FA),
        title: Text('Feedback'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 246, 244, 244),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Quality of the food as per menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          q1rating = rating;
                        });
                      },
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. Quality of the food as per menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          q2rating = rating;
                        });
                      },
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. Maintenance of the Dinning Hall',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          q3rating = rating;
                        });
                      },
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4. Behaviour of the Barriers in a Hall',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          q4rating = rating;
                        });
                      },
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '5. As per the menu Followed or not',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          q5rating = rating;
                        });
                      },
                    )
                  ]),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              '6. Any other feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ]),
        Row(children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: q6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Send in a formal format',
                ),
              ),
            ),
          ),
        ]),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30)),
            RaisedButton(
              onPressed: () {
                submitRating(context);
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
                  "Submit",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )
      ])),
    );
  }
}
