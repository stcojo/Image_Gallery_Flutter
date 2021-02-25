import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: new BoxDecoration(
                color: Colors.grey[800],
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0),
                )),
            height: height * 0.6,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Email"), Text("Password")],
            ),
          ),
        ],
      ),
    );
  }
}
