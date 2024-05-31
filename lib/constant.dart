// ----- STRINGS ------
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const baseURL = 'http://192.168.1.145:8000/api';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/user';
const postsURL = baseURL + '/posts';
const commentsURL = baseURL + '/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';

//----- input decoration

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepOrangeAccent),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(),
    hintText: label,
    labelText: "Type Your $label",
    filled: true,
  );
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
      onPressed: () => onPressed(),
      child: Text(label,
          style: GoogleFonts.nunito(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.deepOrangeAccent),
          padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.symmetric(vertical: 20))));
}

// loginRegisterHint

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      GestureDetector(
        child: Text(
          label,
          style: GoogleFonts.nunito(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        onTap: () => onTap(),
      )
    ],
  );
}

// likes and comment btn

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 4),
              Text('$value')
            ],
          ),
        ),
      ),
    ),
  );
}
