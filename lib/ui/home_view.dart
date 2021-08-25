import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vision_aid/tflite/recognition.dart';
import 'package:vision_aid/tflite/stats.dart';
import 'package:vision_aid/ui/box_widget.dart';
import 'package:vision_aid/ui/camera_view_singleton.dart';
import 'package:volume_watcher/volume_watcher.dart';

import 'camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _has_started = false;

  /// Results to draw bounding boxes
  List<Recognition> results;

  /// Realtime stats
  Stats stats;

  /// Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
                        CameraViewSingleton.startPredicting = _has_started;
                      });
                    },
                    child: _has_started ? Text("STOP") : Text("START"))),
          ),

          Align(
            child: SizedBox(
              child: VolumeWatcher(
                onVolumeChangeListener: (double volume) {
                  setState(() {
                    _has_started = !_has_started;
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
