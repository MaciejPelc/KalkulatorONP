// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:apka_do_nauki_od_zera/startup_view.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/painting.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'dart:math';

import 'package:apka_do_nauki_od_zera/widgets.dart';
import 'package:flutter/services.dart';
//void main() => runApp(MyApp());

import 'package:firebase_core/firebase_core.dart';

//import 'package:firebase_database/firebase_database.dart'; //do prostej akcji firebirda
import 'dart:math'; // do randomowej setki na dole

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartingAnimation()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();

  //[1]
  @override //[2]
  Widget build(BuildContext context) {
    ///[3] "BuildContext context" jest parametrem, co jest tym parametrem, kiedy ten widget jest wywoływany?
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super kalkulator 4K',
      home: FutureBuilder(
          future: fbApp,
          builder: (context, snaphot){
            //DatabaseReference testRef = FirebaseDatabase.instance.reference().child("test");
            // if(snaphot.hasError){
            //   print('you have an error! ${snaphot.error.toString()}');
            //   return Text('something went wrong!');
            // }else if(snaphot.hasData){
            return  Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   child: Icon(Icons.add),
              //   onPressed: (){
              //     //wywoływanie randomowej reakcji w firebirdzie
              //     DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("test");
              //     //wywoływanie randomowej reakcji w firebirdzie
              //     _testRef.set("hello world ${Random().nextInt(100)}");
              //   },
              // ),
                backgroundColor: Colors.black,
                appBar: AppBar(
                    title: Text('Super kalkulator 4K'),
                    leading: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: ()=> SystemChannels.platform.invokeMethod('SystemNavigator.pop')
                    )
                ),
                body: Stack(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        //height: 1000,//wysokość kolorkow
                        child: Column(
                            children: [
                              Expanded(child: RandomWords())
                            ],
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Row(
                          children: [
                            Spacer(),
                            secondWidget(),
                            Spacer(),
                          ],
                        )),
                  ],
                ));
          }
        // else Center(
        //     child: CircularProgressIndicator(),
        //   );
        //},

      ),
    );
  }
}

// class secondWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text('hello world'),
//     );
//   }
// }

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  Timer scrollTimer;// to robi że sięrusza
  final InfiniteScrollController _infiniteController = InfiniteScrollController(//to robi że jest nieskończoność
    initialScrollOffset: 0.0,
  );

  final _suggestions = <WordPair>[];
  List<String> _suggestions2 = new List<String>();
  final _biggerFont = TextStyle(fontSize: 18.0, color: Colors.black);
//////////////////////////////////////////////////////////////////////////////
  List colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  int colorHolder = -1;
  int colorOutput;
  Random random = new Random();
  //////////////////////////////////////////////////////////////
  @override
  int getColorId() {
    if (colorHolder == -1) {
      colorHolder = random.nextInt(6);
      colorOutput = colorHolder;
      return colorOutput;
    }
    while (colorOutput == colorHolder) {
      colorHolder = random.nextInt(6);
    }
    if (colorHolder != colorOutput) {
      colorOutput = colorHolder;
      return colorOutput;
    }
  }

////////////////////////////////////////////////////////////////////
//   ScrollController _scrollController = ScrollController();
//
//   _scrollToBottom() {
//     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//   }


  @override
  void initState() {
    super.initState(); //wywołanie klasy rodzica, a po chuj?
    for (int i = 1; i < 8; i++) {
      _suggestions2.add(i.toString());
    }
    scrollTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {//to, o to obi że się rusza
      _infiniteController.animateTo(_infiniteController.offset + 50.0,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  Widget _buildSuggestions() {
    return  InfiniteListView.separated(
      //physics: NeverScrollableScrollPhysics(),
      controller: _infiniteController,// to robi nieskończoność i tylko to
      //controller: _scrollController,
      //reverse: true,
      scrollDirection: Axis.vertical, // zmienia przewijanie z góra/dół na lewo/prawo UwU
      //itemCount: _suggestions2.length,//ta jebana kurwa, nie pozwalała mojej tęczy być nieskończoną, wrr
      itemBuilder: (context,int i) {
        return _buildRow(
          //_suggestions2[i], i
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.5),//to nie wiem po co to jest
    );
  }

  Widget _buildRow(
      //String pair, int index
      ) {
    return Container(
      //alignment: FractionalOffset.center,
      width: 100,
      height: 100,
      color: colors[getColorId()],

      child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            //      child: new Icon(const IconData(0xe800, fontFamily: 'Dupa')), tutaj mogę wstawić ikonki XDDD
              child: RichText(
                text: TextSpan(
                  //text: pair, style: _biggerFont
                ),
              )
          )),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return _buildSuggestions();
  }
}
