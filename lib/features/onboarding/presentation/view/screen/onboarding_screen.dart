import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_theme.dart';
import 'package:shopping_app/features/onboarding/data/model/onboarding_data.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_state.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingCompleted) {
              Navigator.pushReplacementNamed(context, AppRoutes.helloRoute);
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpace(AppSpacing.x2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().intent(
                          IntentFinishOnboarding(),
                        );
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.helloRoute,
                        );
                      },
                      child: Text(
                        AppStrings.skip,
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ).fadeInRight(delay: const Duration(milliseconds: 100)),

                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) => context
                          .read<OnboardingCubit>()
                          .intent(IntentOnboardingPageChanged(value)),
                      controller: _pageController,
                      itemCount: onboardingList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.x3,
                            vertical: AppSpacing.x2,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLg,
                            ),
                            child: Image.asset(
                              onboardingList[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ).zoomIn(duration: const Duration(milliseconds: 700));
                      },
                    ),
                  ),

                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      final cubit = context.read<OnboardingCubit>();
                      final currentIndex = state is OnboardingPageChanged
                          ? state.index
                          : cubit.currentIndex;

                      return Column(
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: onboardingList.length,
                            effect: SwapEffect(
                              dotWidth: 10,
                              dotHeight: 10,
                              activeDotColor: AppColors.body,
                              dotColor: AppColors.dotColor,
                            ),
                          ).fadeIn(),
                          verticalSpace(AppSpacing.x3),

                          Text(
                            onboardingList[currentIndex].title,
                            style: AppTheme.lightTheme.textTheme.headlineLarge,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x2,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.x4,
                            ),
                            child: Text(
                              onboardingList[currentIndex].description,
                              style: AppTheme.lightTheme.textTheme.labelSmall,
                              textAlign: TextAlign.center,
                            ),
                          ).fadeInUp(delay: const Duration(milliseconds: 150)),

                          Padding(
                            padding: AppSpacing.allX3,
                            child: PrimaryBtn(
                              onPressed: () {
                                final isLastPage =
                                    currentIndex == onboardingList.length - 1;
                                final cubit = context.read<OnboardingCubit>();
                                if (isLastPage) {
                                  cubit.intent(IntentFinishOnboarding());
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.helloRoute,
                                  );
                                  return;
                                }

                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );

                                cubit.intent(
                                  IntentOnboardingPageChanged(currentIndex + 1),
                                );
                              },
                              child: Text(
                                currentIndex == onboardingList.length - 1
                                    ? AppStrings.getStarted
                                    : AppStrings.next,
                              ),
                            ),
                          ).bounceIn(delay: const Duration(milliseconds: 300)),
                        ],
                      );
                    },
                  ),
                  verticalSpace(AppSpacing.x5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
