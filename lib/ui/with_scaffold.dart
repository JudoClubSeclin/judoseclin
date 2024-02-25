import 'package:flutter/material.dart';

extension WithScaffold on Widget {
  Widget withScaffold() => Scaffold(
        body: this,
      );
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder().withScaffold();
  }
}
