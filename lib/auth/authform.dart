import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Authform extends StatefulWidget {
  const Authform({super.key});

  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey=GlobalKey<FormState>();
  var _email='';
  var _password='';
  var _username='';
  bool isLoginpage=false;
  startauthentication(){
    final validity=_formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity){
      _formkey.currentState!.save();
      submitform(_email,_password,_username);
    }
  }
  submitform(String email,String password,String username)async{
    final auth =FirebaseAuth.instance;
    var authResult;
    try{
      if(isLoginpage){
        authResult=await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else{
        authResult=await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid = authResult.user.uid;
        await FirebaseFirestore
            .instance.collection('users')
            .doc(uid)
            .set({'username':username,'email':email});
      }}
      catch(err){
        print(err);
      }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children:[
          Container(
            padding: EdgeInsets.only(left: 10,right:10,top: 10),
            child: Form(
              key: _formkey,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLoginpage)
                    TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('username'),
                    validator: (value){
                      if(value!.isEmpty){
                        return'Incorrect Username';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _username = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide()),
                        labelText: "Enter Username",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (value){
                      if(value!.isEmpty|| !value.contains('@')){
                        return'Incorrect email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _email = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide()),
                      labelText: "Enter Email",
                      labelStyle: GoogleFonts.roboto()),
                      ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty){
                        return'Incorrect password';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _password = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide()),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        startauthentication();
                      },
                      child: isLoginpage?
                      Text('Login',
                      style: GoogleFonts.roboto(fontSize: 16))
                          :Text('Signup',
                      style: GoogleFonts.roboto(fontSize: 16),),

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginpage=!isLoginpage;
                        });
                      },
                      child: isLoginpage
                        ? Text('Not a member?')
                          :Text('Already a Member')
                      
                    ),
                  )


                ],
                    ),
                  ),

              ) ,
   ], )
    );

  }
}
