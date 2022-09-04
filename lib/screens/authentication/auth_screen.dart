
import 'package:aumet_task/screens/authentication/authentication_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget{
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoad=false;

  Future _submetForm(String email, String password , String username ,String phone, BuildContext mycontext, bool isLog )async{

    UserCredential _authResult;
    try{
      setState(() {
        _isLoad=true;
      });

      if(isLog)
      {
        _authResult= await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // to save user data

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(_authResult.user!.uid)
        //     .set({'username': username, 'password': password, "phone": phone});
      }
    }on FirebaseAuthException catch(e){
      String msg="error Occurred";
      if(e.code=='weak-password'){
        msg='password is too weak';
      }else if(e.code=='email-already-in-use'){
        msg='The account already exists for this email';
      }else if(e.code=='user-not-found'){
        msg='No user found for that email';
      }else if(e.code=='wrong-password'){
        msg='Wrong password';
      }
      Scaffold.of(mycontext).showSnackBar(SnackBar(content: Text(msg)));

      setState(() {
        _isLoad=false;
      });
    }catch(e){
      print(e);
      setState(() {
        _isLoad=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationForm(_submetForm, _isLoad),
    );
  }
}