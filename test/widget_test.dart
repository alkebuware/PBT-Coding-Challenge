import 'dart:io';

import 'package:coding_challenge/models/ptb.dart';
import 'package:coding_challenge/ui/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  testWidgets("PTBBadgeIndicator", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PTBBadgeIndicator(
          badge: PTBBadge(badgeBGColor: "#FFFFFF", badgeText: "LIVE")),
    ));

    final badgeTextFinder = find.text("LIVE");
    expect(badgeTextFinder, findsOneWidget);
    final color = ((tester.firstWidget(find.byType(Container)) as Container)
            .decoration as BoxDecoration)
        .color;
    expect(color, const Color(0xFF3D3D3D));
  });

  testWidgets("PTBBadgeIndicator highlighted", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PTBBadgeIndicator(
          highlight: true,
          badge: PTBBadge(badgeBGColor: "#FFFFFF", badgeText: "LIVE")),
    ));

    final badgeTextFinder = find.text("LIVE");
    expect(badgeTextFinder, findsOneWidget);
    final color = ((tester.firstWidget(find.byType(Container)) as Container)
            .decoration as BoxDecoration)
        .color;
    expect(color, const Color(0xFFFFFFFF));
  });

  testWidgets("PTBItemListIndex", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Material(
        child: PTBItemListIndex(
            item: PTBItem(
                badge: PTBBadge(badgeBGColor: "#FFFFFF", badgeText: "LIVE"),
                covers: [
                  PTBCover(
                      aspectRatio: "",
                      url:
                          "http://pluto.tv.s3.amazonaws.com/episodes/617031fb4f409e001a493708/screenshot16_9.jpg")
                ],
                contentId: "",
                ctaData: "",
                ctaType: "",
                description: "Hello World",
                label: "Hello World The Movie",
                type: PTBItemType.movie)),
      ),
    ));

    final labelTextFinder = find.text("Hello World The Movie");
    expect(labelTextFinder, findsOneWidget);
    final url = ((tester.firstWidget(find.byType(Image)) as Image).image
            as NetworkImage)
        .url;
    expect(url,
        "http://pluto.tv.s3.amazonaws.com/episodes/617031fb4f409e001a493708/screenshot16_9.jpg");
  });
}
