import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MovieImageWidget extends StatelessWidget {
  const MovieImageWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
        //    fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(ImagePathEnum.notFoundImage.pathValue);
        },
        placeholder: ImagePathEnum.loadingGif.pathValue,
        image: imagePath);
  }
}
