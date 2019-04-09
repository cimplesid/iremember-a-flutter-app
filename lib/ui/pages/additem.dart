import 'dart:async';

import 'package:RemindMe/resources/firestore_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../resources/db_provider.dart';
import '../../models/item_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Additem extends StatefulWidget {
  final ItemModel item;
  const Additem({this.item}) ;
  // final Function add;
  // Additem(this.add);
  @override
  _AdditemState createState() => _AdditemState();
}

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
class _AdditemState extends State<Additem> {
  File _image;
  // File galleryimage;
  String title;
  String description;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();


  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future getgallery(ImageSource source) async {
    var galleryimg = await ImagePicker.pickImage(source: source);

    if (galleryimg != null) {
      setState(() {
        _image = galleryimg;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.item!=null){
      _titleController.text=widget.item.title;
      _desController.text=widget.item.description;

    }

  }

  @override
  Widget build(BuildContext context) {
    var icon2 = Icon(
      Icons.save,
      size: 200.0,
      color: Colors.white54,
    );
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        // color:Colors.lightBlue,
        backgroundColor: Colors.indigoAccent,
        title: Text(
          'Add new item ',
        ),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.indigoAccent,
        ),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            new Container(child: icon2),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'title',
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _desController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.description,
                ),
                hintText: 'description',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height: 50.0,
              width: 200.0,
              child: RaisedButton.icon(
                icon: Icon(Icons.camera),
                label: Text("choose photo from camera"),
                color: Colors.cyanAccent,
                onPressed: () => getImage(ImageSource.camera),
              ),
            ),
            SizedBox(
              child: _image == null
                  ? Container()
                  : Image.file(
                      _image,
                      height: 200,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            //Icon:Icons(Icons.home),

            SizedBox(
              height: 50,
              width: 20.0,
              child: RaisedButton.icon(
                icon: Icon(Icons.photo_album),
                label: new Text('Add Image From Gallery'),
                color: Colors.lightGreenAccent,
                onPressed: () => getgallery(ImageSource.gallery),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height: 50.0,
              width: 200,
              child: RaisedButton.icon(
                //icon: Icon(Icons.camera),
                icon: Icon(Icons.save),
                label: Text("Save"),

                color: Colors.greenAccent,

                onPressed: () async {
                  if (_titleController== null || _desController == null) return _scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text('Please fill the details to add')));
     

                  Map<String, dynamic> item = {
                    "title": _titleController.text,
                    "decription": _desController.text
                  };
                  if(widget.item!=null){
                    await FirestoreProvider().updateItem(widget.item.id,item);
                  }else{
                  await FirestoreProvider().addItem(item);
                  }

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
