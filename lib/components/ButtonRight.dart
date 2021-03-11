import 'package:flutter/material.dart';

class ButtonRight extends StatelessWidget {
  const ButtonRight({
    Key key,
    @required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
