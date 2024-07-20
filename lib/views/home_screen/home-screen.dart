import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/cart_model.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/sharedPrefrence_db.dart';
import 'package:nike_store/db/wishlistdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/viewProducts_screen/viewProduct_screen.dart';
import 'package:nike_store/views/wishlist_screen/wishList.dart';
import 'package:nike_store/widgets/screen/firstSlide.dart';
import 'package:nike_store/widgets/screen/productcard.dart';
import 'package:nike_store/widgets/screen/secondSlide.dart';
import 'package:nike_store/widgets/snackBarRes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? subscription;
  var isDeviceConnected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }

  WishlistdbProvider wishlistdbProvider = WishlistdbProvider();
  DataBase dataBase = DataBase();

  CartProvider cartProvider = CartProvider();
  int activeIndex = 0;

  List<Item> list = [];

  void getAllProduct() async {
    final get = Provider.of<ApiProvider>(context, listen: false);

    get.getProduct().then((value) => {list = value.items, getdetails()});
  }

  void getdetails() async {
    final get1 = Provider.of<DataBase>(context, listen: false);
    // final get1 = context.watch<DataBase>();
    String specialoffer = "9e0703135d0042f1b99f34667e9c1fcc";
    String featuredoffer = "85d0da23d6ae46f386663eabcb778397";
    String newArivalss = "d4b8216df2ef45429625767b7e8d931b";
    await get1.loadProductsFromPreferences();
    await get1.newArivalCategoryId(newArivalss);
    await get1.ourSpecialOfferCategoryId(specialoffer);
    await get1.featuredSneakersCategoryId(featuredoffer);
  }

  bool isLoading = true;
  List<Map<String, Color>> gradientColors = [
    {"color1": GlobalColors.gradient1, "color2": GlobalColors.gradient2},
    {"color1": GlobalColors.gradient3, "color2": GlobalColors.gradient4},
    {"color1": GlobalColors.gradient5, "color2": GlobalColors.gradient6},
    // Add more gradient pairs as needed
  ];

  @override
  Widget build(BuildContext context) {
    final get = context.watch<DataBase>();
    final get1 = context.watch<CartProvider>();
    final get2 = context.watch<WishlistdbProvider>();
    final get3 = context.watch<ApiProvider>();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'AG-Ezenard',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      size: 25,
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishListPage()));
                      },
                      icon: Icon(
                        CupertinoIcons.heart,
                        size: 25,
                      ),
                    )
                  ],
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
            newArivals.isEmpty
                ? Shimmer.fromColors(
                    baseColor: GlobalColors.offWhite,
                    highlightColor: GlobalColors.gray,
                    child: Stack(children: [
                      CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realindex) {
                            return FirstSlide(
                                color1: GlobalColors.gradient1,
                                color2: GlobalColors.gradient2,
                                imageStr:
                                    "https://api.timbu.cloud/images/omozuas/product_school_bag_685e1a_2.jpg",
                                name: "",
                                brand: "gdfdf",
                                price: '₦5699',
                                onTap: () {});
                          },
                          options: CarouselOptions(
                              height: 220,
                              viewportFraction: 1,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              })),
                    ]),
                  )
                : Stack(children: [
                    CarouselSlider.builder(
                        itemCount: get.loading ? 0 : newArivals.length,
                        itemBuilder: (context, index, realindex) {
                          var item = newArivals[index];
                          var gradientIndex = index % gradientColors.length;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewproductScreen(
                                            id: item.id,
                                          )));
                            },
                            child: FirstSlide(
                              color1: gradientColors[gradientIndex]["color1"]!,
                              color2: gradientColors[gradientIndex]["color2"]!,
                              imageStr:
                                  "https://api.timbu.cloud/images/${item.photos[0].url}",
                              name: "${item.name}",
                              brand: "${item.urlSlug}",
                              price: '₦${item.currentPrice[0].ngn[0]}',
                              onTap: () {
                                var items = CartModel(
                                    id: item.id,
                                    name: item.name,
                                    colour: 'black',
                                    size: '',
                                    price: item.currentPrice[0].ngn[0],
                                    count: 1,
                                    img: "${item.photos[0].url}",
                                    color: GlobalColors.black);
                                get1.addToCart(items);
                                print('${item.photos[0].url}');
                                success(
                                    context: context,
                                    message: '${item.name} added to cart');
                              },
                            ),
                          );
                        },
                        options: CarouselOptions(
                            height: 220,
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            })),
                    Positioned(
                        top: 190, right: 180, child: buildIndicator(get)),
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
                    mainAxisExtent: 320),
                itemCount: get1.loading ? 0 : ourSpecialOffer.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = ourSpecialOffer[index];
                  return get3.loading
                      ? Shimmer.fromColors(
                          baseColor: GlobalColors.offWhite,
                          highlightColor: GlobalColors.gray,
                          child: ProductCard(
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
                                    message: '${item.name} added to wishlist');
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
                              get1.addToCart(items);
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
                                  message: '${item.name} added to wishlist');
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
                            get1.addToCart(items);
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
                    mainAxisExtent: 320),
                itemCount: get.loading ? 0 : featuredOffer.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = featuredOffer[index];
                  return get3.loading
                      ? Shimmer.fromColors(
                          baseColor: GlobalColors.offWhite,
                          highlightColor: GlobalColors.gray,
                          child: ProductCard(
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
                                    message: '${item.name} added to wishlist');
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
                              get1.addToCart(items);
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
                                  message: '${item.name} added to wishlist');
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
                            get1.addToCart(items);
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
      ),
    );
  }

  Widget buildIndicator(get) {
    return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          expansionFactor: 1.1,
          dotHeight: 10,
          dotColor: GlobalColors.deepgray,
          activeDotColor: GlobalColors.offWhite,
        ),
        activeIndex: activeIndex,
        count: newArivals.isEmpty ? 0 : newArivals.length);
  }
}
