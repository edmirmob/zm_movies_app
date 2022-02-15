import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Content extends StatelessWidget {
  final Widget child;
  final bool loading;

  const Content({Key key, @required this.child, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey,
      child: Container(
        color: Colors.grey[300],
        child: child,
      ),
    );
  }
}
