import 'package:aumet_task/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationForm extends StatefulWidget{

  final void Function(String email, String password , String username, String phone, BuildContext mycontext, bool isLog) _submitFun;
  bool isload;

  AuthenticationForm(this._submitFun, this.isload);
  @override
  _AuthenticationFormState createState() =>_AuthenticationFormState();

}

class _AuthenticationFormState extends State<AuthenticationForm>{

  final _formKey =GlobalKey<FormState>();
  bool _isLog=true;
  String _email= "";
  String _password= "";
  String _username= "";
  String _phone="";


  void _submit(){
    final isValid =_formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      _formKey.currentState!.save();
      widget._submitFun(_email.trim(), _password.trim(), _username.trim(), _phone.trim(), context, _isLog);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child:Container(
        width: MediaQuery.of(context).size.width*0.4,
        child: Card(
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    key: ValueKey('email'),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@') ){
                        return 'please enter a valid email address';}
                      return null;
                    },
                    onSaved: (value)=>_email=value!,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  if(!_isLog)
                    TextFormField(
                      autocorrect: true,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.words,
                      key: ValueKey('username'),
                      validator: (value){
                        if(value!.isEmpty || value.length< 6){
                          return 'please enter at least 6 characters';}
                        return null;
                      },
                      onSaved: (value)=>_username=value!,
                      //keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty || value.length<8){
                        return 'password must be at least 8 characters';}
                      return null;
                    },
                    onSaved: (value)=>_password=value!,
                    //keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),
                  if(widget.isload)
                    CircularProgressIndicator(),
                  if(!widget.isload)
                    RaisedButton(
                      child: Text(_isLog?'Login':'Sign Up'),
                      onPressed :(){
                        _submit();
                      },),
                  FlatButton(
                    onPressed: (){setState(() {
                      _isLog=!_isLog;
                    });},
                    child: Text(_isLog?'Creat a new account': 'I already have an account'),
                    textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}