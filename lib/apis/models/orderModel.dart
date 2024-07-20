class Ordermodel {
  String name;
  String email;
  String phone;
  String address;
  String? orderId;
  String? date;
  String status;
  List<dynamic> productItem;
  Ordermodel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.address,
      this.orderId,
      this.date,
      required this.status,
      required this.productItem});
}
