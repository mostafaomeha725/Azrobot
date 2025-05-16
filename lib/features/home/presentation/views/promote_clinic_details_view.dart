import 'package:azrobot/features/home/presentation/views/widgets/promote_clinic_details_view_body.dart';
import 'package:flutter/material.dart';

class PromoteClinicDetailsView extends StatelessWidget {
  const PromoteClinicDetailsView({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff63a4b6)),
        child: PromoteClinicDetailsViewBody(item: item),
      ),
    );
  }
}
