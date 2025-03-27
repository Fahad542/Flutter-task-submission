import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/User_model.dart';
import '../Utilis/Colors.dart';
import '../Utilis/Custom_widgets.dart';
import '../Utilis/toast.dart';
import 'Dashboard.dart';


class Otp extends StatefulWidget {
  UserModel? user;
  Otp({  this.user  });
  @override
  State<Otp> createState() => _custom_containerStat();
}

class _custom_containerStat extends State<Otp> {



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateOtp();
    });

    startTimer();

  }
  String otp = '';
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  int secondsRemaining = 60; // Timer ka time (1 minute)
  Timer? timer;
  void generateOtp() {
    Random random = Random();
     otp = (100000 + random.nextInt(900000)).toString(); // 6-digit OTP

    setState(() {
      secondsRemaining = 60; // Reset timer
    });


    // Show OTP in a popup
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent accidental dismissal
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Text(
                  "Your OTP Code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    otp,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startTimer();// Close the popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  ),
                  child: Text("OK", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          clearOtp();

          t.cancel();
        }
      });
    });
  }
  void clearOtp() {
    for (var controller in otpControllers) {
      setState(() {
        controller.clear();
      });
     // Remove OTP when expired
    }
  }
  void validateOtp(BuildContext context) {

    String enteredOtp = otpControllers.map((controller) => controller.text).join();


    if (enteredOtp.isEmpty) {
      CustomToast.flushBarErrorMessage("Please enter the OTP", context);
      return;
    }


    if (enteredOtp == otp) {
      print(enteredOtp);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(user: widget.user!),
        ),
            (Route<dynamic> route) => false, // This will clear all previous pages from the stack
      );

      CustomToast.flushBarSuccessrMessage("Login Successful", context);
    } else {
      print(otp);
      CustomToast.flushBarErrorMessage("Invalid OTP, please try again", context);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:  AppColors.backgroundshade,
      body: Container(

        child:
        Stack(
          children: [
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
                      SizedBox(height: 50),
                      Image.asset("assets/images/logo.png", height: 100,width: 180,),
                      Stack(
                        children: [

                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white, // Top light color
                                        Colors.white, // Light blue shade
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                                              stops: [0.4172, 0.5648, 0.9109],
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          height: 165,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Please check your inbox and insert the code below to sign in.',
                                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                            ),
                                            SizedBox(height: 32),


      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: 38,
          height: 38,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            controller: otpControllers[index],
            focusNode: focusNodes[index],


            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primaryDark, width: 2), // Change color here
              ),
            ),

            style: TextStyle(fontSize: 18),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                } else {
                    focusNodes[index].unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            },

          ),
        );
      }),
    ),


    SizedBox(height: 12,),
                                            (secondsRemaining > 0) ?
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Time left: "),
                                                Text(secondsRemaining.toString(), style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold),)
                                              ],
                                            ) :
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      InkWell( onTap: () {
        generateOtp();
        startTimer();
                                      },

        child: Text("Send Again", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red),textAlign: TextAlign.center,))],),

                                            SizedBox(height: 25),
                                            GestureDetector(
                                              onTap: () {
                                                validateOtp(context);

                                              },
                                              child: Container(
                                                height: 40,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryDark,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Login', style: TextStyle(fontSize: 15, color: Colors.white)),
                                                    SizedBox(width: 10),
                                                    Icon(Icons.login, color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 25),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Just one more step',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "We've sent a code to your email",
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  widget.user!.email.toString(),
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                     // Placing image at the bottom

                      // Some spacing
                    ],
                ),
                  ),

            // Image jo bilkul screen ke end par rahegi


            // Top Right Spotlight
            spotlightleft(),
            spotlightright(),
          ],
        ),
      ),



    );
  }

}
