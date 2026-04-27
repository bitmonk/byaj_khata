import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:byaz_track/core/db/database_helper.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/ledger/presentation/controllers/ledger_controller.dart';
import 'package:byaz_track/features/ledger/presentation/widgets/ledger_list_item_card.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:byaz_track/features/create_loan/data/source/create_loan_remote_source.dart';
import 'package:logger/web.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  TextEditingController rateValueController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void setStartDate(NepaliDateTime? date) => startDate.value = date;

  void prefillData(LoanModel loan) {
    transactionType.value = loan.transactionType == '0' ? 0 : 1;
    principalAmountController.text = loan.principalAmount.toString();
    startDate.value = loan.startDate.toNepaliDateTime();
    interestRateType.value = loan.interestType == '0' ? 0 : 1;
    rateValue.value = loan.rateValue.toString();
    rateValueController.text = loan.rateValue.toString();
    partyNameController.text = loan.partyName;
    notesController.text = loan.notes ?? '';
  }

  void resetData() {
    transactionType.value = 0;
    principalAmountController.clear();
    startDate.value = NepaliDateTime.now();
    interestRateType.value = 0;
    rateValue.value = '';
    rateValueController.clear();
    partyNameController.clear();
    notesController.clear();
  }

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
      final userId = Supabase.instance.client.auth.currentUser?.id;

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
        userId: userId,
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
      Get.find<LedgerController>().fetchLoans();
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

  Future<void> updateLoan({
    required String id,
    required String transactionType,
    required int principalAmount,
    required DateTime startDate,
    required String interestType,
    required double rateValue,
    required String partyName,
    String? notes,
    required LedgerItemStatus loanStatus,
    required DateTime createdAt,
    BuildContext? context,
  }) async {
    final db = await DatabaseHelper.instance.database;

    try {
      final now = DateTime.now();
      final userId = Supabase.instance.client.auth.currentUser?.id;

      final loan = LoanModel(
        id: id,
        transactionType: transactionType,
        principalAmount: principalAmount,
        startDate: startDate,
        interestType: interestType,
        rateValue: rateValue,
        partyName: partyName,
        notes: notes,
        createdAt: createdAt,
        updatedAt: now,
        syncStatus: 'pending',
        loanStatus: loanStatus,
        userId: userId,
      );

      final result = await db.update(
        'loans',
        loan.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      debugPrint('Loan updated successfully: $result');
      showTopSnackBar(
        Overlay.of(context!),
        dismissType: DismissType.onSwipe,
        CustomSnackBar.success(
          iconRotationAngle: 0,
          icon: Icon(Icons.check_circle, color: Color(0x15000000), size: 120),
          backgroundColor: DefaultColors.successGreen,
          message: "Loan updated successfully",
        ),
      );
      Get.find<LedgerController>().fetchLoans();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Error updating loan: $e');
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,

        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Failed to update loan.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context!)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Rx<TheStates> loadContactState = TheStates.initial.obs;
  RxBool hasContactPermission = false.obs;
  RxList<Contact> contacts = <Contact>[].obs;
  List<Contact> allContacts = [];

  Future<List<Contact>> loadContacts() async {
    print('loading contacts');
    try {
      final status = await Permission.contacts.request();
      print('contact permission status: $status');
      loadContactState.value = TheStates.loading;
      if (status.isGranted) {
        final rawContacts = await FastContacts.getAllContacts();
        allContacts = rawContacts;
        loadContactState.value = TheStates.success;
        hasContactPermission.value = true;
        contacts.assignAll(rawContacts);
        return rawContacts;
      } else {
        hasContactPermission.value = false;
        loadContactState.value = TheStates.error;
        allContacts.clear();
        contacts.clear();
        return [];
      }
    } catch (e) {
      loadContactState.value = TheStates.error;
      debugPrint('Error getting contacts: $e');
      allContacts.clear();
      contacts.clear();
      return [];
    }
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      contacts.assignAll(allContacts);
      return;
    }
    contacts.assignAll(
      allContacts
          .where(
            (contact) =>
                contact.displayName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList(),
    );
  }
}
