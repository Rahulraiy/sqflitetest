part of 'basic_info_cubit.dart';


@immutable
abstract class BasicInfoState {}

class BasicInfoInitial extends BasicInfoState {}


class BasicInfoLoaded extends BasicInfoState {
  final List<ItemResponse> originalList;
  final List<ItemResponse> basicInfoList;

  BasicInfoLoaded(
      this.originalList,
      this.basicInfoList,
      );
}

class BasicInfoLoading extends BasicInfoState {
  BasicInfoLoading();
}


