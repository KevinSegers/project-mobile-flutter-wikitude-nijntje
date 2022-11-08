import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavoriteItem extends StatefulWidget {
  final bool favorite;
  // final Function changefavorite;

  const FavoriteItem({
    Key? key,
    required this.favorite,
  }) // eventueel erin ???? required this.changefavorite
  : super(key: key);

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(child: widget.favorite ? filledStar : emptyStar);
  }
}

IconButton filledStar = IconButton(
    enableFeedback: true,
    iconSize: 30,
    color: Colors.yellow,
    icon: const Icon(Icons.star),
    onPressed: () {
      //_changeFavorite();
    });

IconButton emptyStar = IconButton(
    enableFeedback: true,
    iconSize: 30,
    color: Colors.yellow,
    icon: const Icon(Icons.star_outline_outlined),
    onPressed: () {
      // _changeFavorite();
    });
