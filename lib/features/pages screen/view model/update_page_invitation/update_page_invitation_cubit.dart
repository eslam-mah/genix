import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_page_invitation_state.dart';

class UpdatePageInvitationCubit extends Cubit<UpdatePageInvitationState> {
  UpdatePageInvitationCubit() : super(UpdatePageInvitationInitial());
}
