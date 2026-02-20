// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Outfit-Bold.ttf
  String get outfitBold => 'assets/fonts/Outfit-Bold.ttf';

  /// File path: assets/fonts/Outfit-ExtraBold.ttf
  String get outfitExtraBold => 'assets/fonts/Outfit-ExtraBold.ttf';

  /// File path: assets/fonts/Outfit-Medium.ttf
  String get outfitMedium => 'assets/fonts/Outfit-Medium.ttf';

  /// File path: assets/fonts/Outfit-Regular.ttf
  String get outfitRegular => 'assets/fonts/Outfit-Regular.ttf';

  /// File path: assets/fonts/Outfit-SemiBold.ttf
  String get outfitSemiBold => 'assets/fonts/Outfit-SemiBold.ttf';

  /// List of all assets
  List<String> get values => [
    outfitBold,
    outfitExtraBold,
    outfitMedium,
    outfitRegular,
    outfitSemiBold,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/Google.svg');

  /// File path: assets/icons/Vector.svg
  SvgGenImage get vector => const SvgGenImage('assets/icons/Vector.svg');

  /// File path: assets/icons/capacity.svg
  SvgGenImage get capacity => const SvgGenImage('assets/icons/capacity.svg');

  /// File path: assets/icons/class_logo.svg
  SvgGenImage get classLogo => const SvgGenImage('assets/icons/class_logo.svg');

  /// File path: assets/icons/engine_hours.svg
  SvgGenImage get engineHours =>
      const SvgGenImage('assets/icons/engine_hours.svg');

  /// File path: assets/icons/engine_model.svg
  SvgGenImage get engineModel =>
      const SvgGenImage('assets/icons/engine_model.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/length.svg
  SvgGenImage get length => const SvgGenImage('assets/icons/length.svg');

  /// File path: assets/icons/model.svg
  SvgGenImage get model => const SvgGenImage('assets/icons/model.svg');

  /// File path: assets/icons/otpicon.svg
  SvgGenImage get otpicon => const SvgGenImage('assets/icons/otpicon.svg');

  /// File path: assets/icons/total_power.svg
  SvgGenImage get totalPower =>
      const SvgGenImage('assets/icons/total_power.svg');

  /// File path: assets/icons/year.svg
  SvgGenImage get year => const SvgGenImage('assets/icons/year.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    google,
    vector,
    capacity,
    classLogo,
    engineHours,
    engineModel,
    facebook,
    length,
    model,
    otpicon,
    totalPower,
    year,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [appLogo];
}

class $AssetsLanguagesGen {
  const $AssetsLanguagesGen();

  /// File path: assets/languages/de.json
  String get de => 'assets/languages/de.json';

  /// File path: assets/languages/en.json
  String get en => 'assets/languages/en.json';

  /// File path: assets/languages/es.json
  String get es => 'assets/languages/es.json';

  /// File path: assets/languages/fr.json
  String get fr => 'assets/languages/fr.json';

  /// File path: assets/languages/it.json
  String get it => 'assets/languages/it.json';

  /// File path: assets/languages/ja.json
  String get ja => 'assets/languages/ja.json';

  /// File path: assets/languages/zh.json
  String get zh => 'assets/languages/zh.json';

  /// List of all assets
  List<String> get values => [de, en, es, fr, it, ja, zh];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLanguagesGen languages = $AssetsLanguagesGen();
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

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
