import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker_app/Views/Info.dart';
import 'package:quiz_maker_app/Views/quiz_play.dart';
import 'package:quiz_maker_app/services/database.dart';
import 'package:quiz_maker_app/widgets.dart';
import 'package:quiz_maker_app/services/auth.dart';
import 'animations/FadeAnimation.dart';
import 'create_quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  AuthService authService = new AuthService();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  String _searchText = "";
  int _currentIndex = 0;

  Widget quizList(String query) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: quizStream,
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data.documents[index].data['quizTitle']
                              .toString()
                              .toLowerCase()
                              .contains(query)) {
                            return Dismissible(
                              key: new Key(snapshot
                                  .data.documents[index].data["quizId"]),
                              child: FadeAnimation(
                                  index.toDouble(),
                                  QuizTile(
                                    noOfQuestions:
                                        snapshot.data.documents.length,
                                    imageUrl: snapshot.data.documents[index]
                                        .data['quizImgUrl'],
                                    title: snapshot.data.documents[index]
                                        .data['quizTitle'],
                                    description: snapshot
                                        .data.documents[index].data['quizDesc'],
                                    id: snapshot
                                        .data.documents[index].data["quizId"],
                                  )),
                              onDismissed: (direction) {
                                databaseService.deleteQuiz(snapshot
                                    .data.documents[index].data["quizId"]);
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                  // child: Text(
                                  //   'no match',
                                  //   style: TextStyle(fontSize: 4.0),
                                  // ),
                                  ),
                            );
                          }
                        });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: _currentIndex == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _controller,
                  cursorColor: blues,
                  style: TextStyle(color: blues),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.grey[400])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: blues)),
                  onChanged: (val) {
                    setState(() {
                      _searchText = val;
                    });
                  },
                ),
              )
            : AppLogo(),
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
      ),
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
      body: quizList(_searchText),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blues,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description;
  final int noOfQuestions;
  DatabaseService databaseService = new DatabaseService();

  QuizTile(
      {@required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.id,
      @required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuizPlay(id)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.symmetric(vertical: 7),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
