import 'package:dio/dio.dart';
import 'package:drag_down_to_pop/drag_down_to_pop.dart';
import 'package:grow_it/components/tile.dart';
import 'package:grow_it/model/post.dart';
import 'package:grow_it/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<dynamic> _lista;
  List<Post> convertedList;
  bool _isLoading = true;
  ScrollController _scrollController;
  List<Post> posts = [];
  int page = 1;
  Future<dynamic> fetchData() async {
    var url = env['PIXABAYURL'];

    try {
      print("Fetching data on page $page...");
      final response = await Dio().get('$url&page=$page');
      if (response.statusCode == 200) {
        setState(
          () {
            page++;
            final List t =
                response.data["hits"]; //dio does json decode automatically
            posts.addAll(t.map((item) => Post.fromJson(item)).toList());
            _isLoading = false;
          },
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(() => _scrollListener());
    fetchData();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 250 &&
        !_scrollController.position.outOfRange) {
      if (!_isLoading) {
        fetchData();
      }
      //print("reached bottom, should load more");
    }
  }

  _openDetail(context, index) {
    final route = ImageViewerPageRoute(
        builder: (context) => DetailScreen(posts: posts, index: index));
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
            posts.add(
              new Post(
                  42,
                  "https://cdn.pixabay.com/photo/2016/04/04/15/30/girl-1307429_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2016/04/04/15/30/girl-1307429_960_720.jpg",
                  100),
            );
          });
        },
      ),
      body: !_isLoading
          ? Center(
              child: Container(
                child: GridView.builder(
                  itemCount: posts.length,
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 3 : 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Tile(
                      index: index,
                      url: posts[index].largeImageURL,
                      callback: () => _openDetail(context, index),
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}

class ImageViewerPageRoute extends MaterialPageRoute {
  ImageViewerPageRoute({@required WidgetBuilder builder})
      : super(builder: builder, maintainState: false);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return const DragDownToPopPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }

  @override
  bool canTransitionFrom(TransitionRoute previousRoute) {
    return false;
  }

  @override
  bool canTransitionTo(TransitionRoute nextRoute) {
    return false;
  }
}
