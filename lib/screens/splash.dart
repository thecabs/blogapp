import 'package:blog_app/screens/loading.dart';
import 'package:blog_app/screens/onboarding/onbaording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
 
 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => Loading()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
           
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: size.height * 0.3),
              Container(
                child: Image.asset(
                  'assets/images/intro1.jpg',
                  height: 200,
                  width: 200,
                ),
              ),
              Center(
                child: Text(
                  'Blog App',
                  style: GoogleFonts.montserrat(
                     fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color(0xff27283A),
                  ),
                ),
              ),
              //SizedBox(height: size.height * 0.1),
              SpinKitWaveSpinner(
                color: Color(0xffFF7D01),
                size: 50.0,
              ),
              SizedBox(height: size.height * 0.25),
              Center(
                child: Text("_By SVR Studio _ ",
                    style: GoogleFonts.montserrat(
                       
                      fontSize: 20,
                      color: Color(0xff27283A),
                    )),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
