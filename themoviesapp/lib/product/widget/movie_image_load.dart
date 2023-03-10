import 'package:flutter/material.dart';
import '../constants/application_constants.dart';

class MovieImageWidget extends StatelessWidget {
  const MovieImageWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              ImagePathEnum.notFoundImage.pathValue,
              fit: BoxFit.fill,
            );
          },
          placeholder: ImagePathEnum.loadingGif.pathValue,
          image: imagePath),
    );
  }
}
