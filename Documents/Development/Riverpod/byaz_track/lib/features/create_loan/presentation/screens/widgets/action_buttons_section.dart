import 'package:byaz_track/core/extension/extensions.dart';

class ActionButtonsSection extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String? buttonText;

  const ActionButtonsSection({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onSave,
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 22,
          ),
          label: Text(
            buttonText ?? 'Save Transaction',
            style: context.text.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
        const VerticalSpacing(12),
        TextButton(
          onPressed: onCancel,
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Cancel',
            style: context.text.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
