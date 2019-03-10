import 'dart:async';

import '../../models/item_model.dart';
import 'package:flutter/material.dart';
import '../pages/itemdetail.dart';
import 'dart:io';
import '../../resources/db_provider.dart';

// 8=]45737import  'package:cloud_firestore/cloud_firestore.dart';
import '../pages/additem.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];
  void initState() {
    super.initState();
    // getItem();
  }

  Future<List> getItem() async {
    return DbProvider().fetchItems();

    // final sp = await SharedPreferences.getInstance();
    // var itemString = sp.getString('item');
    // if (itemString == null) {

    // } else {
    //   setState(() {
    //     items = json.decode(itemString);
    //   });
    // }
  }

  // saveItem(items) async {
  //   final sp = await SharedPreferences.getInstance();
  //   await sp.setString('item', json.encode(items));
  //   print('saved to shared preferences');
  //   print(items);
  // }

  removeItem(ItemModel item) {
    // final sp = await SharedPreferences.getInstance();
    // SharedPreferences preferences = getSharedPreferences("Mypref", 0);
    // preferences.edit().remove("text").commit();
    // await sp.setString('item', json.encode(items));
    setState(() {
      DbProvider().deleteItem(item.id);
      // items.remove(item);
    });
    //saveItem(items);
    //print('deleted from shared preferences');
    //  print(items);
  }

  // add(item) async {
  //   setState(() {
  //     items.add(item);
  //   });
  //   await saveItem(items);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top_bar(),
      appBar: AppBar(
        // leading: Icon(Icons.label),
        title: Text('IRemember'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.polymer),
            //tooltip: 'Open shopping cart',
            onPressed: () {
              // ...
            },
          ),
        ],
        //Icon(Icons.label),
        // backgroundColor: Colors.limeAccent,
      ),
      body: FutureBuilder(
          future: getItem(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasError)
              return Center(
                child: Text("there is an error"),
              );
            List items = snapshot.data;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // var litem = items[index];
                ItemModel litem = ItemModel.fromMap(items[index]);

                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ItemDetails(items: litem, delete: _delete))),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(litem.image)),
                  ),
                  title: Text(litem.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delete(litem),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${litem.description}'),
                      //  new FlatButton(onPressed: () {
                      //    remove(items);
                      //    saveItem(items);
                      //  },
                      //           child: new Text("DELETE",
                      //             style: new TextStyle(color: Colors.redAccent),)),

                      SizedBox(
                        height: 5,
                      ),
                      // Text(items["phone"])

                      //list.items
                    ],
                  ),
                  // new Row(mainAxisAlignment: MainAxisAlignment.end,
                  //         children: <Widget>[ //add some actions, icons...etc
                  //           new FlatButton(onPressed: () {}, child: new Text("EDIT")),
                  //           new FlatButton(onPressed: () {},
                  //               child: new Text("DELETE",
                  //                 style: new TextStyle(color: Colors.redAccent),))
                  //         ],),
                );
              },
            );
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => Additem())),
        tooltip: 'add item',
        child: Icon(Icons.add),
      ),
    );

    // List <Map> items;
    // );
  }

  //(item.add(_)=>items.resource(_))
  void _delete(ItemModel item) {
    // setState(() {
    //  items.remove(
    //    item
    //  ) ;

    // });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete item"),
            content: Text("Are you sure ?"),
            actions: <Widget>[
              FlatButton(
                child: Text("cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text("Delete"),
                  onPressed: () {
                    removeItem(item);
                    // Navigator.pop(context);
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }),
            ],
          );
        });
  }

  AddItem(String title, String description, File _image) {
    setState(() {
      items.add({
        "title": title,
        "description": description,
        "img": _image.path,
      });
    });
    // saveItem(items);
  }
}
