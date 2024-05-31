import 'package:blog_app/constant.dart';
import 'package:blog_app/models/api_response.dart';
import 'package:blog_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'home.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  bool _passwordVisible = true;

  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Container(
          height: 30.0,
          child: Text(
            '${response.error}',
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(50),
            children: [
              Lottie.asset("assets/images/1.json", height: 200, width: 150),

              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Container(
                child: Text('Hello Again !',
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Text(
                'Welcome back, you\'ve been missed !',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              // email textfield
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (val) =>
                    val!.isEmpty ? 'Invalid email address' : null,
                decoration: kInputDecoration(
                  'Email',
                ),
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              // password textfield

              TextFormField(
                obscureText: !_passwordVisible,
                controller: txtPassword,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    //borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.deepOrangeAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  labelText: 'Type Your Password',
                  suffixIconColor: Colors.green,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (val) =>
                    val!.length < 6 ? 'Required at least 6 chars' : null,
              ),

              const SizedBox(
                height: 10,
              ),

              loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : kTextButton('Login', () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _loginUser();
                        });
                      }
                    }),

              const SizedBox(
                height: 10,
              ),

              kLoginRegisterHint('Dont have an account ?  ', 'Register', () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Register()),
                    (route) => false);
              })
            ],
          )),
    );
  }
}
