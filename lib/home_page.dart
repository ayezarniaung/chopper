import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopper_demo/data/post_api_service.dart';
import 'package:chopper_demo/single_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Provider.of<PostApiService>(context).postPosts(
            {'key': 'value'},
          );
          return response.body;
        },
      ),
    );
  }
}

FutureBuilder<Response> _buildBody(BuildContext context) {
  return FutureBuilder<Response>(
    future: Provider.of<PostApiService>(context).getPosts(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List post = json.decode(snapshot.data!.bodyString);
        return _buildPost(context, post);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

ListView _buildPost(BuildContext context, List post) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          title: Text(
            post[index]['title'],
          ),
          onTap: () => _navigateToPost(context, post[index]['id']),
        ),
      );
    },
    padding: const EdgeInsets.all(8),
    itemCount: post.length,
  );
}

void _navigateToPost(BuildContext context, int id) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SinglePostPage(postId: id),
    ),
  );
}
