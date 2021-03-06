// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  final CountDownController _controller = CountDownController();
  bool _isPause = false;

  TextEditingController idController = TextEditingController();
  TextEditingController namController = TextEditingController();
  TextEditingController tarController = TextEditingController();

  ApiService apiService = ApiService();
  SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            Column(
              children: [
                SizedBox(height: 30.0),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Id",
                    fillColor: Colors.white,
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: namController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Nombre",
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: tarController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    hintText: "Tarea",
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      Info data = await apiService
                          .getInfoId(int.parse(idController.text));
                      getData(data, idController, namController, tarController);
                    },
                    child: Text('Obtener info'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                Center(
                  child: CircularCountDownTimer(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    duration: 1500,
                    fillColor: Colors.redAccent,
                    //controller: _controller,
                    backgroundColor: Colors.white54,
                    strokeWidth: 10.0,
                    strokeCap: StrokeCap.round,
                    isTimerTextShown: true,
                    isReverse: true,
                    onComplete: () {
                      Alert(
                              context: context,
                              title: 'Done',
                              style: AlertStyle(
                                isCloseButton: true,
                                isButtonVisible: false,
                                titleStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                ),
                              ),
                              type: AlertType.success)
                          .show();
                    },
                    textStyle: TextStyle(fontSize: 50.0, color: Colors.black),
                    ringColor: Colors.red,
                  ),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      if (_isPause) {
                        _isPause = false;
                        _controller.resume();
                      } else {
                        _isPause = true;
                        _controller.pause();
                      }
                    });
                  },
                  icon: Icon(
                    _isPause ? Icons.play_arrow : Icons.pause,
                  ),
                  label: Text(
                    _isPause ? 'Resume' : 'Pause',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getData(
    Info data,
    TextEditingController id,
    TextEditingController nam,
    TextEditingController tar,
  ) {
    id.text = data.api.toString();
    nam.text = data.name.toString();
    tar.text = data.tarea.toString();
  }
}
