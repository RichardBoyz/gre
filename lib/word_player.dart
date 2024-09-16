import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordPlayer extends StatefulWidget {
  final String word;
  final String meaning;
  const WordPlayer({super.key, required this.word, required this.meaning});

  @override
  State<WordPlayer> createState() => _WordPlayerState();
}

class _WordPlayerState extends State<WordPlayer> {
  late FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> speak() async {
    await _flutterTts.speak(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: speak, iconSize: 100, icon: Icon(Icons.play_circle));
  }
}
