import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflitetest/data/model/itemresponse.dart';

import 'data/itemrepository.dart';

part 'basic_info_state.dart';

class BasicInfoCubit extends Cubit<BasicInfoState> {
  BasicInfoCubit() : super(BasicInfoInitial());

  final userRepository = ItemRepository();


  void loadInfo() async {
    if (state is BasicInfoLoading) return;

    emit(BasicInfoLoading());

    final users = await userRepository.fetchItemFromApiAndDatabase();

    final users2 = users.toList();

    emit(BasicInfoLoaded(users2, users2));
  }

  void search(String value) {
    final currentState = state;
    if (!(currentState is BasicInfoLoaded)) return;

    if (value.isNotEmpty) {
      final filteredUsers = currentState.basicInfoList
          .where((x) =>
      x.title?.toLowerCase().contains(value.toLowerCase()) == true)
          .toList();

      emit(BasicInfoLoaded(currentState.originalList, filteredUsers));
    } else {
      emit(BasicInfoLoaded(currentState.originalList, currentState.originalList));
    }
  }

}
