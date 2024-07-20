import 'package:flutter/material.dart';
import 'package:nike_store/globalColor/colorsHex.dart';

// ignore: must_be_immutable
class FirstSlide extends StatelessWidget {
  FirstSlide({
    super.key,
    required this.color1,
    required this.color2,
    required this.imageStr,
    required this.brand,
    required this.name,
    required this.price,
    required this.onTap,
  });
  Color color1, color2;
  String imageStr, brand, name, price;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
          // width: 600,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color1, color2]),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  imageStr,
                  height: 150,
                  width: 170,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      brand,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: GlobalColors.offWhite),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: GlobalColors.offWhite),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          price,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: GlobalColors.offWhite),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 140,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: GlobalColors.blue,
                                ),
                                Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: GlobalColors.blue,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
