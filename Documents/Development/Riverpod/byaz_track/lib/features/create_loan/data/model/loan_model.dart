import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';

class LoanModel {
  final String id;
  final String transactionType;
  final int principalAmount;
  final DateTime startDate;
  final String interestType;
  final double rateValue;
  final String partyName;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final LedgerItemStatus loanStatus;
  final DateTime? lastCollectedDate;

  LoanModel({
    required this.id,
    required this.transactionType,
    required this.principalAmount,
    required this.startDate,
    required this.interestType,
    required this.rateValue,
    required this.partyName,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.loanStatus,
    this.lastCollectedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_type': transactionType,
      'principal_amount': principalAmount,
      'start_date': startDate.toIso8601String(),
      'interest_type': interestType,
      'rate_value': rateValue,
      'party_name': partyName,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
      'loan_status': loanStatus.name,
      'last_collected_date': lastCollectedDate?.toIso8601String(),
    };
  }

  factory LoanModel.fromMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'] as String,
      transactionType: map['transaction_type'] as String,
      principalAmount: map['principal_amount'] as int,
      startDate: DateTime.parse(map['start_date'] as String),
      interestType: map['interest_type'] as String,
      rateValue: (map['rate_value'] as num).toDouble(),
      partyName: map['party_name'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      syncStatus: map['sync_status'] as String,
      loanStatus: LedgerItemStatus.values.firstWhere(
        (e) => e.name == map['loan_status'],
        orElse: () => LedgerItemStatus.active,
      ),
      lastCollectedDate:
          map['last_collected_date'] != null
              ? DateTime.parse(map['last_collected_date'] as String)
              : null,
    );
  }

  get status => null;
}
