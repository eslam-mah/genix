import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/default_status_indicators/first_page_error_indicator.dart';
import 'package:genix/core/default_status_indicators/first_page_progress_indicator.dart';
import 'package:genix/core/default_status_indicators/new_page_progress_indicator.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/glowingbuttonbody.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/get%20all%20tickets/get_all_tickets_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket/post_ticket_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket/update_ticket_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/views/view/support_ticket_item_page.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_support_tickets_h_counter.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_support_tickets_v_counter.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/custom_tickets_item.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SupportTicketsPage extends StatefulWidget {
  const SupportTicketsPage({
    super.key,
  });
  static const String route = '/supportTickets';

  @override
  State<SupportTicketsPage> createState() => _SupportTicketsPageState();
}

class _SupportTicketsPageState extends State<SupportTicketsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  final PagingController<int, TicketsModel> _pagingController =
      PagingController(firstPageKey: 1);
  int _nextPageKey = 1;
  late GetAllTicketsCubit getAllTicketsCubit;

  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;

    context.read<GetAllTicketsCubit>().getAllTickets();
    getAllTicketsCubit = BlocProvider.of<GetAllTicketsCubit>(context);
    _pagingController.addPageRequestListener((page) {
      print('**********PAGEKEY************ $page');
      getAllTicketsCubit.getAllTickets();
    });
  }

  Future<void> _fetchPage(List<TicketsModel> ticketsList) async {
    try {
      final newItems = ticketsList;
      print('fetch:: ${newItems.length}');
      final isLastPage = newItems.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _nextPageKey = _nextPageKey + 1;
        _pagingController.appendPage(newItems, _nextPageKey);
      }
    } catch (error) {
      print('Pagination error: ${error.toString()}');
      _pagingController.error = error;
    }
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetAllTicketsCubit, GetAllTicketsState>(
          listener: (context, state) {
            if (state is GetAllTicketsSuccess) {
              print('LENGTH All:: ${state.tickets.data.collection.length}');
              print('RESPONSE:: ${state.tickets.data.collection}');
              _fetchPage(state.tickets.data.collection);
            }
          },
        ),
        BlocListener<PostTicketCubit, PostTicketState>(
          listener: (context, addState) {
            if (addState is PostTicketSuccess) {
              List<TicketsModel> items = _pagingController.itemList ?? [];
              items.insert(0, addState.ticket);
              _pagingController.itemList = items;
              print('adding success');
              setState(() {});
            }
          },
        ),
        BlocListener<UpdateTicketCubit, UpdateTicketState>(
          listener: (context, updateState) {
            if (updateState is UpdateTicketSuccess) {
              final int? index =
                  _pagingController.itemList?.indexWhere((oldPost) {
                return (oldPost.id == updateState.ticket.id);
              });
              if (index != null && index >= 0) {
                _pagingController.itemList?[index] = updateState.ticket;
                setState(() {});
              }
            }
          },
        ),
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
          },
        )
      ],
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const CustomBottomAppBar(),
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
          elevation: 0,
          title: const CustomAppBar(),
        ),
        endDrawer: CustomDrawerWidget(
          isNightMode: isNightModeEnabled,
        ),
        body: isSelected
            ? const GlowingButtonBody()
            : BlocBuilder<GetAllTicketsCubit, GetAllTicketsState>(
                builder: (context, state) {
                  if (state is GetAllTicketsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ),
                    );
                  } else if (state is GetAllTicketsSuccess) {
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        const SliverToBoxAdapter(
                          child: CustomHeaderWidget(text: 'Support tickets'),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 40.h),
                            child: Row(
                              children: [
                                CustomSupportTicketsHCounter(
                                  number: state.tickets.data.totalCount,
                                  text: 'TOTAL TICKETS',
                                  isNightMode: isNightModeEnabled,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                CustomSupportTicketsHCounter(
                                  number: state.tickets.data.openCount,
                                  text: 'OPEN ISSUES',
                                  isNightMode: isNightModeEnabled,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                CustomSupportTicketsHCounter(
                                  number: state.tickets.data.solvedCount,
                                  text: 'SOLVED TICKETS',
                                  isNightMode: isNightModeEnabled,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: const Row(
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
                          child: SizedBox(
                            height: 100.h,
                            child: PagedListView<int, TicketsModel>(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              pagingController:
                                  _pagingController, // Assuming this is the controller for tickets
                              builderDelegate:
                                  PagedChildBuilderDelegate<TicketsModel>(
                                animateTransitions: true,
                                firstPageErrorIndicatorBuilder: (_) =>
                                    FirstPageErrorIndicator(
                                  onTryAgain: () => _pagingController.refresh(),
                                ),
                                firstPageProgressIndicatorBuilder: (_) =>
                                    FirstPageProgressIndicator(),
                                newPageProgressIndicatorBuilder: (_) =>
                                    const Center(
                                  child: NewPageProgressIndicator(),
                                ),
                                noItemsFoundIndicatorBuilder: (_) =>
                                    SizedBox.shrink(),
                                itemBuilder: (context, item, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      GoRouter.of(context).push(
                                          TicketItemPage.route,
                                          extra: item);
                                    },
                                    child: CustomTicketsItem(
                                      ticket: item,
                                    ), // Passing the ticket item
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 20.h,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CustomTextWidget(
                        textSize: 18.sp,
                        fontFamily: '',
                        fontWeight: FontWeight.normal,
                        text: 'Error loading Tickets',
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
