
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wastemanager/models/items.dart';
import 'package:wastemanager/models/userdata.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class currentlocation extends StatefulWidget {
  const currentlocation({Key? key}) : super(key: key);


  @override
  _currentlocationState createState() => _currentlocationState();
}
class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void sendSms(String number) => launch("sms:$number");
  void sendEmail(String email) => launch("mailto:$email");
}



class _currentlocationState extends State<currentlocation> {
  late double latitude = 0.0;
  late double longitude = 0.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool mp = false;
  late List<items>item = [];
  DatabaseReference reference = FirebaseDatabase.instance.reference().child(
      "user");
  Completer<GoogleMapController> _controller = Completer();
  String kGoogleApiKey = 'AIzaSyDstYbN7PnlluXUzWhLUkevuHb4POd4P5o';
  int val = 1;


  @override
  void initState() {
    setState(() {
      getcurrentlocation();
    });


    reference.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for (var key in keys) {
        if (key != FirebaseAuth.instance.currentUser!.uid) {
          MarkerId markerId1 = MarkerId("$val");
          userdata userinfo = new userdata(
              values[key]["name"], values[key]["latitude"],
              values[key]["longitude"], values[key]["email"],
              values[key]["mobile"], values[key]["address"]);
          Marker marker = Marker(markerId: markerId1,
              position: LatLng(userinfo.latitude, userinfo.longitude),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(
                  title: userinfo.name, onTap: () {
                var bottomSheetController = scaffoldKey.currentState!
                    .showBottomSheet((context) =>
                    Container(child: getBottomSheet(userinfo), height: 250,
                      color: Colors.transparent,
                    ));
              }, snippet: "click here to know more.."
              ));

          setState(() {
            val = val + 1;
            markers[markerId1] = marker;
          });
        }
      }
    });

      int x = 10000;
      MarkerId centerId1 = MarkerId("$x");
      Marker center1 = Marker(markerId: centerId1, position: LatLng(30.8836,75.8248), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"COSMOS RECYCLING", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("COSMOS RECYCLING"), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center1;});
    Marker center2 = Marker(markerId: centerId1, position: LatLng(26.778538,80.891752), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Attero Recyclers ", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Attero Recyclers "), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center2;});
    Marker center3 = Marker(markerId: centerId1, position: LatLng(28.5883947,77.044671), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Ewaste Recyclers India pvt.", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Ewaste Recycler India"), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center3;});
    Marker center4 = Marker(markerId: centerId1, position: LatLng(18.513074,73.673646), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Hi-Tech Recycling India Pvt", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Hi-Tech Recycling India Pvt."), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center4;});
    Marker center5 = Marker(markerId: centerId1, position: LatLng(20.268927,85.857674), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"VIROGREEN India Pvt.", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("VIROGREEN PVT"), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center5;});
    Marker center6 = Marker(markerId: centerId1, position: LatLng(13.097306,77.391661), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"E-Parisaraa private limited", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("E-Parisaraa private limited"), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center6;});
    Marker center7 = Marker(markerId: centerId1, position: LatLng(12.91113,77.612009), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Saahas Zero Waste ", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Saahas Zero Waste  "), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center7;});
    Marker center8 = Marker(markerId: centerId1, position: LatLng(28.455841,77.30769), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Namo E-waste Management ltd. ", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Namo E-waste Management ltd."), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center8;});
    Marker center9 = Marker(markerId: centerId1, position: LatLng(28.455841,77.30769), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta), infoWindow: InfoWindow(title:"Namo E-waste Management ltd. ", onTap: () {var bottomSheetController = scaffoldKey.currentState!.showBottomSheet((context) => Container(child: Text("Namo E-waste Management ltd."), color: Colors.transparent,));}, snippet: "click here to know more.."));setState(() {x=x+1;markers[MarkerId("$x")]=center8;});

    super.initState();


  }
   getdata(){

     if(reference.child(FirebaseAuth.instance.currentUser!.uid).child("items")!=null)
       reference.child("items").once().then((DataSnapshot snapshot){
         var keys=snapshot.value.keys;
         var values=snapshot.value;

         for(var key in keys){
           setState(() {
             item.add(new items(values[key]["name"], values[key]["Mrp"], values[key]["condition"],values[key]["category"]));
           });

         }
       });
   }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key :scaffoldKey,
      body: GoogleMap(
        mapType: MapType.normal,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        rotateGesturesEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,

markers: Set<Marker>.of(markers.values),
        initialCameraPosition:CameraPosition(target: LatLng(latitude,longitude),
          zoom: 15

        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<Position> getcurrentlocation() async {
   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){latitude=value.latitude;longitude=value.longitude;});
   final GoogleMapController controller = await _controller.future;
   setState(() {
     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude,longitude),zoom:6)));
     Marker marker = Marker(markerId: MarkerId("0"),
     position: LatLng(latitude,longitude),
     icon: BitmapDescriptor.defaultMarkerWithHue(
     BitmapDescriptor.hueRed),
       infoWindow: InfoWindow(title: "home",)
     );
     markers[MarkerId("0")]=marker;
   });

return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getBottomSheet(userdata x) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width:  MediaQuery.of(context).size.width ,
                color: Colors.redAccent, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[SizedBox(height: 20,), Text("${x.name}",textScaleFactor: 1.4,style:  GoogleFonts.abel(color: Colors.white,fontWeight: FontWeight.bold),), SizedBox(height: 10,), SizedBox(width: 20,), Text("${x.address}",textScaleFactor: 1.4,style:  GoogleFonts.abel(color: Colors.white,fontWeight: FontWeight.bold),), SizedBox(height: 5,),],),),),
              SizedBox(width: 40,),
              Row(children: <Widget>[SizedBox(width: 20,),GestureDetector( onTap: (){UrlLauncher.launch('tel: ${x.phoneno}');},child: Icon(Icons.call,color: Colors.blue,)),Text("${x.phoneno}",textScaleFactor: 1.2,style:  GoogleFonts.abel()),SizedBox(width: 40,), GestureDetector( onTap: (){UrlLauncher.launch('mail to:${x.email}');},child: Icon(Icons.mail,color: Colors.blue,), ),  Text("${x.email}",textScaleFactor: 1.2,style:  GoogleFonts.abel() )],)],),),

      ],
    );}
}
