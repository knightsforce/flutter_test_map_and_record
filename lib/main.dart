import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:isolate';

void main() => runApp(MyApp());

FlutterSound flutterSound = new FlutterSound();

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
  String _text = 'Остановлено';
  bool _isRun = false;
  var _recorderSubscription;

  void _incrementCounter() {
    
    if(_isRun) {

      _stopRecord();

    } else {

      _runRecord();

    }

    setState(() {
      _isRun = !_isRun;
    });
  }

  _runRecord() async {
    _text = 'Запущено';
    await _record();


  //   _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
  //   DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
  //   _text = date.toIso8601String();
  // });

  }

  _stopRecord() async {

    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');

    _text = 'Остановлено';

    // if (_recorderSubscription != null) {
    //   _recorderSubscription.cancel();
    //   _recorderSubscription = null;
    // }

  }

  _record() async {
    String path = await flutterSound.startRecorder(null);
    print('startRecorder: $path');
  }

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
            Text(
              '$_text',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
