part of 'update_page_details_cubit.dart';

sealed class UpdatePageDetailsState extends Equatable {
  const UpdatePageDetailsState();

  @override
  List<Object> get props => [];
}

final class UpdatePageDetailsInitial extends UpdatePageDetailsState {}

final class UpdatePageDetailsLoading extends UpdatePageDetailsState {}

final class UpdatePageDetailsSuccess extends UpdatePageDetailsState {
  final Map<String, dynamic> data;
  const UpdatePageDetailsSuccess({required this.data});
}

final class UpdatePageDetailsError extends UpdatePageDetailsState {}
