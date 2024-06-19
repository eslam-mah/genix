import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_payouts_state.dart';

class GetAllPayoutsCubit extends Cubit<GetAllPayoutsState> {
  GetAllPayoutsCubit() : super(GetAllPayoutsInitial());
}
