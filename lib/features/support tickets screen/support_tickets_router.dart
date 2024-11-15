import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/delete%20ticket%20comment/delete_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/delete%20ticket/delete_ticket_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/get%20all%20tickets/get_all_tickets_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/get%20tickets%20by%20id/get_tickets_by_id_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket%20comment/post_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket/post_ticket_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket%20comment/update_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket%20status/update_ticket_status_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket/update_ticket_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/views/view/support_ticket_item_page.dart';
import 'package:genix/features/support%20tickets%20screen/views/view/support_tickets_page.dart';
import 'package:go_router/go_router.dart';

abstract class SupportTicketsRouter {
  static final getAllTicketsCubit = GetAllTicketsCubit();
  static final getTicketByIdCubit = GetTicketsByIdCubit();
  static final postTicketCubit = PostTicketCubit();
  static final updateTicketCubit = UpdateTicketCubit();
  static final updateTicketStatusCubit = UpdateTicketStatusCubit();
  static final deleteTicketCubit = DeleteTicketCubit();
  static final postTicketCommentCubit = PostTicketCommentCubit();
  static final updateTicketCommentCubit = UpdateTicketCommentCubit();
  static final deleteTicketCommentCubit = DeleteTicketCommentCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: SupportTicketsPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getAllTicketsCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: getTicketByIdCubit,
              ),
              BlocProvider.value(
                value: postTicketCubit,
              ),
              BlocProvider.value(
                value: updateTicketCubit,
              ),
              BlocProvider.value(
                value: deleteTicketCubit,
              ),
              BlocProvider.value(
                value: updateTicketStatusCubit,
              ),
            ],
            child: SupportTicketsPage(),
          );
        }),
    GoRoute(
        path: TicketItemPage.route,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;

          final ticket = extraData['ticket'] as TicketsModel;
          final refresh = extraData['refresh'] as Function();
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getAllTicketsCubit,
              ),
              BlocProvider.value(
                value: getTicketByIdCubit,
              ),
              BlocProvider.value(
                value: postTicketCubit,
              ),
              BlocProvider.value(
                value: updateTicketCubit,
              ),
              BlocProvider.value(
                value: deleteTicketCubit,
              ),
              BlocProvider.value(
                value: postTicketCommentCubit,
              ),
              BlocProvider.value(
                value: updateTicketCommentCubit,
              ),
              BlocProvider.value(
                value: deleteTicketCommentCubit,
              ),
              BlocProvider.value(
                value: updateTicketStatusCubit,
              ),
            ],
            child: TicketItemPage(
              ticket: ticket,
              refresh: refresh,
            ),
          );
        })
  ];
}
