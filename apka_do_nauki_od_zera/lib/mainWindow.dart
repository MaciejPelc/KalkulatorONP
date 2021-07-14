import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:apka_do_nauki_od_zera/main.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class MainWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: new Scaffold(
        backgroundColor: Colors.green,
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyApp();
              }));
            },
          ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.alt_route_rounded,
                color: Colors.white,
              ),
              label: Text('przewijanie'),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: new ListView.builder(
          //scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            ////////////////////////////////miejsce na kontrolery
            Controllers control = new Controllers();
            control.create();
            control.add();
            control.add();
            control.add();
            List<TextEditingController> _controllers = new List();
            _controllers = control.controllers;
            ///////////////////////////////////////////////////////
            return new StuffInTiles(
              _controllers[index],
              listOfTiles[index]
            );
          },
          itemCount: listOfTiles.length,
        ),
      ),
    );
  }
}

class Controllers{

  //FirebaseAuth auth = FirebaseAuth.instance;//tworze objekt firebaseAuth

  List<TextEditingController> controllers;
  void create(){
    this.controllers = new List();
  }
  void add(){
    this.controllers.add(new TextEditingController());
  }
}

class StuffInTiles extends StatefulWidget {
  final MyTile myTile;
  final TextEditingController _controllers;
  const StuffInTiles(this._controllers ,this.myTile);
  //const StuffInTiles(this.myTile);
  @override
  StuffInTilesState createState() => StuffInTilesState();
}

class StuffInTilesState extends State<StuffInTiles> {

  String name = "";
  String state;
  Future<Directory> _appDocDir;

  //niebezpieczna jazda xd
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        //Text(widget.myTile.title),);
        _buildTiles(widget.myTile));
  }

  Widget _buildTiles(MyTile t) {
    //środek
    if (t.children.isEmpty) {
      return new ListTile(
        //onTap: () => (Colors.pink),
        title: new Text("proszę wpisać tekst"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(

              icon: Icon(
                Icons.favorite_border,
                size: 20.0,
                color: Colors.purple[900],
              ),
              onPressed: () {

                setState(() {
                  name = widget._controllers.text;
                  // Future<String> get _localPath async { //próba zapisu stringa na dysku
                  //   final directory = await getApplicationDocumentsDirectory();
                  //
                  //   return directory.path;
                  // }
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 20.0,
                color: Colors.red[900],
              ),
              onPressed: () {
                setState(() {
                  name = " ";
                });
              },
            ),
          ],
        ),
      );
    }
    return new ExpansionTile(
      leading: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //Text(t.title),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              size: 20.0,
              color: Colors.purple,
            ),
            onPressed: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(days: 1),
                  action: SnackBarAction(
                    label: 'Dissmiss',
                    textColor: Colors.purple,
                    onPressed: () {
                      setState(() {
                        name = widget._controllers.text;

                        //functionFutureBuilder(context, _controller.text);
                      });
                      Scaffold.of(context).hideCurrentSnackBar();
                    },
                  ),
                  content: TextField(
                    controller: widget._controllers,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 20.0,
              color: Colors.red[900],
            ),
            onPressed: () {
              setState(() {
                name = " ";
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("usunięte!"),
                  duration: Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
      key: new PageStorageKey<MyTile>(t),
      //wpisywanie wartości to text, muszę ogarnąć przesłanie ich do zapisu
      title: new Text(state??"czekaj"),//a znalazłem Cię XDD (czekaj nigdy nie zostanie wyświetlone, to usuwa błąd)
      // TextField(
      //     //t.title
      //   decoration: InputDecoration(
      //       border: InputBorder.none,
      //       //labelText: name //fajny ukryty/chowający się text
      //   ),
      //   controller: _controller,
      // ),
      children: t.children
          .map(_buildTiles)
          .toList(),
      //map(_buildTiles).toList() o co to jest? xd

    );
  }
}

class MyTile {
  String title = "!!!!!!!!";
  List<MyTile> children;
  MyTile(this.title, [this.children = const <MyTile>[]]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'Animals',
    <MyTile>[
      new MyTile(
        'Dogs',
        <MyTile>[
          new MyTile('Coton de Tulear'),
          new MyTile('German Shepherd'),
          new MyTile('Poodle'),
        ],
      ),
      new MyTile('Cats'),
      new MyTile('Birds'),
    ],
  ),
  new MyTile(
    'Cars',
    <MyTile>[
      new MyTile('Tesla'),
      new MyTile('Toyota'),
    ],
  ),
  new MyTile(
    'Phones',
    <MyTile>[
      new MyTile('Google'),
      new MyTile('Samsung'),
      new MyTile(
        'OnePlus',
        <MyTile>[
          new MyTile('1'),
          new MyTile('2'),
          new MyTile('3'),
          new MyTile('4'),
          new MyTile('5'),
          new MyTile('6'),
          new MyTile('7'),
          new MyTile('8'),
          new MyTile('9'),
          new MyTile('10'),
          new MyTile('11'),
          new MyTile('12'),
        ],
      ),
    ],
  ),
];