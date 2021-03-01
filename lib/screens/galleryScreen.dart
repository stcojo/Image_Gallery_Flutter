import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:grow_it/screens/detailScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<dynamic> _lista;
  bool _isLoading = true;

  Future<dynamic> fetchData() async {
    var url = env['URL'];

    final response = await http.get('$url');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(
        () {
          _lista = data;
          _isLoading = false;
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  _openDetail(context, index) {
    final route = MaterialPageRoute(
      builder: (context) => DetailPage(url: _lista[index]["url"]),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('random dynamic tile sizes'),
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          setState(() {
            List<dynamic> test = [
              {
                "id": "42",
                "createdAt": "2021-02-26T09:22:48.418Z",
                "title": "transition",
                "url":
                    "https://cdn.pixabay.com/photo/2016/04/04/15/30/girl-1307429_960_720.jpg",
                "description": "China"
              }
            ];
            _lista.addAll(test);
          });
        },
      ),
      body: !_isLoading
          ? StaggeredGridView.countBuilder(
              itemCount: _lista.length,
              primary: false,
              crossAxisCount: 4,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemBuilder: (context, index) => new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26.0),
                  child: Container(
                    color: Colors.grey[850],
                    child: new Column(
                      children: <Widget>[
                        GestureDetector(
                          child: Hero(
                            tag: _lista[index]["url"],
                            child: Center(
                              child: new FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: _lista[index]["url"],
                              ),
                            ),
                          ),
                          onTap: () => _openDetail(context, index),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Column(
                            children: <Widget>[
                              new Text(
                                'Image number $index',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                'Width: ',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              new Text(
                                'Height: ',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
            )
          : null,
    );
  }
}
