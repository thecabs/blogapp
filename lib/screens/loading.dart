import 'package:blog_app/constant.dart';
import 'package:blog_app/models/api_response.dart';
import 'package:blog_app/screens/home.dart';
import 'package:blog_app/screens/login.dart';
import 'package:blog_app/screens/onboarding/onbaording.dart';
import 'package:blog_app/screens/splash.dart';
import 'package:blog_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _LoadingUserInfo() async {
    String token = await getToken();

    if(token==''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
    else {
      ApiResponse response = await getUserDetail();
      if (response.error == null){
      
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);

      }
      else if (response.error == unauthorized){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route) => false);

      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
        
        SnackBar(
          
        duration: Duration(seconds: 3),
        
        content: Container(
          
           height: 30.0,
          child: Text(
            
            '${response.error}',
            style: GoogleFonts.nunito(
              color: Colors.white,
            fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
            ),),
            backgroundColor: Colors.red,
        )
      );
      }

    }
  }

@override
  void initState() {
_LoadingUserInfo();
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );

  
  }
}