import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/controller.dart';

class Drag extends StatefulWidget {
  const Drag({required this.letter, super.key});

  final String letter;

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return _accepted
        ? const SizedBox()
        : Draggable(
            data: widget.letter,
            childWhenDragging: const SizedBox(),
            onDragEnd: (details) {
              if (details.wasAccepted) {
                _accepted = true;
                setState(() {});
                Provider.of<Controller>(context, listen: false)
                    .incrementLetters(context: context);
              }
            },
            feedback: Text(
              widget.letter,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                shadows: [
                  Shadow(
                    offset: const Offset(3, 3),
                    color: Colors.black.withOpacity(0.40),
                    blurRadius: 5,
                  ),
                ],
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                  fontFamily: 'ConcertOne-Regular',
                fontStyle: FontStyle.italic

              ),
            ),
            child: Text(
              widget.letter,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  fontFamily: 'ConcertOne-Regular',
                  fontStyle: FontStyle.italic
                  ),
            ),
          );
  }
}
