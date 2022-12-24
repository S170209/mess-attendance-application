import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mess_application/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ComplaintsScreen extends StatefulWidget {
  // const ComplaintsScreen({Key? key}) : super(key: key);
  static const routeName = '/Complaints';

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  var _compTitle = "";
  var _compDesc = "";
   void _trySubmit(BuildContext ctx) async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      print("Title: $_compTitle");
      print("Password: $_compDesc");
       String date = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
    final _auth = FirebaseAuth.instance;
    var test = "$date ${_auth.currentUser?.email?.substring(0, 7)}";
    FirebaseFirestore.instance
        .collection('complaint')
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
        await FirebaseFirestore.instance.collection("complaint").doc(test).set({
          "title":_compTitle,
          "description":_compDesc,
        });
         const snackBar = SnackBar(
          content: Text('FeedBack Posted Successfully!'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

        
      }
      Navigator.of(ctx).pushNamed(ComplaintsScreen.routeName);
    });
    }
  }
  @override
  Widget build(BuildContext context) {
    print(Navigator.of(context));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 246, 244, 244)),
        backgroundColor: Color(0xFF2661FA),
        title: Text('Post Complaints'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 246, 244, 244),
        ),
      ),
      drawer: AppDrawer(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30,left:40,right: 40 ),
              child: TextFormField(
                key: ValueKey('title'),
                decoration: InputDecoration(labelText: "Complaint Title"),
                textInputAction: TextInputAction.next,
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_passwordFocusNode);
                // },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is requird';
                  }
                  return null;
                },
                onSaved: (value) {
                  _compTitle = value!;
                },
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                key: ValueKey('description'),
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                // focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'description is requird';
                  }
                  if (value.length < 8) {
                    return 'Should be at least 8 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _compDesc = value!;
                },
                onFieldSubmitted: (_){
                  _trySubmit(context);
                },
                // obscureText: true,
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  _trySubmit(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                     "SUBMIT",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
