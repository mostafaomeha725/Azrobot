import 'package:azrobot/features/home/presentation/views/widgets/medical_hub_details_view_body.dart';
import 'package:flutter/material.dart';

class MedicalHubDetailsView extends StatelessWidget {
  const MedicalHubDetailsView({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MedicalHubDetailsViewBody(item: item),
    );
  }
}
