import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'profile.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'tts_settings.dart';
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
  FlutterTts flutterTts;
  dynamic languages;
  String language;

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;



  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    print("print ${languages}");
    if (languages != null) setState(() => languages);
  }


  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) =>
              setState(() {
                _text = val.recognizedWords;
                print(_text);
                //if (val.hasConfidenceRating && val.confidence > 0) {
                //_confidence = val.confidence;
                //}
                // if (_text == "open object detector" || _text == "open object recognition" || _text == "object detection" || _text == "object recognizer" ||_text == "detect objects"|| _text == "recognize objects"){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HomePage(cameras))
                //   );
                // }
                // if (_text == "open letter recognition"){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LetterRecognitionPage(title: "Letter Recognition"))
                //   );
                // }
                // if (_text == "open settings"){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => SettingPage(title: "Settings"))
                //   );
                //};
                // if (_text == "Mute??"){
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => LetterRecognitionPage(title: "Letter Recognition"))
                //   );
                // }
              }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    stt.SpeechToText _speech = stt.SpeechToText();
    _speech = stt.SpeechToText();
    _getLanguages();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex:25,
                child: Container (
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('KH'),
                    ),
                    title: Text("Profile"),
                    subtitle: Text("Kathy"),
                    onTap:  () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage())
                    ),
                    trailing:  Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24.0,
                      color: Colors.black54,
                    ),

                  ),
                )
            ),
            Expanded(
                flex:55,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      languages != null ? _languageDropDownSection() : Text(""),
                      _buildSliders()
                    ]))
            ),
            Expanded(
              flex: 20,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                    ),
                    onPressed: () {
                      _listen();

                      //Navigator.push(
                      //  context,
                      //MaterialPageRoute(builder: (context) => SpeechRecognitionPage(title:'Speech Recognition'))
                      //);
                    },
                    child: Text(
                      'Speech Recognition',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),)
                ),
              ),
            ),


          ],

        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _languageDropDownSection() =>
      Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            DropdownButton(
              //value: language,
              //items: getLanguageDropDownMenuItems(language),
              //onChanged: changedLanguageDropDownItem,
            )
          ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Slider(
        value: TTSsettings.newVolume,
        onChanged: (newVolume) {
          setState(() => TTSsettings.newVolume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $TTSsettings.newVolume");
  }

  Widget _pitch() {
    return Slider(
      value: TTSsettings.newPitch,
      onChanged: (newPitch) {
        setState(() => TTSsettings.newPitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $TTSsettings.newPitch,",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: TTSsettings.newRate,
      onChanged: (newRate) {
        setState(() => TTSsettings.newRate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: $TTSsettings.newRate",
      activeColor: Colors.green,
    );
  }
}



