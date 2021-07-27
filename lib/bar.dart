import 'package:vision_aid/letter_rec.dart';
import 'package:flutter/material.dart';
import 'detector.dart';

class BarPage extends StatefulWidget {
  BarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BarPageState createState() => _BarPageState();
}

class _BarPageState extends State<BarPage> {
  int _currentIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _children= [
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.mic),
                label: 'Speak',

                backgroundColor: Colors.lightBlueAccent,

              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.lightBlueAccent
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  backgroundColor: Colors.lightBlueAccent
              ),
            ],

            //currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            backgroundColor: Colors.lightBlueAccent
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.mic),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
