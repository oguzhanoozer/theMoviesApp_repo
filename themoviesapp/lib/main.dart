import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themoviesapp/core/modules/environment.dart';

import 'core/init.dart';
import 'product/route/generate_route.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      builder: MainBuild.build,
      onGenerateRoute: RouterGen.generateRoute,
      initialRoute: movieListViewRoute,
    );
  }
}
