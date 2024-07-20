import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_store/db/orderdb.dart';
import 'package:nike_store/globalColor/colorsHex.dart';
import 'package:nike_store/views/viewProducts_screen/viewProduct_screen.dart';
import 'package:provider/provider.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({super.key});

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpending();
  }

  void getpending() {
    var get = Provider.of<OrderdbProvider>(context, listen: false);
    get.getCompletedOrders();
  }

  @override
  Widget build(BuildContext context) {
    final get = context.watch<OrderdbProvider>();
    return Column(
      children: [
        get.completedOrders.isEmpty
            ? Center(
                child: Container(
                    height: 500,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/animation/emptyorder.json"),
                          Text("No completed order yet",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 20,
                          ),
                        ])),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: get.completed.length,
                    physics: NeverScrollableScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) {
                      var item = get.completed[index];

                      return Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  get.removeOrderById(item.orderId!);
                                });
                              },
                              child: Icon(
                                CupertinoIcons.trash,
                                color: GlobalColors.red,
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.productItem.length,
                            physics: NeverScrollableScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemBuilder: (context, index) {
                              var item2 = item.productItem[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewproductScreen(
                                                id: item2.id,
                                              )));
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: GlobalColors.offWhite,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Image.network(
                                              'https://api.timbu.cloud/images/${item2.img}',
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('${item2.name}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: item2.color,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          3)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text('${item2.colour}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text('Size',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text('${item2.size}',
                                                          style: TextStyle(
                                                              color: GlobalColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500))
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
                                                            color: GlobalColors
                                                                .blue
                                                                .withOpacity(
                                                                    0.3),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                        child: Center(
                                                            child: Text(
                                                                '${item2.count}')),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        '₦ ${item2.price}',
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
                            })
                      ]);
                    }),
              ),
      ],
    );
  }
}
