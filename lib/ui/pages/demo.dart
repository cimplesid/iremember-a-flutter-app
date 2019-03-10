// import 'package:flutter/material.dart';

// class AddItem extends StatefulWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        // color:Colors.lightBlue,
//        backgroundColor: Colors.indigoAccent,
//         title: Text(
//           'Add new item ',
          
//         ),
//       ),
//       body: new Container(
//         decoration: new BoxDecoration(color: Colors.indigoAccent,
//         ),
//         child:

//         ListView(
//         padding: EdgeInsets.all(20.0),
//         children: <Widget>[
//           TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'title',
//               prefixIcon: Icon(Icons.text_fields),
//             ),
//           ),
//           SizedBox(height: 20.0,),
//           TextField(
            
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//                prefixIcon: Icon(
//                 Icons.description,
//               ),
//               hintText: 'description',
             
//             ),
//           ),
//           SizedBox(height: 20.0, ),
//           SizedBox(height: 50.0,
//           width: 200.0,
//           child: RaisedButton.icon( 
//            icon: Icon(Icons.camera),
//            label: Text("choose photo"),
//            color: Colors.cyanAccent,

//            onPressed: ()=>debugPrint,
//          ),
         
//            ),
//            //Icon:Icons(Icons.home),
//           SizedBox(height: 20.0, ),
            
//           SizedBox(height: 50.0,
//           width: 200,
//           child: RaisedButton( 
//            //icon: Icon(Icons.camera),
//            child: Text("Save"),
//            color: Colors.greenAccent,
//            onPressed: ()=>debugPrint,
//          ),
//            ),
//         ],
      
//       ),
//        ) ,
//     );
//   }

//   // void NewPage(BuildContext context){
//   //   Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (ctx) => Scaffold(
//   //         body: Center(
//   //           child: Hero(
//   //             tag: 'my-hero-animation-tag',
//   //             child: Image.asset(name),
//   //           ),
//   //         ),
//   //       )
//   //     )
//   //   )
//   // }
// }