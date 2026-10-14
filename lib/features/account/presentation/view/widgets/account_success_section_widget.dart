import 'package:flutter/material.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view/widgets/profile_image_widget.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';

class AccountSuccessSection extends StatelessWidget {
  const AccountSuccessSection({
    super.key,
    required this.cubit,
    required this.data,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
  });

  final AccountCubit cubit;
  final UserEntity? data;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (data != null && nameController.text.isEmpty) {
      nameController.text = data!.name;
      emailController.text = data!.email;
      phoneController.text = data!.phone;
      addressController.text = data!.address;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 270,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 220,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        image: const DecorationImage(
                          image: AssetImage(AppAssets.appIcon),
                          fit: BoxFit.contain,
                          opacity: 0.6,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: AppSpacing.allX1 / 2,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [AppStyles.kBlackShadowSmall],
                      ),
                      child: ProfileImageWidget(cubit: cubit, userEntity: data),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(25),

            Padding(
              padding: AppSpacing.horizontalX3,
              child: Column(
                children: [
                  _buildField(
                    context,
                    label: AppStrings.accountName,
                    controller: nameController,
                  ),
                  _buildField(
                    context,
                    label: AppStrings.accountEmail,
                    controller: emailController,
                    readOnly: true,
                    isPass: false,
                  ),
                  _buildField(
                    context,
                    label: AppStrings.accountPhone,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildField(
                    context,
                    label: AppStrings.accountAddress,
                    controller: addressController,
                  ),
                  verticalSpace(AppSpacing.x1),
                  _buildListTile("Payment Details", () {}),
                  _buildListTile("Order history", () {}),
                  verticalSpace(AppSpacing.x3),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: PrimaryBtn(
                      onPressed: () => cubit.doIntent(
                        EditUserDataIntent(),
                        updatedData: {
                          'name': nameController.text.trim(),
                          'phone': phoneController.text.trim(),
                          'address': addressController.text.trim(),
                        },
                      ),
                      child: Text(
                        AppStrings.accountSubmit,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(AppSpacing.x2),
                ],
              ),
            ),
            verticalSpace(AppSpacing.x4),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    bool isPass = false,
  }) {
    return Padding(
      padding: AppSpacing.verticalX1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.heading, fontSize: 16),
          ),
          verticalSpace(AppSpacing.x1 / 2 + 1),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            obscureText: isPass,
            style: const TextStyle(
              color: AppColors.heading,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.x2,
                vertical: AppSpacing.x2,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.heading, fontSize: 15),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.heading,
      ),
      onTap: onTap,
    );
  }
}
