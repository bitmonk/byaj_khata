// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Fonseca-Bold.otf
  String get fonsecaBold => 'assets/fonts/Fonseca-Bold.otf';

  /// File path: assets/fonts/Fonseca.otf
  String get fonseca => 'assets/fonts/Fonseca.otf';

  /// File path: assets/fonts/Inter_18pt-Black.ttf
  String get inter18ptBlack => 'assets/fonts/Inter_18pt-Black.ttf';

  /// File path: assets/fonts/Inter_18pt-Bold.ttf
  String get inter18ptBold => 'assets/fonts/Inter_18pt-Bold.ttf';

  /// File path: assets/fonts/Inter_18pt-ExtraBold.ttf
  String get inter18ptExtraBold => 'assets/fonts/Inter_18pt-ExtraBold.ttf';

  /// File path: assets/fonts/Inter_18pt-ExtraLight.ttf
  String get inter18ptExtraLight => 'assets/fonts/Inter_18pt-ExtraLight.ttf';

  /// File path: assets/fonts/Inter_18pt-Light.ttf
  String get inter18ptLight => 'assets/fonts/Inter_18pt-Light.ttf';

  /// File path: assets/fonts/Inter_18pt-Medium.ttf
  String get inter18ptMedium => 'assets/fonts/Inter_18pt-Medium.ttf';

  /// File path: assets/fonts/Inter_18pt-Regular.ttf
  String get inter18ptRegular => 'assets/fonts/Inter_18pt-Regular.ttf';

  /// File path: assets/fonts/Inter_18pt-SemiBold.ttf
  String get inter18ptSemiBold => 'assets/fonts/Inter_18pt-SemiBold.ttf';

  /// File path: assets/fonts/Inter_18pt-Thin.ttf
  String get inter18ptThin => 'assets/fonts/Inter_18pt-Thin.ttf';

  /// List of all assets
  List<String> get values => [
    fonsecaBold,
    fonseca,
    inter18ptBlack,
    inter18ptBold,
    inter18ptExtraBold,
    inter18ptExtraLight,
    inter18ptLight,
    inter18ptMedium,
    inter18ptRegular,
    inter18ptSemiBold,
    inter18ptThin,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Byaj Khata.png
  AssetGenImage get byajKhata =>
      const AssetGenImage('assets/images/Byaj Khata.png');

  /// List of all assets
  List<AssetGenImage> get values => [byajKhata];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
