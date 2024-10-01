import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkPost extends StatelessWidget {
  final PostsModel postsModel;
  final bool isNightMode;
  const LinkPost(
      {super.key, required this.postsModel, required this.isNightMode});

  @override
  Widget build(BuildContext context) {
    Future<void> launchUrl(String urlString) async {
      if (await canLaunch(urlString)) {
        await launch(urlString);
      } else {
        throw 'Could not launch $urlString';
      }
    }

    return InkWell(
      onTap: () {
        launchUrl(postsModel.ogInfo?.url ?? 'https://www.google.com/');
      },
      borderRadius: BorderRadius.circular(10.r),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white.withOpacity(0.3)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                    width: 100.r, imageUrl: postsModel.ogInfo?.image ?? ''),
                SizedBox(
                  width: 210.w,
                  height: 55.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        textSize: 12.sp,
                        fontFamily: '',
                        fontWeight: FontWeight.normal,
                        text: postsModel.ogInfo?.siteName ?? '',
                        isNightMode: isNightMode,
                      ),
                      CustomTextWidget(
                          textSize: 12.sp,
                          isNightMode: isNightMode,
                          fontFamily: '',
                          fontWeight: FontWeight.bold,
                          text: postsModel.ogInfo?.title ?? ''),
                      CustomTextWidget(
                          textSize: 12.sp,
                          isNightMode: isNightMode,
                          fontFamily: '',
                          fontWeight: FontWeight.normal,
                          text: postsModel.ogInfo?.url ?? '')
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
