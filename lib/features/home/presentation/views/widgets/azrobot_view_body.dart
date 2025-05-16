import 'package:azrobot/core/utils/app_text_styles.dart';
import 'package:azrobot/features/account/presentation/widgets/active_offer_history.dart';
import 'package:azrobot/features/home/presentation/views/widgets/safeare_home.dart';
import 'package:flutter/material.dart';

class AzrobotViewBody extends StatelessWidget {
  const AzrobotViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double headerHeight = size.height * 0.35; // 30% of screen height

    return SingleChildScrollView(
      // Make entire page scrollable
      child: Column(
        children: [
          // Responsive Stack header
          Stack(
            children: [
              Container(
                height: headerHeight,
                decoration: const BoxDecoration(
                  color: Color(0xFF0062CC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              const SafeareHome(isPlaying: true),
            ],
          ),
          //  const SizedBox(height: 8),
          Text(
            "Offers",
            style: TextStyles.bold18w600,
          ),
          const SizedBox(height: 16),
          // Active Offer History
          SizedBox(
            height: size.height * 0.5, // Takes half the screen height
            child: ActiveOfferHistory(),
          ),
        ],
      ),
    );
  }
}
