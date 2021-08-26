import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vision_aid/tflite/recognition.dart';
import 'package:vision_aid/tflite/stats.dart';
import 'package:vision_aid/ui/box_widget.dart';
import 'package:vision_aid/ui/camera_view_singleton.dart';
import 'package:volume_watcher/volume_watcher.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

enum TtsState { playing, stopped }

class _HomeViewState extends State<HomeView> {
  FlutterTts flutterTts;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  bool _has_started = false;
  bool _botton_clicked = false;
  String _newVoiceText;
  bool opened = false;

  /// Results to draw bounding boxes
  List<Recognition> results;

  /// Realtime stats
  Stats stats;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // added for TTS
  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage("en-Us");
    //flutterTts.setVoice("en-us-x-sfg#male_1-local");
    flutterTts.setVolume(volume);
    flutterTts.setSpeechRate(rate);
    flutterTts.setPitch(pitch);

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak(sentence) async {
    if (!opened) {
      await flutterTts.speak(
          "My vision aid started, please use click button to start object recognition.");
      opened = true;
    }
    if (sentence != null && sentence.isNotEmpty) {
      var result = await flutterTts.speak(sentence);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    } else {
      //await flutterTts.speak("Empty or can not recognize!");
    }
    //}
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  String _getObject(results) {
    String maxLabel;
    double maxScore = 0;
    for (var r in results) {
      if (r.score > maxScore) {
        maxScore = r.score;
        maxLabel = r.label;
      }
    }
    return maxLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visual Aid'),
      ),
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, statsCallback),

          // Bounding boxes
          boundingBoxes(results),

          Align(
            alignment: Alignment(0, 0.6),
            child: SizedBox(
                height: 100, //height of button
                width: 400, //width of button
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: _has_started
                            ? Colors.red
                            : Colors.blue, //background color of button
                        side: BorderSide(
                            width: 3,
                            color: Colors.brown), //border width and color
                        elevation: 10, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding:
                            EdgeInsets.all(20) //content padding inside button
                        ),
                    onPressed: () {
                      setState(() {
                        _has_started = !_has_started;
                        _botton_clicked = !_botton_clicked;
                        if (!_botton_clicked) {
                          _speak(_newVoiceText);
                        } else {
                          _stop();
                        }
                        CameraViewSingleton.startPredicting = _has_started;
                      });
                    },
                    child: _has_started
                        ? Text(_newVoiceText)
                        : Text(_newVoiceText))),
          ),

          Align(
            child: SizedBox(
              child: VolumeWatcher(
                onVolumeChangeListener: (double volume) {
                  setState(() {
                    _has_started = !_has_started;
                    _botton_clicked = !_botton_clicked;
                    if (!_botton_clicked) {
                      _speak(_newVoiceText);
                    } else {
                      _stop();
                    }
                    CameraViewSingleton.startPredicting = _has_started;
                  });
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.access_alarm),
                  label:
                      Text((stats != null) ? '${stats.inferenceTime} ms' : ''),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(Icons.access_time_outlined),
                  label: Text(
                      (stats != null) ? '${stats.totalElapsedTime} ms' : ''),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: Icon(Icons.aspect_ratio),
                  label: Text((stats != null)
                      ? '${CameraViewSingleton.inputImageSize?.width} X ${CameraViewSingleton.inputImageSize?.height}'
                      : ''),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition> results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
      var newtext = _getObject(results);
      if (newtext != this._newVoiceText) {
        this._newVoiceText = newtext;
        _speak(newtext);
      }
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
    });
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  StatsRow(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}
