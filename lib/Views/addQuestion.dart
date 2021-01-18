import 'package:flutter/material.dart';
import 'package:quiz_maker_app/Views/home.dart';
import 'package:quiz_maker_app/services/database.dart';

import '../widgets.dart';
import 'animations/FadeAnimation.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      print("${widget.quizId}");
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  popScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 40,
                    ),
                    FadeAnimation(
                        1,
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter Question" : null,
                          decoration: InputDecoration(hintText: "Question"),
                          onChanged: (val) {
                            question = val;
                          },
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    FadeAnimation(
                        2,
                        TextFormField(
                          validator: (val) => val.isEmpty ? "Option1 " : null,
                          decoration: InputDecoration(
                              hintText: "Option1 (Correct Answer)"),
                          onChanged: (val) {
                            option1 = val;
                          },
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    FadeAnimation(
                        3,
                        TextFormField(
                          validator: (val) => val.isEmpty ? "Option2 " : null,
                          decoration: InputDecoration(hintText: "Option2"),
                          onChanged: (val) {
                            option2 = val;
                          },
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    FadeAnimation(
                        4,
                        TextFormField(
                          validator: (val) => val.isEmpty ? "Option3 " : null,
                          decoration: InputDecoration(hintText: "Option3"),
                          onChanged: (val) {
                            option3 = val;
                          },
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    FadeAnimation(
                        5,
                        TextFormField(
                          validator: (val) => val.isEmpty ? "Option4 " : null,
                          decoration: InputDecoration(hintText: "Option4"),
                          onChanged: (val) {
                            option4 = val;
                          },
                        )),
                    SizedBox(
                      height: 340,
                    ),
                    // Spacer(),
                    FadeAnimation(
                        6,
                        Row(children: [
                          Expanded(
                              child: button("Add Question", uploadQuizData)),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: button("Submit", popScreen))
                        ])),
                    SizedBox(
                      height: 60,
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
