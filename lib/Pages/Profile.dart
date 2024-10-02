import 'package:delivery/theme/Colors.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late FocusNode myFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,
      body: TextField(
        focusNode: myFocusNode,

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        myFocusNode.requestFocus();
      },),
    );
  }
}
