import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:byaz_track/features/create_loan/data/source/create_loan_remote_source.dart';
import 'package:logger/web.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

class CreateLoanController extends GetxController {
  CreateLoanController({required this.remoteSource});
  final CreateLoanRemoteSource remoteSource;

  final RxInt transactionType = 0.obs;
  TextEditingController principalAmountController = TextEditingController();
  final Rx<NepaliDateTime?> startDate = Rx<NepaliDateTime?>(
    NepaliDateTime.now(),
  );
  final RxInt interestRateType = 0.obs;
  final RxString rateValue = ''.obs;
  TextEditingController partyNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void setStartDate(NepaliDateTime? date) => startDate.value = date;



  Future<void> insertLoan({
    required String transactionType,
    required int principalAmount,
    required DateTime startDate,
    required String interestType,
    required double rateValue,
    required String partyName,
    String? notes,
    BuildContext? context,
  }) async {
    final db = await DatabaseHelper.instance.database;

    final data = await db.query('loans');

    var logger = Logger();

    logger.i(
      'current db data: ---------------------->${const JsonEncoder.withIndent('  ').convert(data)}',
    );
    try {
      final id = Uuid().v4();
      final now = DateTime.now();

      final loan = LoanModel(
        id: id,
        transactionType: transactionType,
        principalAmount: principalAmount,
        startDate: startDate,
        interestType: interestType,
        rateValue: rateValue,
        partyName: partyName,
        notes: notes,
        createdAt: now,
        updatedAt: now,
        syncStatus: 'pending',
        loanStatus: LedgerItemStatus.active,
      );

      final result = await db.insert('loans', loan.toMap());
      debugPrint('Loan inserted successfully: $result');
      showTopSnackBar(
        Overlay.of(context!),
        dismissType: DismissType.onSwipe,
        CustomSnackBar.success(
          iconRotationAngle: 0,
          icon: Icon(Icons.check_circle, color: Color(0x15000000), size: 120),
          backgroundColor: DefaultColors.successGreen,
          message: "Loan created successfully",
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error inserting loan: $e');
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,

        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Failed to create loan.',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
