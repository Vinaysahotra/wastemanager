import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wastemanager/main.dart';
import 'package:wastemanager/pages/login.dart';

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 15),
            () {if( FirebaseAuth.instance.currentUser==null)Navigator.of(context).push(PageTransition(child: login(), type:PageTransitionType.leftToRight,ctx: context,inheritTheme: true));
        else
              Navigator.of(context).pushReplacement(PageTransition(child: MyApp(), type:PageTransitionType.fade,ctx: context,inheritTheme: true));
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Center(child: Text("E-Recycler",textScaleFactor: 2.0,style: GoogleFonts.abel(color: Colors.green,fontWeight: FontWeight.bold),)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset("lib/assets/animation.json"),
          ),


          SizedBox(height: 220,),
          Row(children: [Text("Made in India",textScaleFactor: 1.2,style: GoogleFonts.abel(color: Colors.green,fontWeight: FontWeight.bold)),SizedBox(width: 10,),Flag.fromCode(FlagsCode.IN, height: 15,width: 20,fit: BoxFit.fill,),],mainAxisAlignment: MainAxisAlignment.center,),
          
        ],
      ) ,

    );
  }
}
