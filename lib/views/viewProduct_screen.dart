import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/home-screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewproductScreen extends StatefulWidget {
  const ViewproductScreen({super.key});

  @override
  State<ViewproductScreen> createState() => _ViewproductScreenState();
}

class _ViewproductScreenState extends State<ViewproductScreen> {
  int activeIndex = 2;
  String text = lorem(paragraphs: 1, words: 30);
  List<bool>? selected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<bool>? selected1 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  void handleTap(int index) {
    setState(() {
      for (int i = 0; i < selected!.length; i++) {
        selected![i] = i == index;
      }
    });
  }

  void handleTap2(int index) {
    setState(() {
      for (int i = 0; i < selected1!.length; i++) {
        selected1![i] = i == index;
      }
    });
  }

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
        backgroundColor: GlobalColors.offWhite,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(children: [
            Container(
              width: 500,
              height: 280,
              decoration: BoxDecoration(color: GlobalColors.offWhite),
              child: CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: (context, index, realindex) {
                  return Image.asset(
                    'assets/images/pair-trainers.png',
                    scale: .8,
                  );
                },
                options: CarouselOptions(
                    initialPage: 0,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    // aspectRatio: 16 / 2,
                    scrollDirection: Axis.horizontal,
                    autoPlayInterval: Duration(seconds: 7),
                    enlargeCenterPage: true,
                    enlargeFactor: 0.8,
                    autoPlayCurve: Curves.easeIn,
                    disableCenter: true),
              ),
            ),
            Positioned(bottom: 10, right: 180, child: buildIndicator()),
          ]),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Iconic Casual Brands',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ego Vessel',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text(
                          '₦ 37,000.00',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '100 sold',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            Icon(
                              Icons.star_half,
                              color: GlobalColors.yellow,
                              size: 18,
                            ),
                            Text(
                              '4.5 (32 reviews)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          width: 35,
                          height: 35,
                          child: Center(
                              child: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                          )),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: GlobalColors.red,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text(
                  text,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Size',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Selectatblecon(
                      text: '32',
                      selected: selected![0],
                      onTap: handleTap,
                      index: 0,
                    ),
                    Selectatblecon(
                      text: '33',
                      selected: selected![1],
                      onTap: handleTap,
                      index: 1,
                    ),
                    Selectatblecon(
                      text: '34',
                      selected: selected![2],
                      onTap: handleTap,
                      index: 2,
                    ),
                    Selectatblecon(
                      text: '35',
                      selected: selected![3],
                      onTap: handleTap,
                      index: 3,
                    ),
                    Selectatblecon(
                      text: '36',
                      selected: selected![4],
                      onTap: handleTap,
                      index: 4,
                    ),
                    Selectatblecon(
                      text: '37',
                      selected: selected![5],
                      onTap: handleTap,
                      index: 5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Colours',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Selectatblecon2(
                      selected: selected1![0],
                      color1: GlobalColors.deepyellow,
                      onTap: handleTap2,
                      index: 0,
                    ),
                    Selectatblecon2(
                      selected: selected1![1],
                      color1: GlobalColors.purble,
                      onTap: handleTap2,
                      index: 1,
                    ),
                    Selectatblecon2(
                      selected: selected1![2],
                      onTap: handleTap2,
                      color1: GlobalColors.pink,
                      index: 2,
                    ),
                    Selectatblecon2(
                      color1: GlobalColors.green,
                      selected: selected1![3],
                      onTap: handleTap2,
                      index: 3,
                    ),
                    Selectatblecon2(
                      selected: selected1![4],
                      onTap: handleTap2,
                      color1: GlobalColors.yellow,
                      index: 4,
                    ),
                    Selectatblecon2(
                      selected: selected1![5],
                      color1: GlobalColors.black,
                      onTap: handleTap2,
                      index: 5,
                    ),
                    Selectatblecon2(
                      selected: selected1![6],
                      color1: GlobalColors.blue,
                      onTap: handleTap2,
                      index: 6,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Quantity',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: _decrementCounter,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: GlobalColors.offWhite,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(child: Icon(CupertinoIcons.minus)),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 33,
                      height: 33,
                      decoration: BoxDecoration(
                          color: GlobalColors.blue.withOpacity(0.3),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(child: Text('$_counter')),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: _incrementCounter,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: GlobalColors.offWhite,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(child: Icon(CupertinoIcons.add)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'More from Ego',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 300),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        selcetContainer: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewproductScreen()));
                        },
                        wishlist: () {},
                        cartBtn: () {},
                        productImg:
                            "assets/images/victor-olamide-ajibola-5emTz0Gv2rI-unsplash-removebg-preview.png",
                        pbrand: 'Athletic/Sportswear',
                        pname: 'Air Jordan running sneaker',
                        pRating: '4.5',
                        stock: "100",
                        pCurrentPrice: '₦ 28,000.00',
                        oldPrice: '₦ 45,000.00',
                      );
                    }),
              ],
            ),
          )
        ],
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
                        color: GlobalColors.offWhite,
                        fontSize: 15),
                  ),
                  Text(
                    '₦ 37,000.00',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 130,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: GlobalColors.offWhite,
                          ),
                          Text(
                            "Add to cart",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalColors.offWhite,
                                fontSize: 14),
                          ),
                        ],
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

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          expansionFactor: 1.1,
          dotHeight: 10,
          dotColor: Colors.white,
          activeDotColor: GlobalColors.blue,
        ),
        activeIndex: activeIndex,
        count: 4);
  }
}

class Selectatblecon extends StatelessWidget {
  Selectatblecon(
      {super.key,
      required this.selected,
      required this.text,
      required this.onTap,
      required this.index});
  bool? selected;
  String text;
  final Function(int) onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          width: 40,
          height: 30,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected == false ? Colors.black : GlobalColors.offWhite,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color:
                selected == false ? GlobalColors.offWhite : GlobalColors.blue,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}

class Selectatblecon2 extends StatelessWidget {
  Selectatblecon2(
      {super.key,
      required this.selected,
      required this.onTap,
      required this.color1,
      required this.index});
  bool? selected;

  final Function(int) onTap;
  final int index;
  Color? color1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          width: 40,
          height: 30,
          child: Center(
            child: selected == false
                ? Container()
                : Icon(
                    Icons.check,
                    color: GlobalColors.offWhite,
                  ),
          ),
          decoration: BoxDecoration(
            color: color1,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
