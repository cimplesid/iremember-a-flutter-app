import 'package:flutter/material.dart';
// import 'home.dart';
import '../../models/item_model.dart';
class ItemDetails extends StatelessWidget {
  final ItemModel items;
  final Function delete;
  const ItemDetails({Key key, this.items, this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                delete(items);
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (_) => HomePage()));
              })
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            ///AssetImage('assets/img/${items['image'].jpg'),

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //AssetImage('assets/img/${items['image'].jpg'),
              //backgroundImage: ('),
              DecoratedBox(
                child: Container(
                  height: 200,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: AssetImage('${items['image']}'),
                    image: AssetImage(
                      (items.image),
                    ),
                    //var img=items['img'];
                  ),
                ),
              ),

              Text(
                items.title,
                style: Theme.of(context).textTheme.display1,
              ),
              // Text(item['email']),
              SizedBox(
                height: 20.0,
              ),
              Text("itemname: ${items.title}"),
              SizedBox(
                height: 10.0,
              ),
              Text("Description: ${items.description}"),
              SizedBox(
                height: 10.0,
              ),

              // Text( "Website: ${item['website']}"),
            ],
          )),
    );
  }
}
