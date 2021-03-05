import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:ui' as ui;

class Tile extends StatelessWidget {
  final int index;
  final String url;
  final ui.VoidCallback callback;

  const Tile({Key key, this.index, this.url, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Hero(
        tag: url,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
