part of 'get_page_members_cubit.dart';

sealed class GetPageMembersState extends Equatable {
  const GetPageMembersState();

  @override
  List<Object> get props => [];
}

final class GetPageMembersInitial extends GetPageMembersState {}

final class GetPageMembersLoading extends GetPageMembersState {}

final class GetPageMembersSuccess extends GetPageMembersState {
  final PageProfileModel page;
  const GetPageMembersSuccess({required this.page});
}

final class GetPageMembersError extends GetPageMembersState {}
