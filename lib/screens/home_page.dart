import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/controller.dart';
import '../widgets/drag.dart';
import '../widgets/drop.dart';
import '../widgets/all_words.dart';
import '../widgets/fly_in_animation.dart';
import '../widgets/progress_bar .dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _words = allWords.toList();
  late String _word, _dropWord;

  _generateWord() {
    final r = Random().nextInt(_words.length);
    _word = _words[r];
    _dropWord = _word;
    _words.removeAt(r);
    final s = _word.characters.toList()..shuffle();
    _word = s.join();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setUp(total: _word.length);
      Provider.of<Controller>(context, listen: false)
          .requestWord(request: false);
    });
  }

  _animationCompleted() {
    Future.delayed(const Duration(milliseconds: 200), () {
      Provider.of<Controller>(context, listen: false)
          .updateLetterDropped(dropped: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Controller, bool>(
      selector: (_, controller) => controller.generateWord,
      builder: (_, generate, __) {
        if (generate) {
          if (_words.isNotEmpty) {
            _generateWord();
          }
        }
        return SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.lightBlue,
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(15.0)),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 2, 2, 2),
                                  child: FittedBox(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Spelling Bee',
                                      style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Selector<Controller, bool>(
                                    selector: (_, controller) =>
                                        controller.letterDropped,
                                    builder: (_, dropped, __) => FlyInAnimation(
                                        removeScale: true,
                                        animate: dropped,
                                        animationCompleted:
                                            _animationCompleted(),
                                        child: Image.asset(
                                            'assets/images/Bee.png')),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))),
                  Expanded(
                      flex: 3,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _dropWord.characters
                              .map((e) => FlyInAnimation(
                                    animate: true,
                                    child: Drop(
                                      letter: e,
                                    ),
                                  ))
                              .toList())),
                  Expanded(
                      flex: 3,
                      child: FlyInAnimation(
                          animate: true,
                          child: Image.asset('assets/images/$_dropWord.png'))),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _word.characters
                          .map(
                            (e) => FlyInAnimation(
                              animate: true,
                              child: Drag(
                                letter: e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Expanded(flex: 1, child: ProgressBar()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
