import 'dart:html';

import 'package:flutter/material.dart';
import 'package:aplayer/player.dart';
import 'package:aplayer/widget_progress.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final audio = APlayer("test.mp3");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              children: <Widget>[
                RaisedButton(
                    onPressed: () => audio.stop(), child: Text("stop")),
              ],
            ),
            LinearAudioBar(
              player: audio,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => audio.playPause(),
        child: Icon(Icons.play_arrow),
      ), 
    );
  }
}
