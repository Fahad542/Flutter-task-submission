import 'package:codelabtest/Utilis/Colors.dart';
import 'package:flutter/material.dart';

import '../Models/User_model.dart';
import '../Utilis/Custom_widgets.dart';



class Dashboard extends StatelessWidget {
  UserModel user;
  Dashboard({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/burj.jpg",
              height: MediaQuery.of(context).size.height * 0.42, // 25% of screen height
              width: MediaQuery.of(context).size.width * 0.99,
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.8), // White overlay with 50% opacity
              colorBlendMode: BlendMode.screen, // Lightening effect
            ),
          ),

          Column(
            children: [
              ClipRRect(
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryDark.withOpacity(0.8),
                    BlendMode.darken,
                  ),
                  child: Image.asset(
                    "assets/images/dashboardimg.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4, // Set image height
                  ),
                ),
              ),

            ],
          ),

          Positioned(
              top: 40, // Adjust overlap height
              left: 8,
              right: 0,
              child:
              profilesection(user) ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35, // Adjust overlap height
            left: 0,
            right: 0,

            child:
                Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child:   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                          children: [

                            gridview(),

                            accounment(),



                          ],
                        ),
                  ),
                    ),
                  ),



    ],
      ),
    );
  }



}
