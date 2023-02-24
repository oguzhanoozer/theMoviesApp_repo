import 'package:flutter/material.dart';
import '../constants/application_constants.dart';

class TextFieldProduct extends StatelessWidget {
  TextFieldProduct(
      {super.key, this.onChanged, required this.textEditingController});

  final TextEditingController textEditingController;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
        key: Key(ApplicationConstants.instance.moviesNameFieldKey),
        textAlignVertical: TextAlignVertical.bottom,
        controller: textEditingController,
        decoration: _buildTextDecoration(),
        onChanged: onChanged);
  }

  InputDecoration _buildTextDecoration() {
    return InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: ApplicationConstants.instance.greyColor,
      ),
      focusColor: ApplicationConstants.instance.whiteColor,
      focusedBorder: _buildOutlinedInputBorder(),
      hintText: ApplicationConstants.instance.searchMovies,
      border: _buildOutlinedInputBorder(),
    );
  }

  OutlineInputBorder _buildOutlinedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
          color: ApplicationConstants.instance.whiteColor, width: 0.3),
    );
  }
}
