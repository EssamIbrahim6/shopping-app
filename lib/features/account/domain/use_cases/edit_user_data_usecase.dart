import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart';

@injectable
class EditUserDataUseCase {
  final AccountRepoInterface _repository;

  EditUserDataUseCase(this._repository);

  Future<ResultApi<void>> call({
    required String name,
    required String phone,
    required String address,
    String? imagePath,
  }) async {
    return await _repository.editUserData(
      name: name,
      phone: phone,
      address: address,
      imagePath: imagePath,
    );
  }
}
