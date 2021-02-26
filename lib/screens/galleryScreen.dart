import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
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
        },
      );
      _isLoading = false;
    } else {
      _isLoading = false;
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String thumbnailUrl;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white24,
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
                  "image":
                      "https://cdn.pixabay.com/photo/2016/04/04/15/30/girl-1307429_960_720.jpg",
                  "description": "China"
                }
              ];
              _lista.addAll(test);
            });
          },
        ),
        appBar: AppBar(
          title: Text("Dynamic masonry grid"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(12),
          child: !_isLoading
              ? StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: _lista?.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: _lista[index]["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.5);
                    //return StaggeredTile.fit(1);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
