import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super kalkulator 4k',
      theme: ThemeData(primarySwatch: Colors.lime),
      home: SuperCalculator(),
    );
  }
}

class SuperCalculator extends StatefulWidget {
  @override
  _SuperCalculatorState createState() => _SuperCalculatorState();
}

class _SuperCalculatorState extends State<SuperCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  String url = 'http://ipc51.net.pieklo.org:90/algorytm/';

  String replacer(){
    String stuff = equation;
    stuff = stuff.replaceAll('-', 'q');
    stuff = stuff.replaceAll('+', 'w');
    stuff = stuff.replaceAll('/', 'e');
    stuff = stuff.replaceAll('*', 'r');
    stuff = stuff.replaceAll('(', 't');
    stuff = stuff.replaceAll(')', 'y');
    return stuff;
  }


  Future  makeRequest() async {
    var res= await http.get(Uri.parse(url+replacer()));
    equation ="0";
    if(res.statusCode==200){
      print(res.body);
      return res.body;}else{return null;}
  }

  buttonPressed(String buttonText) {
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }
      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(1);
        if(equation ==""){
          equation = "0";
        }
      }
      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      result = makeRequest().toString();
      if (result[0]=='I')
      {
        result = "serwer nie dziala :c";
      }
      }
      else{
        if(equation == "0") {
          equation = buttonText;
        }else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return  Container(
      height: MediaQuery.of(context).size.height * 0.1*buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            )
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Super kalkulator 4k'),),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(child: Divider(),),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                       ]
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                       ]
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                       ]
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                       ]
                    ),
                    TableRow(
                      children: [
                        buildButton("(", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton(")", 1, Colors.black54),
                       ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ]
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 1, Colors.redAccent),
                      ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


