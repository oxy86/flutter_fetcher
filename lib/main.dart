import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

late String nothingLabel;

void main() {
  nothingLabel = 'no \u2665 ♥ yet 😆 \u{1f606}';
  
  final pipa = Random().nextDouble();
  print (pipa);
  print (pipa.hashCode); 
  print (pipa is int); 

  int pipa2 = ( pipa*100) ~/ 1;

  print (pipa2); 
  print (pipa2.hashCode); 
  print (pipa2 is int); 

  double? pipa3 = pipa2.toDouble();

  print (pipa3); 
  print (pipa3.hashCode); 
  print (pipa3 is int); 


  print (pipa2/2 ==pipa3/2); 

  // List<num> list;
  var list = <num>{};
  list = {pipa, pipa2};

  print(list.runtimeType);

  Set<String> list2 = {'mitsos', 'mitsi'};

  for (var element in list2) {
    print(element);
  }


  
  Set<String> names = {}; // This works, too.
  print(names.runtimeType);

  var names2 = {1: '2'}; // This works, too. 
  names2[1]='dddd';
  print(names2);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var title = 'Flutter fetcher';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MyHome'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  var post = Post(0,0,'','');

  Future<Post> doFetchData() async {
    var random = Random();
    final httpPackageUrl = Uri.https('jsonplaceholder.typicode.com', '/posts/${random.nextInt(100)}' );
    final httpPackageResponse = await http.get(httpPackageUrl);
    if (httpPackageResponse.statusCode != 200) {
      print('Failed to retrieve!');
      return Post(0,0,'','');
    }
    final json = jsonDecode(httpPackageResponse.body);
    
    setState(() {
      counter++; 
      post = Post(json['userId'], json['id'], json['title'], json['body']);
    });
    return post;
  }



  void _fetchData() {
    doFetchData();

  }

  @override
  Widget build(BuildContext context) {


    // This method is rerun every time setState is called, for instance as done
    // by the _fetchData method above.

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count $counter',
            ),
            ResultWidget(post: post),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchData,
        tooltip: 'Get',
        child: const Icon(Icons.get_app),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {

    if (post.title.isEmpty) {
      return Text(
        nothingLabel,
        style: Theme.of(context).textTheme.headlineMedium,
      );
    } else {
      return post.toColumn(Theme.of(context).textTheme.headlineMedium);
    }

  }
}


class Post {
  final int userId, id;
  final String title;
  String? body;

  String label = 'Result';

  Post(this.userId, this.id, this.title, this.body);

  @override
  String toString() {
    return 'Post $id by user: $userId \n'
    'Title: $title \n'
    'Body: $body';
  }

  Column toColumn(style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(label),
      Text('Post $id', style: style),
      Text('user: $userId',style: style),
      Text('Title: $title',style: style),
      Text('Body: $body',style: style),
    ],
    );
  }
}


class Package {
  final String name, latestVersion;
  String? description;

  Package(this.name, this.latestVersion, this.description);

  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';
  }
}

