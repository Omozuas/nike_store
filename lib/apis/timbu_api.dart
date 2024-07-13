import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nike_store/apis/models/listOfProductItem.dart';
import 'package:nike_store/apis/models/mainListProduct.dart';

class ApiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
  }

  Future<MainProduct> getProduct() async {
    setLoading(true);
    print('res.body');
    var getTimbu =
        'http://api.timbu.cloud/products?&organization_id=cac2875713a3461fb27799485a1a6522&Appid=6OK3HZFZILCW0ER&Apikey=4b4ea49b9d0649a5a1089b476a8e658120240704211421778273';
    var res = await http.get(
      Uri.parse(getTimbu),
      headers: {
        'Content-Type': "application/json ",
      },
    );
    print(res.body);
    if (res.statusCode == 200) {
      setLoading(false);
      notifyListeners();
      return mainProductFromJson(res.body);
    } else {
      setLoading(false);
      notifyListeners();
      return mainProductFromJson(res.body);
    }
  }

  Future<Item2> getAProduct(id) async {
    setLoading(true);
    print("getTimbu");
    var getTimbu =
        'https://api.timbu.cloud/products/$id?&organization_id=cac2875713a3461fb27799485a1a6522&Appid=6OK3HZFZILCW0ER&Apikey=4b4ea49b9d0649a5a1089b476a8e658120240704211421778273';

    print(getTimbu);
    var res = await http.get(
      Uri.parse(getTimbu),
      headers: {
        'Content-Type': "application/json; charset=utf-8",
      },
    );

    if (res.statusCode == 200) {
      setLoading(false);
      notifyListeners();
      return singleItemFromJson(res.body);
    } else {
      setLoading(false);
      notifyListeners();
      return singleItemFromJson(res.body);
    }
  }
}
