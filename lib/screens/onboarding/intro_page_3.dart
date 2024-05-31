import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Color(0xff27283A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //color: Color(0xff27283A),
            child: Center(child: Lottie.asset('assets/images/log.json')),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(

            height:MediaQuery.sizeOf(context).height*0.2,
              width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              //color: Colors.blueGrey,
               
           
            ),
            margin: EdgeInsets.all(25),
            child: Center(
              child: Text(
                "There is no one who loves pain itself, imply because it is pain",
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
