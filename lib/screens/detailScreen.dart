import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grow_it/model/post.dart';

class DetailPage extends StatelessWidget {
  final List<Post> posts;
  final int index;

  const DetailPage({this.posts, this.index});

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: this.url,
          child: Image.network(
            this.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fullscreen sliding carousel demo')),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              initialPage: index,
              enableInfiniteScroll: false,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              // autoPlay: false,
            ),
            items: posts
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item.url,
                        fit: BoxFit.contain,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
