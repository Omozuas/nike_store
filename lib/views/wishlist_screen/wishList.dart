import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/cart_model.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/timbu_api.dart';
import 'package:nike_store/db/cartdb.dart';
import 'package:nike_store/db/sharedPrefrence_db.dart';
import 'package:nike_store/db/wishlistdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/viewProducts_screen/viewProduct_screen.dart';
import 'package:nike_store/widgets/bottomNav/BottomNav.dart';
import 'package:nike_store/widgets/screen/productcard.dart';
import 'package:nike_store/widgets/snackBarRes.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  WishlistdbProvider wishlistdbProvider = WishlistdbProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();
  }

  List<Item> list = [];

  void getAllProduct() {
    final get = Provider.of<ApiProvider>(context, listen: false);
    final get1 = Provider.of<DataBase>(context, listen: false);
    get.getProduct().then((value) => {list = value.items});
    get1.loadProductsFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final get1 = context.watch<ApiProvider>();
    final get = context.watch<WishlistdbProvider>();
    final get2 = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('My wishlist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Column(
            children: [
              get.wishlist.isEmpty
                  ? Center(
                      child: Container(
                          height: 500,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                    "assets/animation/emptywishlist.json"),
                                Text(
                                    "You have not added any item to your wish list",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigation()));
                                    },
                                    child: Container(
                                      width: 400,
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Center(
                                          child: Text(
                                            "Discover products",
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
                                  ),
                                ),
                              ])),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 13,
                          mainAxisExtent: 320),
                      itemCount: get.wishlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = get.wishlist[index];
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
                                    get.toggleWishlist(item);
                                    if (get.isWishlisted(item.id)) {
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
                                    get2.addToCart(items);
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
                                  isWishlisted: get.isWishlisted(item.id),
                                ))
                            : ProductCard(
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
                                  get.toggleWishlist(item);
                                  if (get.isWishlisted(item.id)) {
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
                                  get2.addToCart(items);
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
                                isWishlisted: get.isWishlisted(item.id),
                              );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
