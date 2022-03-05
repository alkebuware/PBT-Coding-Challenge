import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ptb.g.dart';

@JsonSerializable(createToJson: false)
class PrimeTimeBillboard extends Equatable {
  final List<PTBItem> items;

  const PrimeTimeBillboard({required this.items});

  factory PrimeTimeBillboard.fromJson(Map<String, dynamic> json) =>
      _$PrimeTimeBillboardFromJson(json);

  @override
  List<Object?> get props => [items];
}

enum PTBItemType {
  @JsonValue("tv series")
  tvSeries,
  channel,
  movie,
}

@JsonSerializable(createToJson: false)
class PTBItem extends Equatable {
  final String contentId;
  final String ctaData;
  final String ctaType;
  final String description;
  final String label;
  final PTBItemType type;
  @JsonKey(name: "badges")
  final PTBBadge badge;
  final List<PTBCover> covers;
  final num? channelNumber;

  const PTBItem(
      {required this.badge,
      required this.covers,
      required this.contentId,
      required this.ctaData,
      required this.ctaType,
      required this.description,
      required this.label,
      required this.type,
      this.channelNumber});

  factory PTBItem.fromJson(Map<String, dynamic> json) =>
      _$PTBItemFromJson(json);

  @override
  List<Object?> get props => [
        badge,
        covers,
        contentId,
        ctaData,
        ctaType,
        description,
        label,
        type,
        channelNumber,
      ];
}

@JsonSerializable(createToJson: false)
class PTBCover extends Equatable {
  final String aspectRatio;
  final String url;

  const PTBCover({required this.aspectRatio, required this.url});

  factory PTBCover.fromJson(Map<String, dynamic> json) =>
      _$PTBCoverFromJson(json);

  @override
  List<Object?> get props => [aspectRatio, url];
}

@JsonSerializable(createToJson: false)
class PTBBadge extends Equatable {
  final String badgeBGColor;
  final String badgeText;

  const PTBBadge({required this.badgeBGColor, required this.badgeText});

  factory PTBBadge.fromJson(Map<String, dynamic> json) =>
      _$PTBBadgeFromJson(json);

  @override
  List<Object?> get props => [badgeBGColor, badgeText];

  Color get badgeBGFlutterColor =>
      Color(int.parse(badgeBGColor.replaceAll("#", "FF"), radix: 16));
}
