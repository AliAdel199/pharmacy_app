import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

typedef IntCallback = Function(String value);

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.width,
      required this.height,
      required this.posRight,
      required this.posTop,
      required this.textEditingController,
      required this.title,
      required this.fontSize,
      required this.maxline,
      required this.callbackAction,
      required this.onChange})
      : super(key: key);
  final double width;
  final double height;
  final TextEditingController? textEditingController;
  final IntCallback onChange;
  final int maxline;
  final double posTop;
  final double fontSize;
  final double posRight;
  final String title;

  final VoidCallback callbackAction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: posTop,
      right: posRight,
      child: Container(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            onSubmitted: onChange,

            // onChanged: onChange,

            controller: textEditingController,
            maxLines: maxline,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: fontColor,
            ),

            decoration: InputDecoration(
              filled: true,
              fillColor: textFieldFill,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(width * 0.05)),
            ),
          ),
        ),
        width: width,
        height: height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.05),
          color: textFieldFill,
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
