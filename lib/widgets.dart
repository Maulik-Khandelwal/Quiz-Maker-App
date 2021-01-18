import 'package:flutter/material.dart';
import 'package:quiz_maker_app/services/auth.dart';
import 'Views/welcome.dart';
import 'functions/constants.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 35),
        children: <TextSpan>[
          TextSpan(
              text: 'Quiz',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black38)),
          TextSpan(
              text: 'App',
              style: TextStyle(fontWeight: FontWeight.w600, color: blues)),
        ],
      ),
    );
  }
}

Widget button(String text1, Function op) {
  return Container(
    padding: EdgeInsets.only(top: 3, left: 3),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border(
          bottom: BorderSide(color: Colors.black),
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        )),
    child: MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        op();
      },
      color: blues,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        text1,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black87),
      ),
    ),
  );
}

Widget Appbar(context) {
  return AppBar(
    centerTitle: true,
    title: (AppLogo()),
    elevation: 0,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: Colors.black,
      ),
    ),
  );
}

AuthService authService = new AuthService();
SignOut(context) async {
  await authService.signOut().then((value) {
    if (value == null) {
      Constants.saveUserLoggedInSharedPreference(false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  });
}

Color blues = Color(0xff28B8F4);
Color greys = Color(0xBBF1F1F1);
