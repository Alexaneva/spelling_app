import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:spelling_app/widgets/message_box.dart';

import '../widgets/all_words.dart';

class Controller extends ChangeNotifier {
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;
  bool generateWord = true, sessionCompleted = false, letterDropped = false;
  double percentCompleted = 0;

  setUp({required int total}) {
    lettersAnswered = 0;
    totalLetters = total;
    notifyListeners();
  }

  incrementLetters({required BuildContext context}) {
    lettersAnswered++;
    updateLetterDropped(dropped: true);
    if (lettersAnswered == totalLetters) {
      AudioCache().loadAsset('assets/audio/Correct_2.mp3');
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      if (wordsAnswered == allWords.length) {
        sessionCompleted = true;
      }
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => MessageBox(
                sessionCompleted: sessionCompleted,
              ));
    } else {
      AudioCache().loadAsset('assets/audio/Correct_1.mp3');
    }
    notifyListeners();
  }

  requestWord({required bool request}) {
    generateWord = request;
    notifyListeners();
  }

  updateLetterDropped({required bool dropped}) {
    letterDropped = dropped;
    notifyListeners();
  }

  reset() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}
