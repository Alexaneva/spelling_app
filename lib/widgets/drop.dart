import 'package:flutter/material.dart';

class Drop extends StatelessWidget {
  const Drop({
    required this.letter,
    super.key,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    bool accepted = false;
    return DragTarget(onWillAccept: (data) {
      if (data == letter) {
        return true;
      } else {
        return false;
      }
    }, onAccept: (data) {
      accepted = true;
    }, builder: (context, candidateData, rejectedData) {
      if (accepted) {
        return Text(
          letter,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              fontFamily: 'ConcertOne-Regular',
              fontStyle: FontStyle.italic
              ),
        );
      } else {
        return Container(
          color: Colors.white30,
          height:70,
          width: 70,
        );
      }
    });
  }
}
