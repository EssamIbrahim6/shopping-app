import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/domain/use_cases/edit_user_data_usecase.dart';
import 'package:shopping_app/features/account/domain/use_cases/get_user_data_usecase.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';

part 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final EditUserDataUseCase _editUserDataUseCase;

  AccountCubit(this._getUserDataUseCase, this._editUserDataUseCase)
    : super(AccountInitial());

  UserEntity? userEntity;
  String? selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  bool isPasswordObscured = true;

  void doIntent(AccountIntent intent, {Map<String, String>? updatedData}) {
    if (intent is GetUserDataIntent) {
      getUserData();
    } else if (intent is PickImageIntent) {
      pickImage();
    } else if (intent is EditUserDataIntent) {
      editUserData(
        name: updatedData?['name'] ?? userEntity?.name ?? '',
        phone: updatedData?['phone'] ?? userEntity?.phone ?? '',
        address: updatedData?['address'] ?? userEntity?.address ?? '',
      );
    } else if (intent is TogglePasswordVisibilityIntent) {
      isPasswordObscured = !isPasswordObscured;
      emit(AccountImageSelectedState(selectedImagePath ?? ''));
    }
  }

  Future<void> getUserData({bool showSuccessMessage = false}) async {
    emit(AccountDataState(BaseLoadingState()));

    final result = await _getUserDataUseCase();

    if (result is Success<UserEntity>) {
      userEntity = result.data;
      emit(
        AccountDataState(
          BaseSuccessState(data: userEntity),
          showSuccessMessage: showSuccessMessage,
        ),
      );
    } else if (result is Error<UserEntity>) {
      emit(
        AccountDataState(BaseFailureState(errorMessage: result.messageError)),
      );
    } else {
      emit(
        AccountDataState(
          BaseFailureState(errorMessage: AppStrings.unknownError),
        ),
      );
    }
  }

  Future<void> pickImage() async {
    try {
      debugPrint("Pick Image Clicked");
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImagePath = image.path;
        emit(AccountImageSelectedState(image.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> editUserData({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(AccountDataState(BaseLoadingState()));

    final result = await _editUserDataUseCase(
      name: name,
      phone: phone,
      address: address,
      imagePath: selectedImagePath,
    );

    if (result is Success<void>) {
      selectedImagePath = null;
      await getUserData(showSuccessMessage: true);
    } else if (result is Error<void>) {
      emit(
        AccountDataState(BaseFailureState(errorMessage: result.messageError)),
      );
    } else {
      emit(
        AccountDataState(
          BaseFailureState(errorMessage: AppStrings.unknownError),
        ),
      );
    }
  }
}
