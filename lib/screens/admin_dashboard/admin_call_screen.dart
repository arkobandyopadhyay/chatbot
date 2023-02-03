import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/dialer.dart';

class AdminCallScreen extends StatefulWidget {
  const AdminCallScreen({super.key});

  @override
  State<AdminCallScreen> createState() => _AdminCallScreenState();
}

class _AdminCallScreenState extends State<AdminCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                   DailerWidget(number: 'tel: 8770904101',name:"Electrician"),
                   DailerWidget(number: 'tel: 8770904101',name:"Furniture"),
                   DailerWidget(number: 'tel: 8770904101',name:"Water Supply"),
                   DailerWidget(number: 'tel: 8770904101',name:"Food Incharge"),
                   DailerWidget(number: 'tel: 8770904101',name:"Lift Mechanic"),
                   DailerWidget(number: 'tel: 8770904101',name:"Room Cleaner"),
                   DailerWidget(number: 'tel: 8770904101',name:"Washroom Cleaner"),
                   DailerWidget(number: 'tel: 8770904101',name:"Security Guard"),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
