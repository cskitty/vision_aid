// import 'package:flutter/material.dart';
// import 'package:vision_aid/user_info.dart';
// import 'package:vision_aid/user_preferences.dart';
// import 'settings.dart';
// import 'package:flutter/cupertino.dart';
// import 'profile_widget.dart';
// class ProfilePage extends StatefulWidget {
//   ProfilePage({Key key, this.title}) : super(key: key);
//
//   // Circle avatar, name, age
//   //
//
//   final String title;
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//
//   //TextEditingController  = TextEditingController();
//   @override
//
//
//   Widget build(BuildContext context) {
//   final user = UserPreferences.myUser;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//
//       ),
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           ProfileWidget(
//             imagePath: user.imagePath,
//             onClicked: () async {},
//           ),
//           const SizedBox(height:25),
//           buildName(user),
//
//         ],
//       ),
//     );
//   }
//
//   Widget buildName(User user) => Column(
//     children: [
//       Text(user.name,
//       style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 24,
//       ),
//       ),
//     ],
//   );
//
// }
//
//
//
