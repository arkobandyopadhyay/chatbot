import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserCallScreen extends StatefulWidget {
  const UserCallScreen({super.key});

  @override
  State<UserCallScreen> createState() => _UserCallScreenState();
}

class _UserCallScreenState extends State<UserCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Electrician",style: TextStyle(fontSize: 20),),
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ), //label text 
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Furniture",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Water Supply",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Food Incharge",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Lift Mechanic",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Room Cleaner",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Washroom Cleaner",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Ambulance",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Emergency",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("FireBrigade",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
             Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                      onPressed: (){
                        launchUrlString('tel: 8770904101');
                      }, 
                      icon: Icon(Icons.call),  //icon data for elevated button
                      label: Text("Security Guard",style: TextStyle(fontSize: 20),), //label text 
                      style: ElevatedButton.styleFrom(
                         primary: Colors.blueAccent //elevated btton background color
                      ),
                  ),
             ),
          ],
        )
      ),
    );
  }
}
