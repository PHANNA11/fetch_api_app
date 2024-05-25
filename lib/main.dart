import 'dart:developer';

import 'package:fetch_api_app/controller/posts_controller.dart';
import 'package:fetch_api_app/model/posts_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<PostsModel> listAllPost = [];
  getAPIs() async {
    await PostsController().getAllPosts().then((value) {
      setState(() {
        listAllPost = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAPIs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: listAllPost.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(listAllPost[index].title.toString()),
            ),
          ),
        ));
  }
}
