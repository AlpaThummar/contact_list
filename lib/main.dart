import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'contact_list.dart';
import 'data.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  Hive.registerAdapter(ContctlistAdapter());
  var box = await Hive.openBox('contact_numner');

  runApp(MaterialApp(
    home: Conatc_Book(),
    debugShowCheckedModeBanner: false,
    themeAnimationCurve: Curves.bounceIn,
    themeAnimationDuration: Duration(seconds: 5),
    theme: ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
    ),
  ));
}

class Conatc_Book extends StatefulWidget {
  Contct_list ?s;
  Conatc_Book([this.s]);


  @override
  State<Conatc_Book> createState() => _Conatc_BookState();
}

class _Conatc_BookState extends State<Conatc_Book> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  Box box=Hive.box('contact_numner');
  bool screen=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.s!=null)
      {
        t1.text=widget.s!.name;
        t2.text=widget.s!.contact;
        t3.text=widget.s!.city;
      }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if(Orientation.portrait==orientation)
        {
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          screen=true;
        }else{
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
        screen =false;
      }

      return Scaffold(
        appBar: AppBar(
          title: Center(
              child: (widget.s!=null)?Text("Update Details", textAlign: TextAlign.center,):
              Text("Contact Book",
                textAlign: TextAlign.center,)
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(child: TextField(controller: t1,decoration: InputDecoration(hintText: "Enter Name",),),),
              Card(child: TextField(controller: t2,decoration: InputDecoration(hintText: "Enter Number"),),),
              Card(child: TextField(controller: t3,decoration: InputDecoration(hintText: "City"),),),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                ElevatedButton(onPressed: () {
                  String name,contact,city;
                  name=t1.text;
                  contact=t2.text;
                  city=t3.text;
                  if(widget.s!=null)
                  {
                    widget.s!.name=name;
                    widget.s!.contact=contact;
                    widget.s!.city=city;
                    widget.s!.save();
                  }else{
                    Contct_list s=Contct_list(name,contact,city);
                    box.add(s);
                    print(s);
                  }


                }, child: (widget.s!=null)?Text("Update"):
                Text("Submit")),
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Contact_List();
                  },));
                }, child: Text("View"))
              ],)
            ],
          ),
        ),

      );
    },);
  }
}
