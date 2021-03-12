import 'package:flutter/material.dart';

class ButtonRight extends StatelessWidget {
  const ButtonRight({
    Key key,
    @required PageController pageController,
    @required bool visible,
  })  : _pageController = pageController,
        _visible = visible,
        super(key: key);

  final PageController _pageController;
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
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(25, 25, 25, 0.4), // button color
                child: InkWell(
                  splashColor: Colors.white, // inkwell color
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
