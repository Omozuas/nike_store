import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistdbProvider with ChangeNotifier {
  List<Item> _wishlist = [];

  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleWishlist(Item item) async {
    final prefs = await SharedPreferences.getInstance();
    setLoading(true);
    if (isWishlisted(item.id)) {
      _wishlist.removeWhere((i) => i.id == item.id);
      print('remove:$_wishlist');
    } else {
      _wishlist.add(item);
      print('add:$_wishlist');
    }
    await prefs.setStringList(
        'wishlist', _wishlist.map((i) => jsonEncode(i.toJson())).toList());
    setLoading(false);
    notifyListeners();
  }

  bool isWishlisted(String itemId) {
    return _wishlist.any((item) => item.id == itemId);
  }

  void loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    setLoading(true);
    List<String>? wishlistStringList = prefs.getStringList('wishlist');
    if (wishlistStringList != null) {
      _wishlist = wishlistStringList
          .map((itemString) => Item.fromJson(jsonDecode(itemString)))
          .toList();
    }
    setLoading(false);
    notifyListeners();
  }

  List<Item> get wishlist => _wishlist;
}
