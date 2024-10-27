import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Show Menu Example')),
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () async {
                  // 显示菜单
                  await showMenu<String>(
                    context: context,
                    position: const RelativeRect.fromLTRB(
                        100, 100, 100, 100), // 菜单的位置
                    items: [
                      const PopupMenuItem<String>(
                        value: 'item1',
                        child: Text('Item 1'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'item2',
                        child: Text('Item 2'),
                      ),
                    ],
                    elevation: 8.0,
                  ).then((String itemSelected) {
                    if (kDebugMode) {
                      print(itemSelected);
                    }
                  } as FutureOr<Null> Function(String? value));
                },
                child: const Text('Tap to show menu'),
              );
            },
          ),
        ),
      ),
    );
  }
}
