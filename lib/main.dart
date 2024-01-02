import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  Image? showImage;

  Image imageFromByte64(String byte64String){
    Uint8List byteImage = const Base64Decoder().convert(byte64String);

    return Image.memory(byteImage);
  }

  void _incrementCounter() async {
    var response = await get(Uri.parse('http://127.0.0.1:5000/img'));
    var jsonData = jsonDecode(response.body);

    showImage = imageFromByte64(jsonData['img']);

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("build! $_counter, ${showImage==null}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(showImage != null)
              Image(
                width: 500,
                image: showImage!.image,
                gaplessPlayback: true,
              ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
