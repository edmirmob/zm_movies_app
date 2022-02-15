import 'package:flutter/material.dart';
import './current_context.dart';

Future<void> showAlertDialog(String title, String message) {
  final theme = Theme.of(getCurrentContext());
  return showDialog(
    context: getCurrentContext(),
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          backgroundColor: const Color(0xff093545),
          title: Text(title,
              style: theme.textTheme.bodyText1),
          content: Text(message,
              style: theme.textTheme.subtitle1.copyWith(height: 2)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    },
  );
}
