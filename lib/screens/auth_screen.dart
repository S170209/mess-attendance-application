import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/Home';
  // const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthFrom(String email, String password, String username,
      String dhno, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        print("login executed");
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _scaffoldKey.currentState!.showSnackBar(new SnackBar(
          content: new Text("SignIn Successfully!"),
          backgroundColor: Colors.green,
        ));
        setState(() {
          _isLoading = false;
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'studentId': email.substring(0, 7),
          'email': email,
          'username': username,
          'dhno': dhno,
        });
        setState(() {
          _isLoading = false;
        });
      }
    } on PlatformException catch (err) {
      var message = "An error occured, please check your credentials";
      if (err.message != null) {
        message = err.message!;
      }
     _scaffoldKey.currentState!.showSnackBar(new SnackBar(
        content: new Text(message),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (err) {
      var d = "something went worng!";
      if (err.code == 'user-not-found') {
        d = 'No user found for that email.';
      } else if (err.code == 'wrong-password') {
        d = 'Wrong password provided for that user.';
      }
      print(d);
      _scaffoldKey.currentState!.showSnackBar(new SnackBar(
        content: new Text(d),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
        _scaffoldKey.currentState!.showSnackBar(new SnackBar(
        content: new Text("something wrong!"),
        backgroundColor: Colors.red,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please wait"),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : AuthForm(_submitAuthFrom, _isLoading));
  }
}
