import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String url;

  const DetailPage({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              //title: Text("URL #$url"),
              background: Hero(
                tag: this.url,
                child: Image.network(
                  this.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
