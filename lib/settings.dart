import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.title}) : super(key: key);

  //GOALS
  // 1. Audio Settings (for Text to Speech): volume, pitch, male/female, language
  //

  final String title;

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController functionController = TextEditingController();
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
            Expanded(
              flex: 20,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                child: TextField(
                  controller: functionController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Function',
                  ),
                ),
              ),
            ),

          ],

        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

}



