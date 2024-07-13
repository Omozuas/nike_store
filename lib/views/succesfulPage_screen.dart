import 'package:flutter/material.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/widgets/bottomNav/BottomNav.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Frame.png',
                scale: .5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Payment successful",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: GlobalColors.black,
                    fontSize: 19),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  children: [
                    Text(
                      "You have successfully placed an order. Details of your order has been sent to your email. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: GlobalColors.black,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigation()));
                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Center(
                            child: Text(
                              "Okay",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: GlobalColors.offWhite,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: GlobalColors.blue),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
