import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.posRight,
      required this.posTop,
      required this.title,
      required this.callbackAction})
      : super(key: key);
  final double width;
  final double height;
  final double posTop;
  final double posRight;
  final String title;
  final VoidCallback callbackAction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: posTop,
      right: posRight,
      child: GestureDetector(
        onTap: callbackAction,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.1),
                  color: const Color.fromARGB(150, 255, 255, 255),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.035),
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.1),
                      gradient: const LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          Color(0xff97d4ca),
                          Color(0xff547670),
                          Color(0xff4c6a65)
                        ],
                        stops: [0.0, 0.814, 1.0],
                      ),
                      boxShadow:  [
                        BoxShadow(
                          color:fontColor,
                          offset: Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                              fontSize: width * 0.16,
                            ))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
