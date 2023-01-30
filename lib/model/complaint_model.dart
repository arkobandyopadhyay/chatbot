

import 'package:cloud_firestore/cloud_firestore.dart';

// class ComplaintModel {
//   static final items = [
//     Item(
//       type: 'Electricity',
//       roomno:"300",
//       status:false,
//       image:"assets/electricity.png"
//     ) ,
//     Item(
//       type: 'Water',
//       roomno:"250",
//       status:false,
//       image:"assets/tap.jpg"
//     ) ,
//     Item(
//       type: 'Washroom',
//       roomno:"333",
//       status:false,
//       image:"assets/washroom.jpg"
//     ) ,
//     Item(
//       type: 'Lift',
//       roomno:"444",
//       status:false,
//       image:"assets/lift.jpg"
//     ) ,
//     Item(
//       type: 'Room Clean',
//       roomno:"367",
//       status:false,
//       image:"assets/clean.jpg"
//     ) ,
//     Item(
//       type: 'Mess Food',
//       roomno:"345",
//       status:false,
//       image:"assets/food.jpg"
//     ) ,
//     Item(
//       type: 'Lift',
//       roomno:"478",
//       status:false,
//       image:"assets/lift.jpg"
//     ) ,
//     Item(
//       type: 'Room Clean',
//       roomno:"389",
//       status:false,
//       image:"assets/clean.jpg"
//     ) ,
//     Item(
//       type: 'Mess Food',
//       roomno:"378",
//       status:false,
//       image:"assets/food.jpg"
//     ) ,
//     Item(
//       type: 'Lift',
//       roomno:"440",
//       status:false,
//       image:"assets/lift.jpg"
//     ) ,
//     Item(
//       type: 'Room Clean',
//       roomno:"387",
//       status:false,
//       image:"assets/clean.jpg"
//     ) ,
//     Item(
//       type: 'Mess Food',
//       roomno:"395",
//       status:false,
//       image:"assets/food.jpg"
//     ) 
    
    
    
    
    
//     ];
// }

class Item {
  final String type;
  final String roomno;
   bool isDone1;
   bool isDone2;

   final String time;
   final String image;
  //  final String time;

  Item({required this.type, required this.roomno,required this.isDone1, required this.isDone2,required this.time, required this.image});

  factory Item.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return Item(
      roomno: data["room"],
      type: data["type"],
      isDone1: data["isDone1"],
      isDone2: data["isDone2"],
      time: data["time"],
      image: data['image'],
      // date:data['date'],
    );
  }
}