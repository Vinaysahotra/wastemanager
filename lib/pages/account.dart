

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastemanager/pages/login.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  DatabaseReference database=FirebaseDatabase.instance.reference();
  late String name='';
  late String address='';
  FirebaseAuth auth=FirebaseAuth.instance;
  late String filename;
  late String mobile='';
  late String filepath;
  late String image_url="";
  late  File imagefile=new File("");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      database.child("user").child(FirebaseAuth.instance.currentUser!.uid).child("name").once().then((snapshot){name=snapshot.value;setState(() {});});
    database.child("user").child(FirebaseAuth.instance.currentUser!.uid).child("mobile").once().then((snapshot){mobile=snapshot.value;setState(() {});});
      _determinePosition();
    setState(() {
        downloadImage();
    });

  }
  Future<File?> imgFromGallery() async {

    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    setState(()  {
      if(pickedimage!=null){
        imagefile=File(pickedimage.path);
        database.reference().child("user").child(FirebaseAuth.instance.currentUser!.uid).child("image").set(imagefile.path) ;
      }
      else{
        print("no image selected");
      }

    });
    setState(() {
    });
    return imagefile;
  }
  Future  downloadImage() async{

    if(database.reference().child("user").child(FirebaseAuth.instance.currentUser!.uid).child("image")!=null){
      database.reference().child("user").child(FirebaseAuth.instance.currentUser!.uid).child("image").once().then((DataSnapshot snapshot) {

        setState(() {
          image_url=snapshot.value;

        });
        image_url=snapshot.value;

      });
    }


  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position location;
    await Geolocator.getCurrentPosition().then((value)  {
      setState(()  {
        location=value;
        database.child("user").child(FirebaseAuth.instance.currentUser!.uid).child("latitude").set(location.latitude);
        database.child("user").child(FirebaseAuth.instance.currentUser!.uid).child("longitude").set(location.longitude);
     getaddress(location);
      }
      );

    }
    ).catchError((e){
      print(e);
    });

    return await Geolocator.getCurrentPosition();

  }
  Future <void> getaddress(Position location) async {
    List<Placemark> placemarks =  await placemarkFromCoordinates(location.latitude,location.longitude).catchError((e){print(e);});
    Placemark placeMark  = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;

    setState(() {
      address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
      database.child("user").child(FirebaseAuth.instance.currentUser!.uid).child("address").set(address);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(


        child:name!=''&&address!=''&&mobile!=''? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 20,),
              new GestureDetector( onTap:(){imgFromGallery();setState(() {});},child: Container( child:imagefile.path!=''?CircleAvatar(backgroundImage:FileImage(imagefile),maxRadius: 100, ):image_url!=''?CircleAvatar(backgroundImage:FileImage(new File(image_url)),maxRadius: 100, ):Icon(Icons.account_circle,color: Colors.redAccent,size: 100,))),
              SizedBox(height: 20,),
              Text("$name",style: GoogleFonts.abel(fontSize: 20,color:Colors.redAccent,fontWeight: FontWeight.bold),textScaleFactor: 1.5,),
              SizedBox(height: 20,),
              Text("mobile no. ${mobile}",style: GoogleFonts.abel(fontSize: 20,color:Colors.redAccent,fontWeight: FontWeight.bold),textScaleFactor: 1.2),
              SizedBox(height: 20,),
              Text("${FirebaseAuth.instance.currentUser!.email}",style: GoogleFonts.abel(fontSize: 20,color:Colors.redAccent,fontWeight: FontWeight.bold),textScaleFactor: 1.2),
              SizedBox(height: 20,),
              Text("address- $address",style: GoogleFonts.abel(fontSize: 20,color:Colors.redAccent,fontWeight: FontWeight.bold),textScaleFactor: 1.2,),

              RaisedButton(
                shape:       RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.5)),
                onPressed: () async {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new login()));
               await auth.signOut();

               },
              child: Text("logout",textScaleFactor: 1.5,style: TextStyle(color: Colors.white),),color: Colors.redAccent,)

            ],
          ),
        ):CircularProgressIndicator(color:Colors.redAccent,),
      ),
    );
  }
}
