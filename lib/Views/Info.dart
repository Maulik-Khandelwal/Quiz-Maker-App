import 'package:flutter/material.dart';
import 'package:quiz_maker_app/Views/animations/FadeAnimation.dart';
import 'package:quiz_maker_app/Views/welcome.dart';
import 'package:quiz_maker_app/functions/constants.dart';
import 'package:quiz_maker_app/services/auth.dart';
import '../widgets.dart';
import 'home.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  int _currentIndex = 2;

  AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(context),
      body: (Informations()),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: blues,
        fixedColor: blues,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("Info"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Logout"),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
          if (index == 1) {}
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Information()));
          }
          if (index == 3) {
            SignOut(context);
          }
        },
      ),
    );
  }
}

class Informations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            FadeAnimation(
                1,
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blues,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Quiz Maker App",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 15,
            ),
            FadeAnimation(
                2, Container(child: Image.asset('assets/welcome3.jpg'))),
            FadeAnimation(
                3,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black38,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Quiz Maker is a Mobile Application that allows you to play, create and share quizzes in a simple and intuitive way.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 15,
            ),
            FadeAnimation(
                3,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black38,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "The questionnaires created using QuizMaker app are in the form of interactive tests quizzes that may contain pictures and sounds with automatic scoring. Thus, you can create your own quiz, play it and share it for self-evaluation or even for entertainment gaming purpose.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
