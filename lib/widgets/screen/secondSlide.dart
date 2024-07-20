import 'package:flutter/material.dart';
import 'package:nike_store/globalColor/colorsHex.dart';

// ignore: must_be_immutable
class SecondSlide extends StatelessWidget {
  SecondSlide({super.key, required this.img, required this.text});
  String img, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 50,
            height: 50,
            child: Center(
              child: Image.asset(
                img,
                height: 30,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: GlobalColors.lightergray,
            )),
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ],
    );
  }
}
