import 'package:codelabtest/Utilis/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/User_model.dart';

import '../Utilis/Colors.dart';
import '../Utilis/Custom_widgets.dart';
import '../Utilis/toast.dart';
import 'Dashboard.dart';
import 'Otp.dart';

class Login extends StatefulWidget {


  @override
  State<Login> createState() => _custom_containerState();
}

class _custom_containerState extends State<Login> {
  var user;
  List<UserModel>? users;
  TextEditingController logincontroller = TextEditingController();

  @override
  void initState() {
    users = (getData.users['users'] as List<dynamic>).map((user) => UserModel.fromJson(user as Map<String, dynamic>)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        resizeToAvoidBottomInset: true,
          backgroundColor:  AppColors.backgroundshade,
          body:



            SafeArea(
              child: Stack(
                children:[

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/image 5.png",
                      fit: BoxFit.cover,
                      color: AppColors.backgroundshade.withOpacity(0.99),
                      colorBlendMode: BlendMode.screen,
                    ),
                  ),




                  SingleChildScrollView(
                    child: Column(

                    children: [
                      SizedBox(height: 80,),
                      Image.asset("assets/images/logo.png", height: 100,width: 180,),

                      Stack(
                          children:[

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Column(
                                      children: [
                                        ClipPath(
                                          clipper: CustomWaveClipper(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF02243F),
                                                      Color(0xFF072B48),
                                                      Color(0xFF1F4F74),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    stops: [0.4172, 0.5648, 0.9109]),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                            height: 175,

                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             // widget.login ?




                                              Column(
                                                children: [

                                                  // OTP Input Fields
                                                  CustomTextField(
                                                    label: "Employee ID",
                                                    hintText: "etc. ABDS-12345",
                                                    controller: logincontroller,
                                                    isRequired: true,
                                                  )


                                                ],
                                              ),

                                              SizedBox(height: 25,),
                                              GestureDetector(
                                                onTap: () {
                                                  String employeeId = logincontroller.text.trim();

                                                  // Check if the input field is empty
                                                  if (employeeId.isEmpty) {
                                                    CustomToast.flushBarErrorMessage("Employee ID cannot be empty", context);
                                                    return; // Exit the function if the field is empty
                                                  }

                                                  bool isValidUser(String id) {
                                                    return users!.any((user) => user.empId == id);
                                                  }

                                                  if (isValidUser(employeeId)) {
                                                    user = users!.firstWhere((user) => user.empId == employeeId);
                                                    print(user);


                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => Otp(user: user),
                                                      ),
                                                          (Route<dynamic> route) => false, // This will clear all previous pages from the stack
                                                    );
                                                  } else {
                                                    CustomToast.flushBarErrorMessage("Invalid Employee ID", context);
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryDark, // Button color
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'Login',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10,)
                                                      ,                                  Icon(Icons.login, color: Colors.white,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 25,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              ],
                            ),
                            Positioned(
                              top: 30,
                              left: 50,
                              child:   Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Login your account',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Text("Please use your employee id provided by your \n organization to log in.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),),
                                  SizedBox(height: 5),


                                ],),
                            )
                          ]

                      )],),
                  ),
                  spotlightleft(),
                  spotlightright(),
              ]),
            ),
          );
  }
}

