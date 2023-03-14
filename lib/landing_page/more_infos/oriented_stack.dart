import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class OrientedStack extends StatelessWidget {
  final SizeOrientation orientation;
  final List<Widget> children;

  const OrientedStack({
    Key? key,
    required this.orientation,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((orientation == SizeOrientation.paysage)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    } else {
      return Column(
        verticalDirection: VerticalDirection.up,
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      );
    }
  }
}