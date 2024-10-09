import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_page_members_state.dart';

class GetPageMembersCubit extends Cubit<GetPageMembersState> {
  GetPageMembersCubit() : super(GetPageMembersInitial());
}
