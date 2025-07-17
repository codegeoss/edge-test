import 'package:flutter/material.dart';
import 'package:test/dashboard/models/post_dto.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({this.post, super.key});
  final PostDto? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('id:${post!.id}'),
      ),
      body: Center(
        child: ListTile(
          title: Text(post!.title),
          subtitle: Text(
            post!.body,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
