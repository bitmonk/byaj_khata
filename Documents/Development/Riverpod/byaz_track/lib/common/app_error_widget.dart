import 'package:byaz_track/core/extension/extensions.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    this.title = AppConstants.errorMessage,
    super.key,
    this.onTap,
    this.verticlePadding = 16,
    this.color,
  });
  final String title;
  final void Function()? onTap;
  final double verticlePadding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: verticlePadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 44, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Failed to load data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: context.text.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: color ?? Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            VerticalSpacing(16),
            if (onTap != null)
              ElevatedButton(
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: onTap,
                child: const Text('Retry', style: TextStyle(fontSize: 13)),
              ),
          ],
        ),
      ),
    );
  }
}
