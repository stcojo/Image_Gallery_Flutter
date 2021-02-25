import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
          print(data[0]["title"]);
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

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.orange,
            strokeWidth: 8,
          ))
        : StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 32,
            itemBuilder: (BuildContext context, int index) => Container(
              color: Colors.green,
              child: Material(
                child: InkWell(
                  onTap: () {
                    title = _lista[index]["title"];
                    thumbnailUrl = _lista[index]["thumbnailUrl"];

                    showBarModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Center(
                        child: Column(
                          children: [
                            Text("Exemplu"),
                            //Text("Elementul $index cu url $_lista[$index]")
                          ],
                        ),
                      ),
                    );
                  },
                  child: FittedBox(
                      child: Image.network(_lista[index]["thumbnailUrl"]),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
  }
}
