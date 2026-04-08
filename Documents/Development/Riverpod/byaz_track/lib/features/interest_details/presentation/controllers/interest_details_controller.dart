import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/interest_details/data/source/interest_details_remote_source.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
        Get.find<LedgerController>().fetchLoans();
        showTopSnackBar(
          Overlay.of(context!),
          dismissType: DismissType.onSwipe,
          CustomSnackBar.success(
            iconRotationAngle: 0,
            icon: Icon(Icons.check_circle, color: Color(0x15000000), size: 120),
            backgroundColor: DefaultColors.successGreen,
            message: "Loan deleted successfully",
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
  Future<void> settleLoan(String loanId, BuildContext context) async {
    try {
      settleLoanState.value = TheStates.loading;
      final result = await dbHelper.settleLoan(loanId);
      if (result > 0) {
        settleLoanState.value = TheStates.success;
        // Refresh ledger
        Get.find<LedgerController>().fetchLoans();
        showTopSnackBar(
          Overlay.of(context!),
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
}
