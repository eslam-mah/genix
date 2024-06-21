import 'package:flutter/material.dart';

class SearchPageArgs {
  const SearchPageArgs();
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.args});
  static const String route = '/search';
  final SearchPageArgs args;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
