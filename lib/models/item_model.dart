import 'package:cloud_firestore/cloud_firestore.dart';

import '../resources/constants.dart';

class ItemModel {
  final String title;
  final String id;
  final String description;
  final String image;

  ItemModel({
    this.title,
    this.id,
    this.description,
    this.image,
  });

  ItemModel.fromMap(DocumentSnapshot parsedJson)
      : id = parsedJson.documentID,
        title = parsedJson[columnTitle],
        image = parsedJson[columnImage],
        description = parsedJson[columnDescription];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[columnId] = id;
    map[columnTitle] = title;
    map[columnDescription] = description;
    map[columnImage] = image;
    return map;
  }
}
