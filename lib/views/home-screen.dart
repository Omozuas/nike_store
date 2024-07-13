import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/viewProduct_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }

  int activeIndex = 0;
  List<Item> _list = [];

  List<Item> filterItemsByCategory(List<Item> itemList, String categoryId) {
    return itemList.where((item) {
      return item.categories.any((category) => category.id == categoryId);
    }).toList();
  }

  void getAllProduct() {
    final get = Provider.of<ApiProvider>(context, listen: false);
    get.getProduct().then((value) => {_list = value.items});
    // print(_list);
    String categoryId = "defc0c045b5946019a39797888318412";
    List<Item> filteredItems = filterItemsByCategory(_list, categoryId);

    // Print or use the filtered items as needed
    print(filteredItems);
  }

  @override
  Widget build(BuildContext context) {
    // final get = context.watch<ApiProvider>();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AG-Ezenard',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Icon(
                  CupertinoIcons.search,
                  size: 25,
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                    width: 50,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "AD",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: GlobalColors.deepyellow,
                        border:
                            Border.all(width: 2, color: GlobalColors.yellow))),
                const SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good afternoon',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: GlobalColors.lightgray),
                    ),
                    const Text(
                      'Ada Dennis',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(children: [
              CarouselSlider.builder(
                  itemCount: 3,
                  itemBuilder: (context, index, realindex) {
                    return FirstSlide(
                      color1: GlobalColors.gradient1,
                      color2: GlobalColors.gradient2,
                      imageStr: 'assets/images/pair-trainers.png',
                      name: "Ego Vessel",
                      brand: "Iconic Casual Brands",
                      price: "₦ 37,000.00",
                      onTap: () {},
                    );
                  },
                  options: CarouselOptions(
                      enlargeFactor: 90,
                      height: 220,
                      viewportFraction: 1,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),
              Positioned(top: 190, right: 180, child: buildIndicator()),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SecondSlide(
                  img: 'assets/images/nike.png',
                  text: 'Nike',
                ),
                SecondSlide(
                  img: 'assets/images/gucci.png',
                  text: 'Gucci',
                ),
                SecondSlide(
                  img: 'assets/images/jordan.png',
                  text: 'Jordan',
                ),
                SecondSlide(
                  img: 'assets/images/balenciaga.png',
                  text: 'Balenciaga',
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SecondSlide(
                  img: 'assets/images/adidas.png',
                  text: 'Adidas',
                ),
                SecondSlide(
                  img: 'assets/images/reebok.png',
                  text: 'Reeebok',
                ),
                SecondSlide(
                  img: 'assets/images/new.png',
                  text: 'New Balance',
                ),
                SecondSlide(
                  img: 'assets/images/nike.png',
                  text: 'Nike',
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
                  'Our Special Offers',
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Featured Sneakers',
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
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          expansionFactor: 1.1,
          dotHeight: 10,
          dotColor: GlobalColors.deepgray,
          activeDotColor: GlobalColors.offWhite,
        ),
        activeIndex: activeIndex,
        count: 4);
  }
}

class ProductCard extends StatelessWidget {
  ProductCard(
      {super.key,
      required this.selcetContainer,
      required this.wishlist,
      required this.cartBtn,
      required this.productImg,
      required this.pname,
      required this.pbrand,
      required this.pRating,
      required this.pCurrentPrice,
      required this.oldPrice,
      required this.stock});
  final selcetContainer, wishlist, cartBtn;
  String productImg, pbrand, pname, pRating, stock, pCurrentPrice, oldPrice;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selcetContainer,
      child: Container(
        width: 170.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                  width: 168.5,
                  height: 189,
                  child: Center(child: Image.asset(productImg)),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: GlobalColors.offwhite2,
                  )),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: wishlist,
                  child: Container(
                      width: 30,
                      height: 30,
                      child: Center(
                          child: Icon(
                        CupertinoIcons.heart,
                        color: GlobalColors.offwhite2,
                      )),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        color: GlobalColors.deepgray,
                      )),
                ),
              )
            ]),
            Text(
              pbrand,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
            Text(
              pname,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
            ),
            Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: GlobalColors.deepyellow,
                  size: 18,
                ),
                Text(
                  '${pRating} (${stock} sold)',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                ),
              ],
            ),
            Container(
              width: 168.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        pCurrentPrice,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: GlobalColors.blue,
                            fontSize: 16),
                      ),
                      Text(
                        oldPrice,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: GlobalColors.offWhite,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: cartBtn,
                    child: Container(
                        width: 36,
                        height: 30,
                        child: Center(
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: GlobalColors.lightblue,
                            size: 19,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          color: GlobalColors.lightblue.withOpacity(.4),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Container(
          width: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color1, color2]),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      imageStr,
                      height: 180,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: 16,
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
              ),
            ],
          )),
    );
  }
}
