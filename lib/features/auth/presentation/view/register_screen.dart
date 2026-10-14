import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/common/widgets/custom_text_form_field.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/core/utils/app_dialog.dart';
import 'package:shopping_app/core/utils/app_toastfication.dart';
import 'package:shopping_app/core/utils/validator.dart';
import 'package:shopping_app/features/auth/domain/entity/register_entity.dart';
import 'package:shopping_app/features/auth/presentation/view_model/cubit/register/register_cubit.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.signUp,
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            AppToast.showToast(
              title: AppStrings.successTitle,
              description: AppStrings.successRegisterMessage,
              type: ToastificationType.success,
              context: context,
            );
            Navigator.pushNamed(context, AppRoutes.loginRoute);
          } else if (state is RegisterLoading) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is RegisterFailure) {
            AppToast.showToast(
              title: AppStrings.errorTitle,
              description: state.message,
              type: ToastificationType.error,
              context: context,
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.x2),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20),
                Text(
                  AppStrings.userName,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  controller: userNameController,
                  validator: Validator.validateName,
                  hintText: AppStrings.enterUserName,
                  keyboardType: TextInputType.text,
                  action: TextInputAction.next,
                ),
                verticalSpace(20),
                Text(
                  AppStrings.email,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  controller: emailController,
                  validator: Validator.validateEmail,
                  hintText: AppStrings.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                verticalSpace(20),
                Text(
                  AppStrings.phoneNumber,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  controller: phoneNumberController,
                  validator: Validator.validatePhoneNumber,
                  hintText: AppStrings.enterPhoneNumber,
                  keyboardType: TextInputType.phone,
                  action: TextInputAction.next,
                ),
                verticalSpace(20),
                Text(
                  AppStrings.password,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  controller: passwordController,
                  validator: Validator.validatePassword,
                  hintText: AppStrings.enterPassword,
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                ),
                verticalSpace(20),
                Text(
                  AppStrings.confirmPassword,
                  style: AppTheme.lightTheme.textTheme.headlineMedium,
                ),
                verticalSpace(5),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  validator: (value) => Validator.validateConfirmPassword(
                    value,
                    passwordController.text,
                  ),
                  hintText: AppStrings.enterConfirmPassword,
                  isPassword: true,
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.done,
                ),
                verticalSpace(20),
                PrimaryBtn(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var request = RegisterEntity(
                        userName: userNameController.text,
                        email: emailController.text,
                        phoneNumber: phoneNumberController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                      context.read<RegisterCubit>().intent(
                        RegisterIntentImpl(request: request),
                      );
                    }
                  },
                  child: Text(
                    AppStrings.signUp,
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontSize: AppSpacing.x2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MediaQuery.of(context).viewInsets.bottom == 0
          ? SafeArea(
              child: SizedBox(
                height: 60,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAccount,
                      style: AppTheme.lightTheme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 14),
                      children: [
                        TextSpan(
                          text: AppStrings.login,
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
