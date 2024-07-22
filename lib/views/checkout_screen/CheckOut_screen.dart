import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/orderModel.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/orderdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/succesPayment_screen/succesfulPage_screen.dart';
import 'package:nike_store/views/viewProducts_screen/viewProduct_screen.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  CartProvider cartProvider = CartProvider();
  void _checkout() async {
    if (formKey.currentState!.validate() &&
        formKey1.currentState!.validate() &&
        formKey2.currentState!.validate()) {
      final get1 = Provider.of<CartProvider>(context, listen: false);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SuccessfulScreen()));
      get1.clearCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final get1 = context.watch<CartProvider>();
    final get2 = context.watch<OrderdbProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('checkout'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            get1.loading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView.builder(
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
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    get1.removeFromCart(
                                                        item.id);
                                                  });
                                                },
                                                child:
                                                    Icon(CupertinoIcons.clear),
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
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  3)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text('${item.colour}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text('Size',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  Text('${item.size}',
                                                      style: TextStyle(
                                                          color: GlobalColors
                                                              .black
                                                              .withOpacity(0.6),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                        color: GlobalColors.blue
                                                            .withOpacity(0.3),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: Center(
                                                        child: Text(
                                                            '${item.count}')),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Text(
                                                    '₦ ${item.price}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                  ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Personal information',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () {},
                  child: Text('Edit',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalColors.blue,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: GlobalColors.offwhite2.withOpacity(.4)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.person_alt_circle,
                                color: GlobalColors.blue,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('Ada Dennis',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalColors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.device_phone_portrait,
                                color: GlobalColors.blue,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('09100000000',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalColors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.mail,
                                color: GlobalColors.blue,
                                size: 16,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('ad@gmail.com',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalColors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery option',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () {},
                  child: Text('Edit',
                      style: TextStyle(
                          fontSize: 16,
                          color: GlobalColors.blue,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: GlobalColors.offwhite2.withOpacity(.4)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.timelapse,
                          color: GlobalColors.blue,
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Pick up point',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Ikeja, Lagos',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Price summary',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: GlobalColors.offwhite2.withOpacity(.4)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total price',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black.withOpacity(.7),
                                fontWeight: FontWeight.w300)),
                        Text('₦ ${get1.getTotalPrice().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery fee',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black.withOpacity(.7),
                                fontWeight: FontWeight.w300)),
                        Text('₦   1,550.00',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black.withOpacity(.7),
                                fontWeight: FontWeight.w300)),
                        Text('₦  0.00',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Divider(),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black.withOpacity(.7),
                                fontWeight: FontWeight.w300)),
                        Text('₦  ${get1.getTotalPrice() + 1550}',
                            style: TextStyle(
                                fontSize: 16,
                                color: GlobalColors.black,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 110,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: GlobalColors.offWhite),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: Text(
                        "cancle",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: GlobalColors.black,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 8, right: 10),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Select a payment option",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: GlobalColors.black,
                                                fontSize: 19),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(CupertinoIcons.clear),
                                          )
                                        ]),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    Card(
                                      elevation: 0,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/Payment method icon.png',
                                                  scale: .7,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "**** **** **** 1234",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: GlobalColors
                                                                        .black,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              Text(
                                                                "05/24",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: GlobalColors
                                                                        .black,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 100,
                                                          ),
                                                          Radio(
                                                            onChanged: (v) {},
                                                            toggleable: true,
                                                            activeColor:
                                                                GlobalColors
                                                                    .green,
                                                            value: null,
                                                            groupValue: null,
                                                          )
                                                        ]),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        "Add a new Card",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: GlobalColors.lightblue
                                                .withOpacity(.5),
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    textFiled(
                                        keys: formKey,
                                        label: "Full name",
                                        hintText: "Enter your full name",
                                        controller2: fullnamecontroller,
                                        keyboardType4: TextInputType.name,
                                        validate: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r'^[a-z A-Z]+$')
                                                  .hasMatch(value!)) {
                                            return "Enter your full name";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    textFiled(
                                        keys: formKey1,
                                        label: "email address",
                                        hintText: "Enter your email address",
                                        controller2: emailcontroller,
                                        keyboardType4:
                                            TextInputType.emailAddress,
                                        validate: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                                  .hasMatch(value!)) {
                                            return "Enter your email address";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    textFiled(
                                        keys: formKey2,
                                        label: "Phone number",
                                        hintText: "Enter your phone number",
                                        controller2: numbercontroller,
                                        keyboardType4: TextInputType.number,
                                        validate: (value) {
                                          if (value!.isEmpty ||
                                              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                                                  .hasMatch(value!)) {
                                            return "Enter your phone number";
                                          } else {
                                            return null;
                                          }
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final newOrder = Ordermodel(
                                          name: numbercontroller.text,
                                          email: emailcontroller.text,
                                          phone: numbercontroller.text,
                                          address: '123 Main St',
                                          orderId: '',
                                          status: 'pending',
                                          productItem: cart,
                                        );
                                        get2.addOrder(newOrder);
                                        _checkout();
                                      },
                                      child: Container(
                                        width: 400,
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Center(
                                            child: Text(
                                              "Proceed to payment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: GlobalColors.offWhite,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: GlobalColors.blue),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  width: 110,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: Text(
                        "Proceed",
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

Widget textFiled(
    {label,
    hintText,
    err,
    controller2,
    suffixIcon2,
    keyboardType4,
    validate,
    onchange,
    maxLength,
    keys,
    obscureText = false}) {
  return Form(
    key: keys,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: GlobalColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          onChanged: onchange,
          validator: validate,
          controller: controller2,
          keyboardType: keyboardType4,
          obscureText: obscureText,
          maxLength: maxLength,
          decoration: InputDecoration(
              suffixIcon: suffixIcon2,
              errorText: err,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              hintText: hintText,
              helperStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.lightgray),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalColors.black),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    ),
  );
}
