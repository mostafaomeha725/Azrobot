import 'package:azrobot/features/home/presentation/views/widgets/Life_style_details_view_body.dart';
import 'package:azrobot/features/home/presentation/views/widgets/video_details_view_body.dart';
import 'package:flutter/material.dart';

class VideoDetailsView extends StatelessWidget {
  const VideoDetailsView({super.key, required this.item});
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: VideoDetailsViewBody(item: item));
  }
}
