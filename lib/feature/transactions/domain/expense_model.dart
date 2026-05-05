class ExpenseModel {
  final String title;
  final double amount;
  final String category;
  final DateTime date;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  // تحويل البيانات لـ Map عشان نحولها لـ JSON String
  Map<String, dynamic> toJson() => {
    'title': title,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
  };

  // استرجاع البيانات من JSON
  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    title: json['title'],
    amount: json['amount'],
    category: json['category'],
    date: DateTime.parse(json['date']),
  );
}