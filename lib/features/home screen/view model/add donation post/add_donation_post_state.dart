part of 'add_donation_post_cubit.dart';

sealed class AddDonationPostState extends Equatable {
  const AddDonationPostState();

  @override
  List<Object> get props => [];
}

final class AddDonationPostInitial extends AddDonationPostState {}

final class AddDonationPostLoading extends AddDonationPostState {}

final class AddDonationPostSuccess extends AddDonationPostState {
  final String message;
  const AddDonationPostSuccess({required this.message});
}

final class AddDonationPostError extends AddDonationPostState {}
