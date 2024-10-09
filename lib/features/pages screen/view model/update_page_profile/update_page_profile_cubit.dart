import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_page_profile_state.dart';

class UpdatePageProfileCubit extends Cubit<UpdatePageProfileState> {
  UpdatePageProfileCubit() : super(UpdatePageProfileInitial());
}
