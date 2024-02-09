import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';

class OrientedSizedBox extends StatelessWidget {
  final Size size;
  final Widget? child;
  final double fraction;

  const OrientedSizedBox({
    super.key,
    required this.size,
    this.child,
    this.fraction = 1 / 3,
  });

  @override
  Widget build(BuildContext context) {
    bool fullHeight = size.orientation() == SizeOrientation.paysage;
    return SizedBox(
      width: size.width * (fullHeight ? fraction : 1),
      //height: fullHeight ? double.infinity : null,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: child,
      ),
    );
  }
}
