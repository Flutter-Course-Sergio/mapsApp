import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMsg(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Espere por favor'),
              content: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 10),
                child: const Column(
                  children: [
                    Text('Calculando ruta'),
                    SizedBox(height: 10),
                    CircularProgressIndicator(
                        strokeWidth: 3, color: Colors.black)
                  ],
                ),
              ),
            ));
    return;
  }

  showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
            title: Text('Espere por favor'),
            content: CupertinoActivityIndicator(),
          ));
}
