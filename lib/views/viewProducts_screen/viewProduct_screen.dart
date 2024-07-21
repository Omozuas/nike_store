import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:nike_store/apis/models/cart_model.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/sharedPrefrence_db.dart';
import 'package:nike_store/db/wishlistdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';

import 'package:nike_store/widgets/screen/productcard.dart';
import 'package:nike_store/widgets/snackBarRes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewproductScreen extends StatefulWidget {
  const ViewproductScreen({super.key, this.id});
  final id;
  @override
  State<ViewproductScreen> createState() => _ViewproductScreenState();
}

class _ViewproductScreenState extends State<ViewproductScreen> {
  DataBase dataBase = DataBase();
  CartProvider cartProvider = CartProvider();
  WishlistdbProvider wishlistdbProvider = WishlistdbProvider();
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
    final get = Provider.of<ApiProvider>(context, listen: false);
    get.getProduct();
    await dataBase.getProductById(widget.id);
    await dataBase.getProductsByCategoryIdOfProduct(widget.id);
  }

  String size = '';
  String color = '';
  Color? color2;
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

  List<String> sizes = ['32', '33', '34', '35', '36', '37'];
  List<String> colors = [
    'deepyellow',
    'purble',
    'pink',
    'green',
    'yellow',
    'black',
    'blue'
  ];
  List<Color> colores = [
    GlobalColors.deepyellow,
    GlobalColors.purble,
    GlobalColors.pink,
    GlobalColors.green,
    GlobalColors.yellow,
    GlobalColors.black,
    GlobalColors.blue,
  ];
  void handleTap(int index) {
    setState(() {
      for (int i = 0; i < selected!.length; i++) {
        selected![i] = i == index;
      }
      size = sizes[index];
    });
    print('Selected size: ${sizes[index]}');
  }

  void handleTap2(int index) {
    setState(() {
      for (int i = 0; i < selected1!.length; i++) {
        selected1![i] = i == index;
      }
      color = colors[index];
      color2 = colores[index];
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
    final get = context.watch<DataBase>();
    final get1 = context.watch<ApiProvider>();
    final get2 = context.watch<WishlistdbProvider>();
    final get3 = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.offWhite,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          get1.loading
              ? Shimmer.fromColors(
                  baseColor: GlobalColors.offWhite,
                  highlightColor: GlobalColors.gray,
                  child: Stack(children: [
                    Container(
                      width: 500,
                      height: 280,
                      decoration: BoxDecoration(color: GlobalColors.offWhite),
                      child: CarouselSlider.builder(
                        itemCount: get.loading ? 0 : product!.photos.length,
                        itemBuilder: (context, index, realindex) {
                          return Image.network(
                            "https://api.timbu.cloud/images/${product!.photos[index].url}",
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
                    Positioned(
                        bottom: 10, right: 180, child: buildIndicator(get)),
                  ]))
              : Stack(children: [
                  Container(
                    width: 500,
                    height: 280,
                    decoration: BoxDecoration(color: GlobalColors.offWhite),
                    child: CarouselSlider.builder(
                      itemCount: get.loading ? 0 : product!.photos.length,
                      itemBuilder: (context, index, realindex) {
                        return Image.network(
                          "https://api.timbu.cloud/images/${product!.photos[index].url}",
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
                  Positioned(
                      bottom: 10, right: 180, child: buildIndicator(get)),
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
                  get1.loading ? 'loading..' : '${product!.urlSlug}',
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
                          get1.loading
                              ? 'loading..'
                              : '${product!.name}'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text(
                          get1.loading
                              ? 'loading..'
                              : '₦${product!.currentPrice[0].ngn[0]}0',
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
                      onTap: () {
                        get2.toggleWishlist(product!);
                      },
                      child: Container(
                          width: 35,
                          height: 35,
                          child: Center(
                              child: Icon(
                            get2.isWishlisted(product!.id)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: Colors.white,
                          )),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            color: get2.isWishlisted(product!.id)
                                ? GlobalColors.red
                                : GlobalColors.deepgray,
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
                    itemCount:
                        get.loading ? 0 : productsWithSameCategoryId.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = productsWithSameCategoryId[index];
                      return get1.loading
                          ? Shimmer.fromColors(
                              baseColor: GlobalColors.offWhite,
                              highlightColor: GlobalColors.gray,
                              child: ProductCard(
                                selcetContainer: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewproductScreen(
                                                id: item.id,
                                              )));
                                },
                                wishlist: () {
                                  get2.toggleWishlist(item);
                                  if (get2.isWishlisted(item.id)) {
                                    return success(
                                        context: context,
                                        message:
                                            '${item.name} removed from wishlist');
                                  } else {
                                    return success(
                                        context: context,
                                        message:
                                            '${item.name} added to wishlist');
                                  }
                                },
                                cartBtn: () {
                                  var items = CartModel(
                                      id: item.id,
                                      name: item.name,
                                      colour: 'black',
                                      size: '',
                                      price: item.currentPrice[0].ngn[0],
                                      count: 1,
                                      img: "${item.photos[0].url}",
                                      color: GlobalColors.black);
                                  get3.addToCart(items);
                                  print('${item.photos[0].url}');
                                  success(
                                      context: context,
                                      message: '${item.name} added to cart');
                                },
                                productImg:
                                    "https://api.timbu.cloud/images/${item.photos[0].url}",
                                pbrand: '${item.urlSlug}',
                                pname: '${item.name}',
                                pRating: '4.5',
                                stock: "${item.availableQuantity}",
                                pCurrentPrice:
                                    '₦${item.currentPrice[0].ngn[0]}0',
                                oldPrice: '₦ 45,000.00',
                                isWishlisted: get2.isWishlisted(item.id),
                              ))
                          : ProductCard(
                              selcetContainer: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewproductScreen(
                                              id: item.id,
                                            )));
                              },
                              wishlist: () {
                                get2.toggleWishlist(item);
                                if (get2.isWishlisted(item.id)) {
                                  return success(
                                      context: context,
                                      message:
                                          '${item.name} removed from wishlist');
                                } else {
                                  return success(
                                      context: context,
                                      message:
                                          '${item.name} added to wishlist');
                                }
                              },
                              cartBtn: () {
                                var items = CartModel(
                                    id: item.id,
                                    name: item.name,
                                    colour: 'black',
                                    size: '',
                                    price: item.currentPrice[0].ngn[0],
                                    count: 1,
                                    img: "${item.photos[0].url}",
                                    color: GlobalColors.black);
                                get3.addToCart(items);
                                print('${item.photos[0].url}');
                                success(
                                    context: context,
                                    message: '${item.name} added to cart');
                              },
                              productImg:
                                  "https://api.timbu.cloud/images/${item.photos[0].url}",
                              pbrand: '${item.urlSlug}',
                              pname: '${item.name}',
                              pRating: '4.5',
                              stock: "${item.availableQuantity}",
                              pCurrentPrice: '₦${item.currentPrice[0].ngn[0]}0',
                              oldPrice: '₦ 45,000.00',
                              isWishlisted: get2.isWishlisted(item.id),
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
                        color: GlobalColors.black.withOpacity(.7),
                        fontSize: 15),
                  ),
                  Text(
                    get1.loading
                        ? 'loading..'
                        : '₦${product!.currentPrice[0].ngn[0]}0',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (color.isEmpty) {
                    error(context: context, message: 'select a color');
                  } else if (size.isEmpty) {
                    error(context: context, message: 'select a size');
                  } else {
                    var item = CartModel(
                        id: product!.id,
                        name: product!.name,
                        colour: color,
                        size: size,
                        price: product!.currentPrice[0].ngn[0],
                        count: _counter,
                        img: "${product!.photos[0].url}",
                        color: color2!);
                    get3.addToCart(item);
                    print('${product!.photos[0].url}');
                    success(
                        context: context,
                        message: '${product!.name} added to cart');
                  }
                },
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

  Widget buildIndicator(get) {
    return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          expansionFactor: 1.1,
          dotHeight: 10,
          dotColor: Colors.white,
          activeDotColor: GlobalColors.blue,
        ),
        activeIndex: activeIndex,
        count: get.loading ? 0 : product!.photos.length);
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
