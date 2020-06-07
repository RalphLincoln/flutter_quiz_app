import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizzPage(),
          ),
        ),
      ),
    );
  }
}

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool answer) {
    bool currentAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      // Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      // Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
      //HINT! Step 4 Part B is in the quiz_brain.dart
      //TODO: Step 4 Part C - reset the questionNumber,
      //TODO: Step 4 Part D - empty out the scoreKeeper.

      //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below
//      This IF STATEMENT is checking to see if we're at the end of the question
      if (quizBrain.isFinished()) {
//        This alert let's the user know that there are no more questions
        Alert(
          context: context,
          title: "SWEET!!!!",
          desc: "You have reached the end of the questions!!!!",
        ).show();
//        Since there are no more questions, we reset the question number to 0.
        quizBrain.reset();
//        Since there are no more questions, we reset the scoreKeeper to an empty array.
        scoreKeeper = [];
//        This ELSE STATEMENT deals with making sure that the score is recorded while the questions are being answered
      } else {
        if (currentAnswer == answer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      }

//      This changes the question
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//        This is for the QUESTIONS
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
//    This is the button for my TRUE press
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ),
        //            This is the button for my FALSE press
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
//        This keeps the record of SCORES
        Row(children: scoreKeeper)
      ],
    );
  }
}
