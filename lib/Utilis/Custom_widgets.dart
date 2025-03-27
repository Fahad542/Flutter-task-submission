import 'package:codelabtest/UI/Dashboard.dart';
import 'package:codelabtest/UI/Otp.dart';
import 'package:codelabtest/Utilis/Data.dart';
import 'package:codelabtest/Utilis/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/User_model.dart';
import 'Colors.dart';







class CustomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height -30); // Start from bottom left

    // First downward curve
    path.quadraticBezierTo(
      size.width * 0.2, size.height - 70, // Control point
      size.width , size.height , // End point
    );



    path.lineTo(size.width, 0); // Close the shape
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}




class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isRequired;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isRequired = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontFamily: 'PublicSans',
              fontSize: 14,
              color: Colors.black87,
            ),
            children: isRequired
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

Widget profilesection(UserModel users) {
  return Container(
    padding: EdgeInsets.all(16.0),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset("assets/images/Avatar.png"),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(users.empId,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300

                  ),),
                SizedBox(height: 4),
                Text(
                  users.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PublicSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(users.email,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300

                  ),),



              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        Divider(
          thickness: 1,
          color: Colors.white,
        ),
        SizedBox(height: 5,),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300), // Default text style
            children: [
              TextSpan(
                text: "Company: ", // Heading
                style: TextStyle( fontSize: 14, color: Colors.white , fontFamily: 'PublicSans',), // Bold style
              ),
              TextSpan(
                text: users.company ?? "N/A", // Value (with null check)
                style: TextStyle(fontSize: 14,  color: Colors.white, fontWeight: FontWeight.bold), // Different color
              ),
            ],
          ),
        ),
        SizedBox(height: 7,),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300), // Default text style
            children: [
              TextSpan(
                text: "Platform: ", // Heading
                style: TextStyle( fontSize: 14, color: Colors.white, fontFamily: 'PublicSans',), // Bold style
              ),
              TextSpan(
                text: users.platform ?? "N/A", // Value (with null check)
                style: TextStyle(fontSize: 14,  color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'PublicSans',), // Different color
              ),
            ],
          ),
        ),


      ],
    ),
  );
}

Widget gridview() {
  return Padding(
    padding: EdgeInsets.all(8.0), // Reduced padding for better spacing
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10), // Reduced from 15 to 10
        Text(
          "Key functions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5), // Added small spacing between text and grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: getData.functions.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start, // Avoid extra spacing
              children: [
                Icon(getData.functions[index]['icon'], size: 30, color: AppColors.primaryLight),
                SizedBox(height: 2), // Reduced spacing between icon and text
                Text(
                  getData.functions[index]['label'],
                  style: TextStyle(fontSize: 12), // Slightly reduced font size
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}


Widget accounment() {
  return Padding(
    padding: EdgeInsets.all(1.0),
    child:
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Annoucments",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
           border: Border.all(width: 0.1, color: Colors.grey, )
          ),
          child:  Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.campaign, size: 40, color: Colors.red),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title here",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Description of the announcement in details will come here",
                            style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Posted on: 12/08/2025",
                            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),


  );
}



Widget spotlightright(){
  return Positioned(
    top: -50,
    right: -50,
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.6), // Spotlight color
            blurRadius: 100, // Soft blur effect
            spreadRadius: 50,
          ),
        ],
      ),
    ),
  );

}


Widget spotlightleft(){
  return Positioned(
    top: -50,
    left: -50,
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.6), // Spotlight color
            blurRadius: 100, // Soft blur effect
            spreadRadius: 50,
          ),
        ],
      ),
    ),
  );

}