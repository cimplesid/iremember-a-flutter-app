import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../resources/db_provider.dart';
import '../../models/item_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Additem extends StatefulWidget {
  // final Function add;
  // Additem(this.add);
  @override
  _AdditemState createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  File _image;
  // File galleryimage;
  String title;
  String description;

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
  Widget build(BuildContext context) {
    return Scaffold(
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
            new Container(
                child: Icon(
              Icons.bluetooth,
              size: 200.0,
              color: Colors.white54,
            )),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
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
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
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

                onPressed: () {
                  if (title == null || description == null || _image == null)
                    return;

                  // widget.add(
                  //   title,
                  //   description,
                  //   _image,
                  // );
                  ItemModel item =ItemModel(title: title,
                  description: description,image: _image.path);
                  DbProvider().addItem(item);
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
