class Transaction {
  String id;
  String title;
  double amount;
  DateTime? date;

  Transaction(
      {required this.id, required this.title, required this.amount, date})
      : date = date ?? DateTime.now();
}
