import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_page.dart';
import '../services/controller.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({required this.sessionCompleted, Key? key})
      : super(key: key);

  final bool sessionCompleted;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Well done!',
        style: TextStyle(
            fontFamily: 'ConcertOne-Regular',
            fontStyle: FontStyle.normal,
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (sessionCompleted) {
                Provider.of<Controller>(context, listen: false).reset();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()));
              } else {
                Provider.of<Controller>(context, listen: false)
                    .requestWord(request: true);
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'New word',
              style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'ConcertOne-Regular',
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
        )
      ],
    );
  }
}
