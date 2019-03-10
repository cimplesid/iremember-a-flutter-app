import '../resources/constants.dart';

class ItemModel {
  final String title;
  final int id;
 final String description;

  final String image;

  ItemModel({
    this.title,
    this.id,
   this.description,

    this.image,
  });

  ItemModel.fromMap(Map<String, dynamic> parsedJson) :
        id = parsedJson[columnId],
        title = parsedJson[columnTitle],
       description = parsedJson[columnDescription],

        image = parsedJson[columnImage];
        
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map[columnId] = id;
    map[columnTitle] = title;
    map[columnDescription]=description;

    map[columnImage] = image;
    return map;
  }

}