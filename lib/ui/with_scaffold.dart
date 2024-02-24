import 'package:flutter/material.dart';

extension WithScaffold on Widget {
  Widget withScaffold() => Scaffold(
    body: this,
  );
}

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder().withScaffold();
  }
}
