



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastemanager/models/items.dart';


class recycle_items extends StatefulWidget {
  const recycle_items({Key? key}) : super(key: key);

  @override
  _recycle_itemsState createState() => _recycle_itemsState();
}

class _recycle_itemsState extends State<recycle_items> {

  final formkey = GlobalKey<FormState>();
   late List<items>item=[];
String name="";
String Mrp="";
String condition="";
String category="";
int option=-1;
int con_option=-1;
DatabaseReference reference=FirebaseDatabase.instance.reference().child("user").child(FirebaseAuth.instance.currentUser!.uid);

@override
  void initState() {
 
 getdata();
    super.initState();
  }
  getdata(){

    if(reference.child("items")!=null)
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
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), backgroundColor: Colors.redAccent, onPressed: () {
        showDialog(context: context, builder: (BuildContext context) {
          return  AlertDialog(
            scrollable: true,
            title: Text("Add the details of product",textScaleFactor: 1.2,style: GoogleFonts.abel(color: Colors.blue),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 10.0,
            content: StatefulBuilder(builder: (BuildContext context,StateSetter setState){
              return    Container(
                width: MediaQuery.of(context).size.width*1.2 ,
                height: MediaQuery.of(context).size.height*1.2 ,
                child: Form(
                  key: formkey,
                  child: Column
                    (
                    children: [
                      TextFormField(
                        onChanged: (value){setState(() {name=value;});}, validator: (value) {if (value!.isEmpty) {return "empty value";}
                      else {return null;}},
                        decoration: InputDecoration(labelText: "Product name", hintText: "enter here"),),
                      TextFormField(
                        onChanged: (price){Mrp=price;setState(() {});
                        }, validator: (value) {
                        if (value!.isEmpty) {
                          return "empty value";
                        }
                        else {
                          return null;
                        }
                      },
                        decoration: InputDecoration(
                            labelText: "Mrp at which product is bought in \u{20B9}.",
                            hintText: "\u{20B9}"

                        ),
                      ),
                      SizedBox(height: 20),
                      Text("Choose the category of item which you want to recycle",style: GoogleFonts.abel(fontWeight: FontWeight.bold,color: Colors.blue[700]),),
                      Column(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(height: 10),  SizedBox(child: GridView.count(crossAxisCount: 2, primary: false, shrinkWrap: true ,padding: const EdgeInsets.all(8),crossAxisSpacing: 7, mainAxisSpacing: 7, childAspectRatio: 1.2, children: [InkWell(onTap: (){setState(() {option=1;category="Fridges, freezers and other cooling equipment";});}, child: Container(decoration: BoxDecoration(color:option==1?Colors.green:Colors.blue[200], borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0),child: Text("A.  Fridges, freezers and other cooling equipment",style: GoogleFonts.abel()),),),), InkWell(onTap: (){setState(() {option=2;category="Computers and telecommunications equipment";});}, child: Container(decoration: BoxDecoration(color: option==2?Colors.green:Colors.blue[200], borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0), child: Text("B.  Computers and telecommunications equipment",style: GoogleFonts.abel(),),),),), InkWell(onTap: (){setState(() {option=3;category="Consumer electronic devices and solar panels";});}, child: Container(decoration: BoxDecoration(color:option==3?Colors.green:Colors.blue[200] , borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0), child: Text("C.  Consumer electronic devices and solar panels.",style: GoogleFonts.abel(),),),),),InkWell(onTap: (){option=4;setState(() {category="TVs, monitors,Led Bulbs and screens";});}, child:Container(decoration: BoxDecoration(color:option==4?Colors.green:Colors.blue[200], borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0), child: Text("D.  TVs, monitors,Led Bulbs and screens",style: GoogleFonts.abel()),),),), InkWell(onTap: (){option=5;setState(() {category="Medical device,toys, leisure and sports equipment";});}, child:Container(decoration: BoxDecoration(color:option==5?Colors.green:Colors.blue[200], borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0), child: Text("E.  Medical device,toys, leisure and sports equipment",style: GoogleFonts.abel(),),),),), InkWell(onTap: (){option=6;setState(() {category="other";});}, child:Container(decoration: BoxDecoration(color:option==6?Colors.green:Colors.blue[200], borderRadius: BorderRadius.all(Radius.circular(10))), child: Padding(padding: const EdgeInsets.all(12.0), child: Text("F.  other",style: GoogleFonts.abel(),),),),)])),]),
                      Text("Condition of product",textScaleFactor: 1.2,style: GoogleFonts.abel(fontWeight: FontWeight.bold,color: Colors.blue[700]),),
                      Column(
                        children: [
                          ListTile(
                            title: Text("working"),
                            leading: Radio(value: 1, groupValue: con_option, onChanged: (value) {setState(() {condition="working";con_option = value as int;});},
                              activeColor: Colors.green,
                            ),
                          ),
                          ListTile(
                            title: Text("not working"),
                            leading: Radio(value: 2, groupValue: con_option, onChanged: (value) {setState(() {condition="not working";con_option = value as int;});},
                              activeColor: Colors.green,
                            ),
                          ),
                          ListTile(
                            title: Text("partially working"),
                            leading: Radio(value: 3, groupValue: con_option, onChanged: (value) {setState(() {condition="partially working";con_option = value as int;});},
                              activeColor: Colors.green,
                            ),
                          ),
                          ListTile(
                            title: Text("did not know"),
                            leading: Radio(value: 4, groupValue: con_option, onChanged: (value) {setState(() {condition="did not know";con_option = value as int;});},
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                          color: Colors.blue, child: Text(
                          "Add item"), onPressed: () {
                        CircularProgressIndicator(backgroundColor: Colors.white);
                        if (formkey.currentState!.validate()) {
                          addtocart();
                          Navigator.pop(context);
                        }

                      }),
                    ],
                  ),
                ),
              );
            })

          );
        });
      },),
      body: item.length!=0?Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: items!=null?item.length:10,
            itemBuilder: (context, index) {
              return Card(
                child:ExpansionTile(

title: Text(item[index].name,textScaleFactor: 1.5,style: GoogleFonts.abel(),),

                  subtitle: Text('Mrp : \u{20B9} ${item[index].Mrp}',style: GoogleFonts.abel(),textScaleFactor: 1.0,),
children: [Column(

  mainAxisAlignment: MainAxisAlignment.start,
  children: [Text("condition: ${item[index].condition}",textScaleFactor: 1.2,style: GoogleFonts.abel(color: Colors.black),),Text("category: ${item[index].category}",textScaleFactor: 1.2,style: GoogleFonts.abel(color: Colors.black),)],
)],

                  trailing:InkWell(child:Icon(Icons.delete) ,onTap: (){setState(() {reference.child('items').orderByChild('name').equalTo(item[index].name).once().then((DataSnapshot snapshot) {
                      Map<dynamic, dynamic> children = snapshot.value;
                      children.forEach((key, value) {
                        reference
                            .child('items')
                            .child(key)
                            .remove();
                      });

                    });
                  });
                  item.removeAt(index);
                  setState(() {});
                  },) ,
                )
              );
            }),
      ):Center(child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.not_interested_rounded,color: Colors.grey,), Text("no item added",textScaleFactor: 1.2,style: TextStyle(color: Colors.grey),)],)),
    );
  }

  addtocart() async {
    final FormState? formState = formkey.currentState;
    if (formState!.validate()) {
      formState.save();
      items itemx=new items(name, Mrp,condition,category);
      reference.child("items").push().set({'name':name,'Mrp':Mrp,'condition':condition,'category':category}).asStream();
      setState(() {
        item.add(itemx);
      });

    }
  }
}
