import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data.dart';
import 'main.dart';

class Contact_List extends StatefulWidget {
  const Contact_List({Key? key}) : super(key: key);

  @override
  State<Contact_List> createState() => _Contact_ListState();
}

class _Contact_ListState extends State<Contact_List> {
  Box box = Hive.box('contact_numner');
  List name = [], contact = [], city = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact List"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Conatc_Book();
                    },
                  ));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            Contct_list s = box.getAt(index);
            //Contct_list s=box.getAt(index); /when give the fix
            return //Card(child: ListTile(title: Text("${s.name}"),subtitle: Text("$n} | ${s.city}"),),); /when use by direct index
                Card(
              child: ListTile(
                title: Text("${s.name}"),
                subtitle: Text("${s.contact} | ${s.city}"),
                trailing: Wrap(children: [
                  IconButton(
                      onPressed: () {
                        box.deleteAt(index);
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.delete)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Conatc_Book();
                        },));
                      },
                      icon: Icon(Icons.edit))
                ]),
              ),
            );
          },
        ));
  }
}
