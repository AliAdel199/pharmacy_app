import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

typedef IntCallback = Function(String value);

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.width,
      required this.height,
      required this.onChange,
      required this.maxline,
      required this.readOnly,
      required this.textEditingController})
      : super(key: key);
  final double width;
  final double height;
  final TextEditingController? textEditingController;
  final IntCallback onChange;
  final int maxline;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          textAlign: TextAlign.center,
          // onSubmitted: onChange,
          onSubmitted: onChange,
          readOnly: readOnly,

          // onChanged: onChange,

          controller: textEditingController,
          maxLines: maxline,
          // style: GoogleFonts.tajawal(
          //   textStyle: Theme.of(context).textTheme.headline4,
          //   fontSize: height * 0.023,
          //   fontWeight: FontWeight.w900,
          //   fontStyle: FontStyle.italic,
          //   color: fontColor,
          // ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
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
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: fontColor,
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}
