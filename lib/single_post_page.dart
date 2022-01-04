import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_demo/data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  const SinglePostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chopper Blog'),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPostsById(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data!.bodyString);
            return _buildPost(post);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Padding _buildPost(Map post) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Text(post['title']),
        Text(post['body']),
      ],
    ),
  );
}
