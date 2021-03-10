import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grow_it/model/post.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailScreen extends StatelessWidget {
  final List<Post> posts;
  final int index;

  const DetailScreen({this.posts, this.index});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: index);

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const MoveLeftIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const MoveRightIntent(),
        LogicalKeySet(LogicalKeyboardKey.escape): const CloseIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          MoveLeftIntent: CallbackAction<MoveLeftIntent>(
            onInvoke: (MoveLeftIntent intent) => {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              )
            },
          ),
          MoveRightIntent: CallbackAction<MoveRightIntent>(
            onInvoke: (MoveRightIntent intent) => {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              )
            },
          ),
          CloseIntent: CallbackAction<CloseIntent>(
              onInvoke: (CloseIntent intent) => {Navigator.of(context).pop()})
        },
        child: Focus(
          autofocus: true,
          child: Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(posts[index].largeImageURL),
                  initialScale:
                      PhotoViewComputedScale.contained * 0.99, //cat bug
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: posts[index].largeImageURL),
                );
              },
              itemCount: posts.length,
              backgroundDecoration: null,
              pageController: _pageController,
              onPageChanged: null, //
            ),
          ),
        ),
      ),
    );
  }
}

class MoveLeftIntent extends Intent {
  const MoveLeftIntent();
}

class MoveRightIntent extends Intent {
  const MoveRightIntent();
}

class CloseIntent extends Intent {
  const CloseIntent();
}
