 import 'package:blog_app/constant.dart';
import 'package:blog_app/screens/home.dart';
import 'package:blog_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;
  TextEditingController
    nameController = TextEditingController(), 
    emailController = TextEditingController(),
    passwordController = TextEditingController(),
    passwordConfirmController = TextEditingController();

  void _registerUser () async {
    ApiResponse response = await register(nameController.text, emailController.text, passwordController.text);
    if(response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } 
    else {
      setState(() {
        loading = !loading;
      });
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

  // Save and redirect to home
  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          children: [
             Center(
                  child: Lottie.asset(
                'assets/images/signupp.json',
                height: 200,
                width: 200,
              )),
              const SizedBox(
                height: 10,
              ),

              //Hello Again!
              Text('Hello There !',
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),

              Text(
                'Register bellow with your details',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
            TextFormField(
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Invalid name' : null,
              decoration: kInputDecoration('Name')
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: kInputDecoration('Email')
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Required at least 6 chars' : null,
              decoration: kInputDecoration('Password')
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordConfirmController,
              obscureText: true,
              validator: (val) => val != passwordController.text ? 'Confirm password does not match' : null,
              decoration: kInputDecoration('Confirm password')
            ),
            const SizedBox(height: 20,),
            loading ? 
              const Center(child: CircularProgressIndicator())
            : kTextButton('Register', () {
                if(formKey.currentState!.validate()){
                  setState(() {
                    loading = !loading;
                    _registerUser();
                  });
                }
              },
            ),
            const SizedBox(height: 20,),
            kLoginRegisterHint('Already have an account? ', 'Login', (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Login()), (route) => false);
            })
          ],
        ),
      ),
    );
  }
}