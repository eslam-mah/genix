import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_payout_state.dart';

class PostPayoutCubit extends Cubit<PostPayoutState> {
  PostPayoutCubit() : super(PostPayoutInitial());
}
