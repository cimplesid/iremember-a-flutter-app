import 'dart:async';
import '../../resources/firebase_auth_provider.dart';
import '../../resources/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/item_model.dart';
import 'package:flutter/material.dart';
import '../pages/itemdetail.dart';
import 'additem.dart';

// 8=]45737import  'package:cloud_firestore/cloud_firestore.dart';
import '../pages/additem.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var _refreshkey = GlobalKey<RefreshIndicatorState>();

class _HomePageState extends State<HomePage> {
  List items = [];
  void initState() {
    super.initState();
    refreshList();
    //  CircularProgressIndicator(value: 5,);
  }

  Future refreshList() async {
    _refreshkey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
  }

  removeItem(id) {
    FirestoreProvider().delete(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top_bar(),
      appBar: AppBar(
        // leading: Icon(Icons.label),
        title: Text('IRemember'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            FirebaseAuthProvider().logout();
          },
        ),
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
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: StreamBuilder(
            stream: FirestoreProvider().getItems(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (snapshot.hasError)
                return Center(
                  child: Text("there is an error"),
                );
              QuerySnapshot items = snapshot.data;
              List<DocumentSnapshot> documents = items.documents;
              return ListView.builder(
                itemCount: documents?.length,
                itemBuilder: (BuildContext context, int index) {
                  ItemModel litem = ItemModel.fromMap(documents[index]);

                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ItemDetails(items: litem, delete: _delete))),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          litem.image != null ? litem.image : Text('I')),
                    ),
                    title: Text(litem.title),
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Additem(
                                    item: litem,
                                  )));
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _delete(litem.id),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${litem.description}'),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => Additem())),
        tooltip: 'add item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _delete(String id) {
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
                    removeItem(id);
                    FirestoreProvider().getItems();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }),
            ],
          );
        });
  }

  // AddItem(String title, String description, File _image) {
  //   setState(() {
  //     items.add({
  //       "title": title,
  //       "description": description,
  //       "img": _image.path,
  //     });
  //   });
  //   // saveItem(items);
  // }
}
