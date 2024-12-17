import 'package:cinemagic/Models/auth.dart';
import 'package:cinemagic/Screens/sign.dart';
import 'package:flutter/material.dart';

class userInfo extends StatelessWidget {
  const userInfo({super.key});

  void _signout(BuildContext ctx) async {
    bool res = await authServices().signOut_Fun();
    if (res) {
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => signScreen(type: "i"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _signout(context);
          },
          child: Text("SignOut"),
        ),
      ),
    );
  }
}
