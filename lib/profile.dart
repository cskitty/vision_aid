import 'package:flutter/material.dart';
import 'settings.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  // Circle avatar, name, age
  //

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //TextEditingController  = TextEditingController();
  @override


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }

}



