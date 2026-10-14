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
import 'package:shopping_app/features/auth/presentation/view_model/cubit/login/login_cubit.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.login,
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginLoading) {
            AppDialogs.showLoadingDialog(context);
            return;
          }
          if (state is LoginSuccess) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, AppRoutes.appSection);
          }
          if (state is LoginError) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: AppStrings.errorTitle,
              description: state.errorMessage,
              type: ToastificationType.error,
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
                verticalSpace(30),
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
                verticalSpace(30),
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
                verticalSpace(30),
                PrimaryBtn(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    context.read<LoginCubit>().intent(
                      LoginIntentLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  child: Text(
                    AppStrings.login,
                    style: AppTheme.lightTheme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: AppStrings.dontHaveAccount,
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontSize: 14,
                  ),

                  children: [
                    TextSpan(
                      text: AppStrings.signUp,
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.registerRoute);
                        },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
