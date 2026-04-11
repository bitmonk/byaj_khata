import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/interest_details/data/source/interest_details_remote_source.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:byaz_track/features/interest_details/data/model/payment_model.dart';

import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';

class InterestDetailsController extends GetxController {
  InterestDetailsController({required this.remoteSource});
  final InterestDetailsRemoteSource remoteSource;

  final dbHelper = DatabaseHelper.instance;

  Rx<TheStates> deleteLoanState = TheStates.initial.obs;

  Future<void> deleteLoan(String loanId, BuildContext context) async {
    try {
      deleteLoanState.value = TheStates.loading;
      final result = await dbHelper.deleteLoan(loanId);
      if (result > 0) {
        deleteLoanState.value = TheStates.success;
        // Refresh ledger
        final ledgerController = Get.find<LedgerController>();
        ledgerController.fetchLoans();
        showTopSnackBar(
          Overlay.of(context),
          dismissType: DismissType.onSwipe,
          onTap: () {
            ledgerController.restoreLoan(loanId);
          },
          CustomSnackBar.success(
            iconRotationAngle: 0,
            icon: Icon(Icons.undo, color: Color(0x15000000), size: 120),
            backgroundColor: DefaultColors.successGreen,
            message: "Loan deleted. Tap to Undo",
          ),
        );
        Navigator.pop(context);
      } else {
        deleteLoanState.value = TheStates.error;
      }
    } catch (e) {
      deleteLoanState.value = TheStates.error;
      print(e);
    }
  }

  Rx<TheStates> settleLoanState = TheStates.initial.obs;
  Future<void> settleLoan(
    String loanId,
    DateTime date,
    BuildContext context,
  ) async {
    try {
      settleLoanState.value = TheStates.loading;
      final result = await dbHelper.settleLoan(loanId, date);
      if (result > 0) {
        settleLoanState.value = TheStates.success;
        // Refresh ledger
        Get.find<LedgerController>().fetchLoans();
        showTopSnackBar(
          Overlay.of(context),
          dismissType: DismissType.onSwipe,
          CustomSnackBar.success(
            iconRotationAngle: 0,
            icon: Icon(Icons.check_circle, color: Color(0x15000000), size: 120),
            backgroundColor: DefaultColors.successGreen,
            message: "Loan settled successfully",
          ),
        );
        Navigator.pop(context);
      } else {
        settleLoanState.value = TheStates.error;
      }
    } catch (e) {
      settleLoanState.value = TheStates.error;
      print(e);
    }
  }

  // --- Payment Logic ---

  RxList<PaymentModel> payments = <PaymentModel>[].obs;
  Rx<TheStates> addPaymentState = TheStates.initial.obs;

  Future<void> addPayment({
    required String loanId,
    required double amount,
    required DateTime date,
    required BuildContext context,
  }) async {
    try {
      addPaymentState.value = TheStates.loading;
      final payment = PaymentModel.create(
        loanId: loanId,
        amount: amount,
        paymentDate: date,
      );

      final result = await dbHelper.insertPayment(payment.toMap());

      if (result > 0) {
        addPaymentState.value = TheStates.success;
        // Update loan's last collected date
        final db = await dbHelper.database;
        await db.update(
          'loans',
          {'last_collected_date': date.toIso8601String()},
          where: 'id = ?',
          whereArgs: [loanId],
        );

        // Refresh ledger and local payments
        Get.find<LedgerController>().fetchLoans();
        fetchPayments(loanId);

        showTopSnackBar(
          Overlay.of(context),
          dismissType: DismissType.onSwipe,
          CustomSnackBar.success(
            iconRotationAngle: 0,
            icon: Icon(Icons.check_circle, color: Color(0x15000000), size: 120),
            backgroundColor: DefaultColors.successGreen,
            message: "Payment added successfully",
          ),
        );
      } else {
        addPaymentState.value = TheStates.error;
      }
    } catch (e) {
      addPaymentState.value = TheStates.error;
      print(e);
    }
  }

  Future<void> fetchPayments(String loanId) async {
    try {
      final data = await dbHelper.getPaymentsForLoan(loanId);
      payments.value = data.map((map) => PaymentModel.fromMap(map)).toList();
    } catch (e) {
      print("Error fetching payments: $e");
    }
  }
}
