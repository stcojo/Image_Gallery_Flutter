import 'package:flutter/material.dart';
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

    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(posts[index].url),
            initialScale: PhotoViewComputedScale.contained * 1.0,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.1,
            heroAttributes: PhotoViewHeroAttributes(tag: posts[index].url),
          );
        },
        itemCount: posts.length,
        /* loadingBuilder: (context, progress) => Center(
           child: Container(
             width: 20.0,
             height: 20.0,
             child: CircularProgressIndicator(
               value: _progress == null
                   ? null
                   : _progress.cumulativeBytesLoaded /
                       _progress.expectedTotalBytes,
             ),
           ),
         ) */
        backgroundDecoration: null,
        pageController: _pageController,
        onPageChanged: null, //
      ),
    );
  }
}
