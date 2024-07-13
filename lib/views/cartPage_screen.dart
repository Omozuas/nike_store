import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/CheckOut_screen.dart';

class CartpageScreen extends StatefulWidget {
  const CartpageScreen({super.key});

  @override
  State<CartpageScreen> createState() => _CartpageScreenState();
}

class _CartpageScreenState extends State<CartpageScreen> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('My Cart'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: Container(
                        width: 500,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: GlobalColors.offWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/pair-trainers.png',
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Ego Raid',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(CupertinoIcons.clear),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: GlobalColors.black,
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text('Black',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text('Size',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Text('39',
                                        style: TextStyle(
                                            color: GlobalColors.black
                                                .withOpacity(0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: _decrementCounter,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: GlobalColors.offWhite,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Center(
                                            child: Icon(CupertinoIcons.minus)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          color: GlobalColors.blue
                                              .withOpacity(0.3),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(child: Text('$_counter')),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    InkWell(
                                      onTap: _incrementCounter,
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: GlobalColors.offWhite,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Center(
                                            child: Icon(CupertinoIcons.add)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '₦ 37,000.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 8),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.black.withOpacity(.5),
                        fontSize: 15),
                  ),
                  Text(
                    '₦ 37,000.00',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen()));
                },
                child: Container(
                  width: 110,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: Text(
                        "Check out",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: GlobalColors.offWhite,
                            fontSize: 14),
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
        ),
      ),
    );
  }
}
