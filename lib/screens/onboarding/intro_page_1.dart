import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //color: Color(0xff27283A),
            child: Center(child: Image.asset('assets/images/intro3.jpg')),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
              height:MediaQuery.sizeOf(context).height*0.2,
              width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              //color: Colors.blueGrey,
               
             // borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(25),
            child: Center(
              child: Text(
                "Blog app des ,Articles experts sur divers sujets",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Color(0xffFF7D01),
                  
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
