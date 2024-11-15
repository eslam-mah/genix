import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/event_widget.dart';

class EventPost extends StatelessWidget {
  final PostsModel postsModel;
  final bool? isNightMode;
  const EventPost({super.key, required this.postsModel, this.isNightMode});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EventWidget(
            icon: FontAwesomeIcons.calendar,
            text: 'Location',
            eventText: postsModel.misc?.checkin ?? '',
            isNightMode: isNightMode ?? false,
          ),
          EventWidget(
            icon: FontAwesomeIcons.clock,
            text: 'Timestamp',
            eventText: postsModel.misc?.timestamp ?? '',
            isNightMode: isNightMode ?? false,
          ),
        ],
      ),
    );
  }
}
