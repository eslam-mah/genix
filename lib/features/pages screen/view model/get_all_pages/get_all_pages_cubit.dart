import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_all_pages_state.dart';

class GetAllPagesCubit extends Cubit<GetAllPagesState> {
  GetAllPagesCubit() : super(GetAllPagesInitial());
}
