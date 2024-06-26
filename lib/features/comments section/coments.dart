import 'package:flutter/material.dart';
import 'package:genix/features/comments%20section/views/view/commentsbody.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CommentsBody(),
    );
  }
}
