import 'package:flutter/material.dart';

import '../constant.dart';

typedef IntCallback = Function(String value);

class InvoiceTextField extends StatelessWidget {
  const InvoiceTextField(
      {Key? key,
      required this.width,
      required this.height,
      required this.maxLine,
      this.textEditingController,
      required this.callbackAction,
      required this.onChange})
      : super(key: key);

  final double width;
  final double height;
  final TextEditingController? textEditingController;
  final int maxLine;
  final VoidCallback callbackAction;
  final IntCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.01),
        color: Colors.white70,
        boxShadow:  [
          BoxShadow(
            color: fontColor,
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
      ),
      // color: Colors.white70,
      width: width,
      height: height,
      child: TextField(
        textDirection: TextDirection.rtl,
        maxLines: maxLine,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(width * 0.01))),
        style: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: fontColor,
        ),
        
        controller: textEditingController,
        onTap: callbackAction,
        onSubmitted: onChange,
        onChanged: onChange,
      ),
    );
  }
}
