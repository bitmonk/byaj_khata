import 'package:byaz_track/core/extension/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final Widget icon;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A1E).withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child:
                isLoading
                    ? Center(
                      child: LoadingAnimationWidget.beat(
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                    : Row(
                      children: [
                        SizedBox(width: 24, height: 24, child: icon),
                        const Spacer(),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white38,
                          size: 20,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
