class TransactionModel {
  final String category;
  final int amount;
  final DateTime date;
  final String icon;

  TransactionModel({
    required this.category,
    required this.amount,
    required this.date,
    required this.icon,
  });
}