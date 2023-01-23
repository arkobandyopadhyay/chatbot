import 'package:chatbot/model/complaint_model.dart';
import 'package:chatbot/screens/admin_login/SignInScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/complaint_list_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Complaints')),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return SignInScreen();
                  },
                ));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: ComplaintModel.items.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              item: ComplaintModel.items[index],
            );
          },
        ),
      ),
     
    );
  
    
   
  }
}
