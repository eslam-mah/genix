import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/custom_small_user_profile_image.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/features/drawer/view/customdrawerwidget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/core/widgets/glowingbuttonbody.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_support_tickets_h_counter.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_support_tickets_v_counter.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_tickets_item.dart';
import 'package:go_router/go_router.dart';

class SupportTicketsPage extends StatefulWidget {
  const SupportTicketsPage({super.key});

  @override
  State<SupportTicketsPage> createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends State<SupportTicketsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isSelected ? AppColors.kAppBar2Color : Colors.white,
      key: _scaffoldKey,
      bottomNavigationBar: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomBottomAppBar(
              isNightMode: isNightModeEnabled,
            ),
            Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: CustomGlowingButton(isSelected: isSelected),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.barsStaggered,
              size: 18.sp,
            ), // Custom icon
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
            },
          ),
        ],
        backgroundColor: AppColors.kAppBar2Color,
        elevation: 0,
        title: const CustomAppBar(),
      ),
      endDrawer: CustomDrawerWidget(
        onNightModeChanged: handleNightModeChanged,
        isNightMode: isNightModeEnabled,
      ),
      body: isSelected
          ? const GlowingButtonBody()
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: const CustomHeaderWidget(text: 'Support tickets'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
                    child: Row(
                      children: [
                        CustomSupportTicketsHCounter(
                            number: 3, text: 'TOTAL TICKETS'),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomSupportTicketsHCounter(
                            number: 3, text: 'OPEN ISSUES'),
                        SizedBox(
                          width: 20.w,
                        ),
                        CustomSupportTicketsHCounter(
                            number: 3, text: 'SOLVED TICKETS'),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomSupportTicketsVCounter(
                          text:
                              'If you would prefer to contact us by email, please send us your inquiry to:',
                          icon: FontAwesomeIcons.envelope,
                          title: 'Email',
                          buttonText: 'Send mail',
                          buttonIcon: FontAwesomeIcons.link,
                        ),
                        CustomSupportTicketsVCounter(
                          text:
                              'If you read this line it looks like your issue is really serious.. please let us know more about this, we will help you for sure.',
                          icon: FontAwesomeIcons.lifeRing,
                          title: 'Support',
                          buttonText: 'Open ticket',
                          buttonIcon: FontAwesomeIcons.plus,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h,
                  ),
                ),
                SliverToBoxAdapter(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      height: 2 * 46.5.h,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(Rout.kTicketItemPage);
                              },
                              child: const CustomTicketsItem());
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
    );
  }
}
