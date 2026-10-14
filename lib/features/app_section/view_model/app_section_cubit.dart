import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppSectionCubit extends Cubit<int> {
  AppSectionCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
