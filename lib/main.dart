import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastemanager/pages/account.dart';
import 'package:wastemanager/pages/currentlocation.dart';
import 'package:wastemanager/pages/login.dart';
import 'package:wastemanager/pages/recycle_items.dart';
import 'package:wastemanager/pages/recyclingtech.dart';
import 'package:wastemanager/pages/welcome.dart';

Future<void> main()  async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      home: welcome(),
      routes:{
        "/login": (context)=>login(),
        "/location":(context)=>currentlocation(),
        "/my":(context)=>MyApp()

      }
  ));

}
ThemeData darkThemeProperties = ThemeData(
    accentColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey,
    )
);

ThemeData lightThemeProperties = ThemeData(
  accentColor: Colors.pink,
  brightness: Brightness.light,
  primaryColor: Colors.redAccent,
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
);

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}
const List <Widget>tabs=[
  recycle(),
  currentlocation(),
  recycle_items(),
  account(),

];
class _MyAppState extends State<MyApp> {

  int selectedIndex=0;
  bool darkModeActive = false;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: !darkModeActive ? lightThemeProperties : darkThemeProperties,
     home : Scaffold(
        appBar: AppBar(
          centerTitle:  true,
          title:Text("WasteManager",style: GoogleFonts.abel(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                icon: Icon(darkModeActive
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  darkModeActive =
                  darkModeActive == false
                      ? true
                      : false;
                  setState(() {});
                }
                )
          ],

        ),
        body:Center(child:tabs.elementAt(selectedIndex) ,),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items:<BottomNavigationBarItem> [
            BottomNavigationBarItem(icon:Icon(Icons.list_outlined),label: "Information",backgroundColor: Colors.redAccent),
            BottomNavigationBarItem(icon:Icon(Icons.location_city_outlined),label: "map",backgroundColor: Colors.redAccent),
            BottomNavigationBarItem(icon:Icon(Icons.add_shopping_cart_sharp,),label: "recycle items",backgroundColor: Colors.redAccent),
            BottomNavigationBarItem(icon:Icon(Icons.account_box),label: "account",backgroundColor: Colors.redAccent),

          ],
          currentIndex: selectedIndex,
          selectedFontSize: 10,
          selectedItemColor: Colors.redAccent,
          onTap: _onItemTapped,

        ),

      ),
    );
  }
}

