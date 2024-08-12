import 'package:flutter/material.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/no_items_found_indicator.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/views/widgets/link_post_item_profile.dart';
import 'package:genix/features/profile%20screen/views/widgets/post_item_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/pref_keys.dart';

enum PostType { image, video, poll, link, event, short, content }

class RecentPostsList extends StatefulWidget {
  final ProfileModel profileModel;
  const RecentPostsList({
    super.key,
    required this.profileModel,
  });

  @override
  State<RecentPostsList> createState() => _RecentPostsListState();
}

class _RecentPostsListState extends State<RecentPostsList> {
  bool isSelected = false;
  bool isNightModeEnabled = false;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    final recentPosts = widget.profileModel.data?.recentPosts ?? [];

    return Container(
      height: recentPosts.isEmpty ? 0 : recentPosts.length * 250.h,
      child: ListView.builder(
        itemCount: recentPosts.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final postTypes = _determinePostTypes(widget.profileModel, index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                _getPostTypeWidgets(postTypes, widget.profileModel, index),
          );
        },
      ),
    );
  }

  List<PostType> _determinePostTypes(ProfileModel profile, int index) {
    final List<PostType> postTypes = [];
    final post = profile.data?.recentPosts?[index];
    if (post?.uploads != null) {
      if (post!.uploads!.any((upload) =>
          upload.type == "image/png" ||
          upload.type == "image/jpeg" ||
          upload.type == "image/webp")) {
        postTypes.add(PostType.image);
      }
      if (post.uploads!.any((upload) => upload.type == 'video')) {
        postTypes.add(PostType.video);
      }
    }
    if (post!.misc != null && post.misc!.poll != null) {
      postTypes.add(PostType.poll);
    }
    if (post.ogInfo != null) {
      postTypes.add(PostType.link);
    }
    if (post.isEvent == true) {
      postTypes.add(PostType.event);
    }
    if (post.isVideoShort == true) {
      postTypes.add(PostType.short);
    }
    if (post.uploads == null && post.ogInfo == null && post.misc == null) {
      postTypes.add(PostType.content);
    }
    return postTypes;
  }

  List<Widget> _getPostTypeWidgets(
      List<PostType> postTypes, ProfileModel profileModel, int index) {
    return postTypes
        .map((postType) => _getPostType(postType, profileModel, index))
        .toList();
  }

  Widget _getPostType(PostType postType, ProfileModel profileModel, int index) {
    switch (postType) {
      case PostType.image:
        return PostItemProfile(
          isNightModeEnabled: isNightModeEnabled,
          profileModel: profileModel,
          index: index,
        );
      case PostType.video:
        return Text('video');
      case PostType.poll:
        return Text('poll');
      case PostType.event:
        return Text('event');
      case PostType.link:
        return LinkPostItemProfile(
          isNightModeEnabled: isNightModeEnabled,
          profileModel: profileModel,
          index: index,
        ); // Implement link widget
      case PostType.short:
        return Text('short'); // Implement short video widget
      case PostType.content:
        return Text('content'); // Implement content widget
      default:
        return const SizedBox.shrink();
    }
  }
}
