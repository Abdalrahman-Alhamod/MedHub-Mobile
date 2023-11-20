enum OrderStatus {
  preparing,
  sent,
  recieved,
}

class Order {
  int id;
  DateTime date;
  double bill;
  OrderStatus status;

  Order({
    required this.id,
    required this.date,
    required this.bill,
    required this.status,
  });
  factory Order.fromJson(jsonData) {
    return Order(
      id: jsonData['id'],
      date: jsonData['date'],
      bill: jsonData['bill'],
      status: jsonData['status'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['bill'] = bill;
    data['status'] = status;
    return data;
  }
}
