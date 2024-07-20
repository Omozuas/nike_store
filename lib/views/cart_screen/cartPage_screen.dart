import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/checkout_screen/CheckOut_screen.dart';
import 'package:nike_store/views/viewProducts_screen/viewProduct_screen.dart';
import 'package:provider/provider.dart';

class CartpageScreen extends StatefulWidget {
  const CartpageScreen({super.key});

  @override
  State<CartpageScreen> createState() => _CartpageScreenState();
}

class _CartpageScreenState extends State<CartpageScreen> {
  int _counter = 1;

  CartProvider cartProvider = CartProvider();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    cartProvider.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    final get1 = context.watch<CartProvider>();
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
        child: cart.isEmpty
            ? Center(
                child: Container(
                    height: 500,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/animation/emptycart.json"),
                          Text("Your cart is empty",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 20,
                          ),
                        ])),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: cart.length,
                physics: NeverScrollableScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  var item = cart[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewproductScreen(
                                    id: item.id,
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 120,
                              decoration: BoxDecoration(
                                color: GlobalColors.offWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.network(
                                  'https://api.timbu.cloud/images/${item.img}',
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${item.name}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            get1.removeFromCart(item.id);
                                          });
                                        },
                                        child: Icon(CupertinoIcons.clear),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: item.color,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(3)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text('${item.colour}',
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
                                          Text('${item.size}',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              cartProvider
                                                  .decrementItemCount(item.id);
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: GlobalColors.offWhite,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Center(
                                                  child: Icon(
                                                      CupertinoIcons.minus)),
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
                                            child: Center(
                                                child: Text('${item.count}')),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              cartProvider
                                                  .incrementItemCount(item.id);
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: GlobalColors.offWhite,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Center(
                                                  child:
                                                      Icon(CupertinoIcons.add)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            '₦ ${item.price}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
                    '₦ ${get1.getTotalPrice()}',
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
