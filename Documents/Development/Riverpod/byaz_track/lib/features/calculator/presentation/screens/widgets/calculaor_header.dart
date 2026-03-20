import 'package:byaz_track/core/extension/extensions.dart';

class InterestCalculateHeader extends StatelessWidget {
  const InterestCalculateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Interest Calculator',
                style: context.text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sawa & Byaj',
                style: context.text.bodyLarge?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.help_outline,
              size: 20,
              color: Colors.black54,
            ),
            tooltip: 'Calculator help',
          ),
        ),
      ],
    );
  }
}
