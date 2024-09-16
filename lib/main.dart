import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gre/word_player.dart';

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
  List words = [];
  String word = '';
  String meaning = '';

  @override
  void initState() {
    super.initState();
    loadWordList();
  }

  Future<void> loadWordList() async {
    final String response =
        await rootBundle.loadString('assets/dictionary.json');
    final stringData = await json.decode(response);
    words = stringData['object'];

    loadWord();
  }

  void loadWord() {
    if (words.isEmpty) {
      print('words is empty');
      return;
    }

    final random = Random();
    final randomWord = words[random.nextInt(words.length)];
    setState(() {
      word = randomWord['word'];
      meaning = randomWord['meaning'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: loadWord,
                    iconSize: 100,
                    icon: const Icon(Icons.restart_alt_rounded)),
                WordPlayer(word: word, meaning: meaning)
              ],
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  word,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 36),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Text(
                    meaning,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 24),
                  ),
                ))
              ],
            ))
          ],
        ),
      )),
    );
  }
}
