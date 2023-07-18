class ExpenseItemModel {
  int? id;
  String? category;
  String? amount;
  String? description;
  String? date;

  ExpenseItemModel({this.id, this.category, this.amount,
    this.description, this.date});

  ExpenseItemModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    category = json["category"];
    amount = json["amount"];
    description = json["description"];
    date = json["date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["category"] = category;
    data["amount"] = amount;
    data["description"] = description;
    data["date"] = date;
    return data;

  }
}