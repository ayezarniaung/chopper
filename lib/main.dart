import 'package:chopper_demo/data/post_api_service.dart';
import 'package:chopper_demo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  _setLoggin();
  runApp(const MyApp());
}

void _setLoggin() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name}${event.time} ${event.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Provider(
        create: (_) => PostApiService.create(),
        builder: (_, __) {
          return const MaterialApp(
            title: 'Chopper Demo ',
            home: HomePage(),
          );
        },
        dispose: (_, PostApiService service) => service.client.dispose(),
      ),
    );
  }
}
