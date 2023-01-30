import 'package:chatbot/core/utils/shared.dart';
import 'package:chatbot/model/complaint_model.dart';
import 'package:chatbot/screens/home/drawer/cubit/drawer_cubit.dart';
import 'package:chatbot/screens/widgets/card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/errors.dart';
import '../widgets/complaint_list_widget.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  List<Item> complaintList = List.empty(growable: true);

  @override
  @override
  void initState() {
    _getAllComplaints(context);
    super.initState();
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          complaintList.clear();
          print(complaintList);
          _getAllComplaints(context);
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<DrawerCubit, DrawerState>(
          builder: (context, state) {
            if (state is DrawerInitial)
              return _buildLoading(context);
            else if (state is DrawerSuccess)
              return _buildSuccess(context, state.DrawerList);
            else if (state is DrawerLoading)
              return _buildLoading(context);
            else
              return Text("something went wrong");
          },
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Item> ComplaintList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;

    return Column(
      children: [
        Container(
          color: Colors.purple[400],
          width: double.infinity,
          height: 200,
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                UserSimplePreferences.getEmail()!,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Room No. : ${UserSimplePreferences.getRoom()}",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: ComplaintList.length,
            itemBuilder: (context, index) {
              return CustomCard(
                // print(ComplaintList[index]);
                item: ComplaintList[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: CircularProgressIndicator());
  }

  void _getAllComplaints(BuildContext context) {
    final cubit = context.read<DrawerCubit>();
    cubit.getDrawerList();
  }
}
