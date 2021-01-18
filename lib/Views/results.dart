import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  Results({this.incorrect, this.total, this.correct, this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String image;
  String message;

  @override
  void initState() {
    // TODO: implement initState

    if ((widget.correct / widget.total == 1)) {
      image = 'assets/source.gif';
      message = 'Congratulations!';
    } else if ((widget.correct / widget.total >= 0.5)) {
      image = 'assets/source1.gif';
      message = 'Well Done!';
    } else if ((widget.correct / widget.total >= 0.25)) {
      image = 'assets/giphy1.gif';
      message = 'Good Try!';
    } else {
      image = 'assets/source2.gif';
      message = 'Sorry, Try Again!';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(child: Image.asset(image)),
                Center(
                  child: Text(
                    message,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "YOUR SCORE",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                      text: "${widget.correct}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.greenAccent),
                      children: [
                        TextSpan(
                            text: " / ${widget.total}",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: Colors.black))
                      ]),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
