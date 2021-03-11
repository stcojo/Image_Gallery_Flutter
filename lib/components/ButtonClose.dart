import 'package:flutter/material.dart';

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    Key key,
    @required bool visible,
  })  : _visible = visible,
        super(key: key);

  final bool _visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      // The green box must be a child of the AnimatedOpacity widget.
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: ClipOval(
            child: Material(
              color: Color.fromRGBO(255, 172, 0, 0.6), // button color
              child: InkWell(
                splashColor: Colors.orange[100], // inkwell color
                child: SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(Icons.close),
                ),
                onTap: () {
                  if (_visible) Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
