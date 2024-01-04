/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetAudioGen {
  const $AssetAudioGen();

  /// File path: asset/audio/Asemane Abri.mp3
  String get asemaneAbri => 'asset/audio/Asemane Abri.mp3';

  /// File path: asset/audio/Darandasht.mp3
  String get darandasht => 'asset/audio/Darandasht.mp3';

  /// File path: asset/audio/Kavir.mp3
  String get kavir => 'asset/audio/Kavir.mp3';

  /// List of all assets
  List<String> get values => [asemaneAbri, darandasht, kavir];
}

class $AssetImageGen {
  const $AssetImageGen();

  /// File path: asset/image/Darandasht.jpg
  AssetGenImage get darandasht =>
      const AssetGenImage('asset/image/Darandasht.jpg');

  /// File path: asset/image/Kavir.jpeg
  AssetGenImage get kavir => const AssetGenImage('asset/image/Kavir.jpeg');

  /// File path: asset/image/aseman abri.jpeg
  AssetGenImage get asemanAbri =>
      const AssetGenImage('asset/image/aseman abri.jpeg');

  /// File path: asset/image/profile.jpg
  AssetGenImage get profile => const AssetGenImage('asset/image/profile.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [darandasht, kavir, asemanAbri, profile];
}

class Assets {
  Assets._();

  static const $AssetAudioGen audio = $AssetAudioGen();
  static const $AssetImageGen image = $AssetImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
