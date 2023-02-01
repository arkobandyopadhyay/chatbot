import 'package:chatbot/model/complaint_model.dart';
import 'package:chatbot/screens/admin_dashboard/admin_message_screen.dart';
import 'package:chatbot/screens/admin_login/SignInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/errors.dart';
import '../admin_login/cubit/admin_login_cubit.dart';
import '../admin_login/login_admin_repository.dart';
import '../widgets/complaint_list_widget.dart';
import 'cubit/admin_cubit.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
 List<Item> complaintList=List.empty(growable: true);

  @override
  @override
  void initState() {
    _getAllComplaints(context);
    super.initState();
    
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Complaints')),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BlocProvider(
              create: (_) => LoginAdminCubit(APILoginAdminRepository()),
              child: SignInScreen()),));
              },
              icon: Icon(Icons.logout))
        ],
        bottom: const TabBar(tabs: [
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.message),),
        ]),
      ),
      body: TabBarView(children: [
            RefreshIndicator(
                onRefresh: ()async {
                  setState(() {
                    complaintList.clear();
                    print(complaintList);
                    _getAllComplaints(context);
                  });
                  
                  },
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: BlocBuilder<AdminCubit, AdminState>(
                      builder: (context, state) {
                        if (state is AdminInitial)
                          return _buildLoading(context);
                        else if (state is AdminSuccess)
                          return _buildSuccess(context, state.AdminList);
                        else if (state is AdminLoading)
                          return _buildLoading(context);
                        else
                          return Text("something went wrong");
                      },
                    ),
                  ),
              ),
            AdminMessageScreen(),
       ]),
      ),
    );
  }
  Widget _buildSuccess(BuildContext context, List<Item> ComplaintList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;

    // List<ItemWidget> ComplaintContentList = [];
    // LeaderList.forEach((element) {
    //   ComplaintContentList.add(ItemWidget(
    //     item: element,
    //   ));
    // });

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: ComplaintList.length,
          itemBuilder: (context, index) {
            return ItemWidget(
              // print(ComplaintList[index]);
              item: ComplaintList[index],
            );
          },
        ),
      ),
    ) ; }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: CircularProgressIndicator());
  }

   void _getAllComplaints(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    cubit.getAdminList();
  }

  
}
