import 'package:uuid/uuid.dart';

class PaymentModel {
  final String id;
  final String loanId;
  final double amount;
  final DateTime paymentDate;
  final DateTime createdAt;

  PaymentModel({
    required this.id,
    required this.loanId,
    required this.amount,
    required this.paymentDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loan_id': loanId,
      'amount': amount,
      'payment_date': paymentDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as String,
      loanId: map['loan_id'] as String,
      amount: map['amount'] as double,
      paymentDate: DateTime.parse(map['payment_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  factory PaymentModel.create({
    required String loanId,
    required double amount,
    required DateTime paymentDate,
  }) {
    return PaymentModel(
      id: const Uuid().v4(),
      loanId: loanId,
      amount: amount,
      paymentDate: paymentDate,
      createdAt: DateTime.now(),
    );
  }
}
