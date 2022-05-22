

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login() : super();

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  String name="";
 late String email;
 late  String phoneno;
  late String password;
final FirebaseAuth auth =FirebaseAuth.instance;
DatabaseReference reference=FirebaseDatabase.instance.reference().child("user");
  bool obscuretext=true;
  bool loginclicked=false;
  final formkey=GlobalKey<FormState>();
  void createnewUser() async{

    final FormState? formState=  formkey.currentState;
    if(formState!.validate()){
      formState.save();
      try {
         await auth
            .createUserWithEmailAndPassword(email: email, password: password);
         reference.child(auth.currentUser!.uid).child("name").set(name);
         reference.child(auth.currentUser!.uid).child("email").set(email);
         reference.child(auth.currentUser!.uid).child("mobile").set(phoneno);
         Navigator.pushReplacementNamed(context, "/my");

      }
      catch(e){
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,

      child: Form(
        key: formkey,

        child: Column(

          children: [
              Image.asset("lib/assets/electronics-recycling.jpeg",fit: BoxFit.fill,),

            Text(
              "Welcome $name",
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.white
              ),

            ),

            Text(
              "Sign in",
              textScaleFactor: 1.2,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(

                onChanged: (changed){
                  name=changed;
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return " invalid name";
                  }
                  else {
                    return null;
                  }
                },

                decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Enter Name"
                ),
              ),

            ),

            SizedBox(
              height: 10,

            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(

                onChanged: (changed){
                  phoneno=changed ;
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty||value.length<10) {
                    return " invalid number";
                  }
                  else {
                    return null;
                  }
                },

                decoration: InputDecoration(
                    hintText: "Mobile number",
                    labelText: "Enter here"
                ),
              ),

            ),

            SizedBox(
              height: 10,

            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                onChanged: (changed){
                   email=changed;
                  setState(() {});
                },
    validator: (value) {
        if (value!.isEmpty) {
          return " Email required!";
        }
        else if(!EmailValidator.validate(email)){
return "invalid email";
        }
        else {
          return null;
        }
    },

    decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Enter Email"
                ),
              ),

            ),

            SizedBox(
              height: 10,

            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                obscureText: obscuretext,
onChanged: (changed){
    password=changed;
    setState(() {
    });
},
                validator: (value){
                  if(value==null){
                    return " invalid password";
                  }
                  else {
                    if(value.length<6){
                    return "password too short";
                  }
                  else {
                    return null;
                  }
                  }
                },
                decoration: InputDecoration(
                    hintText: "Password",

                suffixIcon: GestureDetector(
  onTap: (){
    setState(() {
      obscuretext=!obscuretext;
    });
    FocusScope.of(context).unfocus();
  },
                  child: Icon(Icons.visibility,color: Colors.white,),

),
                    labelText: "Enter Password"
                ),

              ),
            ),
            SizedBox(
              height: 10,

            ),
            ElevatedButton(

                onPressed:()  {

                  setState(() {
                    loginclicked=true;
                  });
                  if(formkey.currentState!.validate()){
                    createnewUser();
                }

                },

                child: Text("Sign in",textScaleFactor: 1.5,)),
            SizedBox(height: 10,),
            loginclicked?CircularProgressIndicator(color: Colors.white,):Container(),

          ],
        ),
      )



    );
  }
}



