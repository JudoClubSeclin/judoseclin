import 'package:flutter/material.dart';

extension MaterialSizeRatio on Size {
  SizeOrientation orientation() {
    if (width > height) {
      return SizeOrientation.paysage;
    }
    if (height > width) {
      return SizeOrientation.portrait;
    }
    return SizeOrientation.carre;
  }

  double max() => (height > width) ? height : width;

  double headerHeight() {
    switch(orientation()) {
      case SizeOrientation.portrait:
        return height * .5;
      case SizeOrientation.paysage:
        return height * .7;
      default:
        return height * .5;
    }
  }

  double newsHeight() => height - headerHeight();
}

enum SizeOrientation {
  portrait,
  paysage,
  carre
}