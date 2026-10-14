import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/base_state/base_state.dart';
import 'package:shopping_app/core/common/base_state/base_state_builder.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/account_loading_shimmer_widget.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/account_success_section_widget.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountDataState) {
            if (state.state is BaseSuccessState<UserEntity?>) {
              final user = (state.state as BaseSuccessState<UserEntity?>).data;
              if (user != null) {
                nameController.text = user.name;
                emailController.text = user.email;
                phoneController.text = user.phone;
                addressController.text = user.address;
              }
              if (state.showSuccessMessage) {
                _showSuccessSnackBar(context, AppStrings.accountSuccessMessage);
              }
            } else if (state.state is BaseFailureState) {
              final errorMsg = (state.state as BaseFailureState).errorMessage;
              _showErrorSnackBar(context, errorMsg);
            }
          }
        },
        builder: (context, state) {
          final cubit = context.read<AccountCubit>();

          BaseState<UserEntity?> currentBaseState;
          if (state is AccountDataState) {
            currentBaseState = state.state;
          } else {
            currentBaseState = BaseSuccessState(data: cubit.userEntity);
          }

          return BaseStateBuilder<UserEntity?>(
            state: currentBaseState,
            onLoading: () => const AccountLoadingShimmer(),
            onError: (error) => _AccountErrorSection(
              error: error,
              onRetry: () => cubit.doIntent(GetUserDataIntent()),
            ),
            onSuccess: (data) => AccountSuccessSection(
              cubit: cubit,
              data: data,
              nameController: nameController,
              emailController: emailController,
              phoneController: phoneController,
              addressController: addressController,
            ),
          );
        },
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: theme.colorScheme.onPrimary),
            horizontalSpace(AppSpacing.x1),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.x1),
        ),
        margin: AppSpacing.allX2,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String errorMsg) {
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: theme.colorScheme.onError),
            horizontalSpace(AppSpacing.x1),
            Expanded(
              child: Text(
                errorMsg,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.x1),
        ),
        margin: AppSpacing.allX2,
      ),
    );
  }
}

class _AccountErrorSection extends StatelessWidget {
  const _AccountErrorSection({required this.error, required this.onRetry});

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppSpacing.allX2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: AppColors.error),
            verticalSpace(AppSpacing.x2),
            Text(
              error,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.error,
              ),
            ),
            verticalSpace(AppSpacing.x2),
            SizedBox(
              width: double.infinity,
              child: PrimaryBtn(
                onPressed: onRetry,
                child: Padding(
                  padding: AppSpacing.allX1,
                  child: Text(
                    AppStrings.accountTryAgain,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
