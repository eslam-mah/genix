import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/search%20page/data/repos/search_repository.dart';
import 'package:genix/features/users/data/models/users_list.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final SearchRepository searchRepo = SearchRepository();

  Future<void> searchByUser({required String query}) async {
    emit(SearchByUserLoading());
    final result = await searchRepo.searchByUser(query: query);
    result.fold((r) => emit(SearchByUserError()), (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(SearchByUserSuccess(users: users));
    });
  }

  Future<void> searchByGroup({required String query}) async {
    emit(SearchByGroupLoading());
    final result = await searchRepo.searchByGroup(query: query);
    result.fold((r) => emit(SearchByGroupError()), (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(SearchByGroupSuccess(users: users));
    });
  }

  Future<void> searchByPage({required String query}) async {
    emit(SearchByPageLoading());
    final result = await searchRepo.searchByPage(query: query);
    result.fold((r) => emit(SearchByPageError()), (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(SearchByPageSuccess(users: users));
    });
  }
}
