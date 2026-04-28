import 'package:byaz_track/core/constants/app_colors.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:byaz_track/common/app_text_form_field.dart';
import 'package:byaz_track/features/create_loan/data/model/loan_model.dart';
import 'package:byaz_track/features/interest_details/presentation/controllers/interest_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as ndp;

class AddPaymentDialog extends StatefulWidget {
  final LoanModel loan;
  const AddPaymentDialog({super.key, required this.loan});

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ndp.NepaliDateTime _selectedDate = ndp.NepaliDateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final ndp.NepaliDateTime? picked = await ndp.showNepaliDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: ndp.NepaliDateTime(2000),
      lastDate: ndp.NepaliDateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<InterestDetailsController>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? theme.colorScheme.surface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Payment',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      isDark
                          ? AppColorsDark.textPrimary
                          : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Amount Field
              Text(
                'Amount Paid (Rs)',
                style: theme.textTheme.labelLarge?.copyWith(
                  color:
                      isDark
                          ? AppColorsDark.textSecondary
                          : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              AppTextFormField(
                labelText: 'Enter amount',
                textInputType: TextInputType.numberWithOptions(),
                onChanged: (value) {},
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'रु',
                    style: TextStyle(
                      color: AppColors.appGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid number';
                  return null;
                },
                controller: _amountController,
              ),

              const SizedBox(height: 20),

              // Date Field
              Text(
                'Payment Date (BS)',
                style: theme.textTheme.labelLarge?.copyWith(
                  color:
                      isDark
                          ? AppColorsDark.textSecondary
                          : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isDark
                              ? AppColorsDark.dividerColor
                              : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate.format('yyyy-MM-dd'),
                        style: theme.textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => ElevatedButton(
                        onPressed:
                            controller.addPaymentState.value ==
                                    TheStates.loading
                                ? null
                                : () async {
                                  if (_formKey.currentState!.validate()) {
                                    final amount = double.tryParse(
                                      _amountController.text.trim(),
                                    );
                                    if (amount != null) {
                                      await controller.addPayment(
                                        loanId: widget.loan.id,
                                        amount: amount,
                                        date: _selectedDate.toDateTime(),
                                        context: context,
                                      );
                                      if (mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF268E2A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child:
                            controller.addPaymentState.value ==
                                    TheStates.loading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: AppLoadingWidget(
                                    size: 20,
                                    color: AppColors.white,
                                  ),
                                )
                                : const Text('Save Payment'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
