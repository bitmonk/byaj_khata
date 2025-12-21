import 'package:cached_network_image/cached_network_image.dart';
import 'package:byaz_track/core/extension/extensions.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    required this.imgUrl,
    super.key,
    this.height,
    this.width,
    this.fit,
    this.errorWid,
    this.borderRadius,
  });
  final String imgUrl;
  final double? height;
  final Widget? errorWid;
  final double? width;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        height: height,
        width: width,
        fit: fit,
        // progressIndicatorBuilder:
        //     (context, url, progress) => const AppLoadingWidget.small(),
        errorWidget: (context, url, error) {
          if (errorWid != null) {
            return errorWid!;
          } else {
            return const Center(child: Text('No Image'));
          }
        },
      ),
    );
  }
}
