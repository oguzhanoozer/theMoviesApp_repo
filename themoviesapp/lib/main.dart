import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themoviesapp/core/modules/environment.dart';
import 'core/init.dart';
import 'product/route/generate_route.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(TheMoviesApp());
}

class TheMoviesApp extends StatelessWidget {
  const TheMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      builder: MainBuild.build,
      onGenerateRoute: RouterGen.generateRoute,
      initialRoute: movieListViewRoute,
    );
  }
}
