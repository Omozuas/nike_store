import 'package:flutter/material.dart';
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/models/mainListProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Item> ourSpecialOffer = [];
List<Item> featuredOffer = [];
Item? product;
List<Item> productsWithSameCategoryId = [];
List<Item> listOfProducts = [];
List<Item> newArivals = [];

class DataBase with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
  }

  Future<MainProduct?> loadProductsFromPreferences() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productsJson = prefs.getString('productData');
    if (productsJson != null) {
      setLoading(false);
      notifyListeners();
      return mainProductFromJson(productsJson);
    }
    setLoading(false);
    notifyListeners();
    return null;
  }

  Future<void> ourSpecialOfferCategoryId(String categoryId) async {
    setLoading(true);
    MainProduct? mainProduct = await loadProductsFromPreferences();
    if (mainProduct != null) {
      ourSpecialOffer = mainProduct.items.where((item) {
        return item.categories.any((category) => category.id == categoryId);
      }).toList();
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> featuredSneakersCategoryId(String categoryId2) async {
    setLoading(true);
    MainProduct? mainProduct = await loadProductsFromPreferences();
    if (mainProduct != null) {
      featuredOffer = mainProduct.items.where((item) {
        return item.categories.any((category) => category.id == categoryId2);
      }).toList();
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> newArivalCategoryId(String categoryId3) async {
    setLoading(true);
    print(categoryId3);
    MainProduct? mainProduct = await loadProductsFromPreferences();
    if (mainProduct != null) {
      newArivals = mainProduct.items.where((item) {
        return item.categories.any((category) => category.id == categoryId3);
      }).toList();
      setLoading(false);
      notifyListeners();
    }
  }

  // Method to get a single product by its ID
  Future<void> getProductById(String productId) async {
    setLoading(true);
    MainProduct? mainProduct = await loadProductsFromPreferences();
    if (mainProduct != null) {
      try {
        product = mainProduct.items.firstWhere((item) => item.id == productId);
      } catch (e) {
        product = null;
        setLoading(false);
        notifyListeners();
      }
      setLoading(false);
      notifyListeners();
    }
  }

  // Method to get all products under the same category as the specified product ID
  Future<void> getProductsByCategoryIdOfProduct(String productId) async {
    setLoading(true);
    MainProduct? mainProduct = await loadProductsFromPreferences();
    if (mainProduct != null) {
      await getProductById(productId);
      if (product != null) {
        String categoryId =
            product!.categories.first.id; // Assuming first category ID is used
        productsWithSameCategoryId = mainProduct.items.where((item) {
          return item.categories.any((category) => category.id == categoryId);
        }).toList();
        setLoading(false);
        notifyListeners();
      }
    }
  }
}
