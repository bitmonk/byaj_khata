import 'package:byaz_track/core/extension/extensions.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class BottomSpacing extends StatelessWidget {
  const BottomSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalSpacing(MediaQuery.of(context).viewPadding.bottom);
  }
}
