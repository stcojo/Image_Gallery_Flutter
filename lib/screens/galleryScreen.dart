import 'package:dio/dio.dart';
import 'package:drag_down_to_pop/drag_down_to_pop.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grow_it/components/tile.dart';
import 'package:grow_it/model/post.dart';
import 'package:grow_it/screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _isLoading = true;
  ScrollController _scrollController;
  List<Post> posts = [];
  int page = 1;
  String search = "plant";

  Future<dynamic> fetchData() async {
    var url = env['PIXABAYURL'];

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Dio().get('$url&page=$page&q=$search');
      if (response.statusCode == 200) {
        final List t =
            response.data["hits"]; //dio does json decode automatically
        setState(
          () {
            page++;
            posts.addAll(t.map((item) => Post.fromJson(item)).toList());
            _isLoading = false;
          },
        );

        Fluttertoast.showToast(
            msg: "Loaded page $page, size is ${posts.length}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
        /* print("Should load more");
        print("Offset ${_scrollController.offset}");
        print("Max extent ${_scrollController.position.maxScrollExtent}"); */
        fetchData();
      }
      //print("reached bottom, should load more");
    }
  }

  _openDetail(context, index) {
    final route = ImageViewerPageRoute(
      builder: (context) => DetailScreen(posts: posts, index: index),
    );
    Navigator.push(context, route);
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();

    return FloatingSearchBar(
      hint: 'Caută imagini...',

      controller: controller,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 100),
      clearQueryOnClose: false,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        setState(() {
          search = query;
        });
      },
      onSubmitted: (query) {
        controller.close();
        setState(() {
          page = 1;
          posts.clear();
        });
        fetchData();
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        final List<String> entries = <String>[
          "Flutter",
          "Dart",
          "React Native",
          "Android",
          "iOS",
        ];

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: entries.asMap().entries.map((entry) {
                  int index = entry.key;

                  var w = GestureDetector(
                    onTap: () {
                      print("Tapped index $index");
                    },
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Icon(Icons.history),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("${entry.value}"),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                  return w;
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
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
          ),
          buildFloatingSearchBar(),
        ],
      ),
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
