import 'package:azrobot/core/utils/app_images.dart';
import 'package:azrobot/core/utils/app_text_styles.dart';

import 'package:azrobot/features/on_boarding/view/widgets/line_border_painter.dart';
import 'package:azrobot/features/on_boarding/view/widgets/score_point_widgets.dart';
import 'package:flutter/material.dart';

class UsedOfferHistory extends StatelessWidget {
  UsedOfferHistory({super.key});
  final List<Map<String, String>> offers = [
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
    {
      "title": "B-Tech Voucher",
      "description": "300 EGP Off Minimum order 5000 EGP",
      "points": "150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth > 600 ? 0.65 : 0.8;
          return GridView.builder(
            itemCount: offers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomPaint(
                  painter: DashedBorderPainter(), // Draw dashed border
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(children: [ScorePointWidgets(point: '0',), SizedBox()]),
                        const SizedBox(height: 8),
                        Center(
                          child: Image.asset(
                            Assets.assetsBtech,
                            height: constraints.maxWidth > 600 ? 70 : 50,
                          ),
                        ),
                        Text(
                          offer["title"]!,
                          style: TextStyles.bold16w600.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            offer["description"]!,
                            style: TextStyles.bold12w400.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
