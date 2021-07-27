import 'package:vision_aid/letter_rec.dart';
import 'package:flutter/material.dart';
import 'detector.dart';
import 'speech_recognition2.dart';
import 'speech_recognition.dart';
import 'ui/home_view.dart';

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
              flex:20,
              child: Container(
                margin: EdgeInsets.only(left:10,right:10,top:20,bottom: 5),
                child: const Image(
                  image: NetworkImage('https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png'),
                ),
              ),
            ),
            Expanded(
                flex:25,
                child:
                Container(
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
              flex:25,
                child: Container(
                  margin: EdgeInsets.only(left:10,right:10,top:10,bottom:10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.indigoAccent),
                  ),

                      onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LetterRecognitionPage(title:'Letter Recognition'))
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
                flex:25,
                child: Container(
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

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.mic),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
