import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:RemindMe/resources/firestore_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../models/item_model.dart';

class Additem extends StatefulWidget {
  final ItemModel item;
  const Additem({this.item});

  @override
  _AdditemState createState() => _AdditemState();
}

String url;

 
Future<void> uploadPic(File image) async {
  var timekey = DateTime.now();
 

  StorageReference reference = FirebaseStorage.instance.ref().child("Images");

  StorageUploadTask uploadTask =
      reference.child(timekey.toString() + ".jpg").putFile(image);

  // Waits till the file is uploaded then stores the download url
  url = await (await uploadTask.onComplete).ref.getDownloadURL();
  url = url.toString();
  print(url);
}

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

class _AdditemState extends State<Additem> {
  File _image;
  String text = "Add new item";
  String title;
  Widget appbart() {
    return Text(text);
  }

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
    super.initState();
    if (widget.item != null) {
      setState(() {
        text = "update item";
      });
      _titleController.text = widget.item.title;
      _desController.text = widget.item.description;
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
       
          backgroundColor: Colors.indigoAccent,
          title: appbart()),
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
                  if (_titleController == null || _desController == null)
                    return _scaffoldkey.currentState.showSnackBar(new SnackBar(
                        content: Text('Please fill the details to add')));

               await uploadPic(_image);
                  try {
                    Map<String, dynamic> item = {
                      "title": _titleController.text,
                      "decription": _desController.text,
                      "image": url
                    };
                    if (widget.item != null) {
                      await FirestoreProvider()
                          .updateItem(widget.item.id, item);
                    } else {
                      await FirestoreProvider().addItem(item);
                    }
                  } catch (e) {
                    print(e.message);
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
