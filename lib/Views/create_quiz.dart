import 'package:flutter/material.dart';
import 'package:quiz_maker_app/Views/animations/FadeAnimation.dart';
import 'package:quiz_maker_app/services/database.dart';
import 'package:random_string/random_string.dart';
import '../widgets.dart';
import 'addQuestion.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImgUrl, quizDesc, quizTitle;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;
  String quizId;

  createQuiz() {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImgUrl": quizImgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbar(context),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                          1,
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter Quiz Image Url" : null,
                            decoration: InputDecoration(
                                hintText: "Quiz Image Url (Optional)"),
                            onChanged: (val) {
                              quizImgUrl = val;
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                          2,
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter Quiz Title" : null,
                            decoration: InputDecoration(hintText: "Quiz Title"),
                            onChanged: (val) {
                              quizTitle = val;
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                          3,
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter Quiz Description" : null,
                            decoration:
                                InputDecoration(hintText: "Quiz Description"),
                            onChanged: (val) {
                              quizDesc = val;
                            },
                          )),
                      Spacer(),
                      FadeAnimation(4, button("Add Quiz", createQuiz)),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ));
  }
}
