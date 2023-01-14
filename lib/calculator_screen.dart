import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  //created a variable for the user output and result
  String userInput = "";
  String result = "0";

  //created a list of array for the buttons
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      //Color(0xff1d2630)
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator : Created by Bright Jonathan',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
             children: [
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                userInput,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
        const Divider(
          color: Colors.white10,
          thickness: 2,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: buttonList.length,
              itemBuilder: (context, index) {
                return CustomButton(buttonList[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 4, mainAxisSpacing: 12),
            ),
          ),
        )
      ]),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: const Color(0xff1d2630),
      onTap: () {
        setState(() {
          //funct... to calculate
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: const Offset(-3, -3))
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

//conditional statement for changing the colour of this particular field
  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(225, 252, 100, 100);
    }
    return Colors.white;
  }

//conditional statement for changing the colour of this particular field
  getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(225, 252, 100, 100);
    }

    if (text == "=") {
      return const Color.fromARGB(224, 33, 2, 173);
    }
    return Colors.black;
  }

//handles the targeted
  handleButton(String text) {
    //if equals erase all
    if (text == "AC") {
      userInput = '';
      result = '';
    }

    //if equals to c (which is cancelled)
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        null;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = result;

      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
        return;
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput = userInput + text;
  }

//funct... to calculate 
  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (error) {
      return 'Error';
    }
  }
}


