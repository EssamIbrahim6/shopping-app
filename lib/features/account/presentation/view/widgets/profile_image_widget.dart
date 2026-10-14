import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_style.dart';
import 'package:shopping_app/features/account/domain/entities/user_entity.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_intent.dart';

class ProfileImageWidget extends StatelessWidget {
  final AccountCubit cubit;
  final UserEntity? userEntity;

  const ProfileImageWidget({
    super.key,
    required this.cubit,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double imageSize = (screenWidth * 0.30).clamp(96.0, 132.0).toDouble();

    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => cubit.doIntent(PickImageIntent()),
        child: Stack(
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 4),
                boxShadow: [AppStyles.kBlackShadowSmall],
              ),
              child: ClipOval(
                child: cubit.selectedImagePath != null
                    ? (kIsWeb
                        ? Image.network(
                            cubit.selectedImagePath!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(cubit.selectedImagePath!),
                            fit: BoxFit.cover,
                          ))
                    : (userEntity?.image != null && userEntity!.image.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: userEntity!.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          size: imageSize * 0.48,
                          color: AppColors.bodyLight,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: imageSize * 0.48,
                        color: AppColors.bodyLight,
                      ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.x1 / 2,
              right: AppSpacing.x1 / 2,
              child: Container(
                padding: AppSpacing.allX1,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                  boxShadow: [AppStyles.primaryShadow],
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: AppColors.onPrimary,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
