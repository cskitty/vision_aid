import 'package:vision_aid/letter_rec.dart';
import 'package:flutter/material.dart';
import 'detector.dart';
import 'speech_recognition2.dart';
import 'speech_recognition.dart';
import 'ui/home_view.dart';
import 'reference.dart';
class LaunchPage extends StatefulWidget {
  LaunchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:
      Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
                flex:30,
                child:
                Container(
                  width:double.infinity,
                  margin: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                      onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView())
                    );
                  },
                      child: Text('Object Detection',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24 ),)
                  ),
                ),
            ),
            Expanded(
              flex:30,
                child: Container(
                  width:double.infinity,
                  margin: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                  ),

                      onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReferencePage(title:'Letter Recognition'))
                    );
                  },
                      child: Text(
                        'Letter Recognition',
                        style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24 ),
                      )
                  ),

                  ),
                ),
            Expanded(
                flex:30,
                child: Container(
                  width:double.infinity,
                    margin: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                    child:ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                        ),
                        onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpeechRecognitionPage(title:'Speech Recognition'))
                      );
                    },
                        child: Text(
                          'Speech Recognition',
                          style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24 ),)
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
