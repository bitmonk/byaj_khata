import 'package:byaz_track/core/extension/extensions.dart';

class CustomStyledChip extends StatelessWidget {
  final String label;

  const CustomStyledChip({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F2E2E4F),
              offset: Offset(0, 6),
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLG.copyWith(
            color: AppColors.foundationBlue500,
          ),
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;

  const CustomChip({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.neutral100),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color(0x1F2E2E4F),
          //     offset: Offset(0, 6),
          //     blurRadius: 20,
          //   ),
          // ],
        ),
        child: Text(
          label,
          style: context.text.titleSmall!.copyWith(
            fontSize: 11,
            color: AppColors.neutral900,
          ),
        ),
      ),
    );
  }
}
