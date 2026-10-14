import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/common/widgets/app_btns.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/core/constants/app_strings.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_cubit.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_intent.dart';

class HelloBtnsSection extends StatelessWidget {
  const HelloBtnsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryBtn(
            onPressed: () {
              context.read<HelloCubit>().intent(MarkHelloAsVisited());
              context.read<HelloCubit>().intent(HasVisitedHello());
              Navigator.pushReplacementNamed(context, AppRoutes.registerRoute);
            },
            child: const Text(AppStrings.signUp),
          ),
          SizedBox(height: AppSpacing.x2),
          SecondaryBtn(
            onPressed: () {
              context.read<HelloCubit>().intent(MarkHelloAsVisited());
              context.read<HelloCubit>().intent(HasVisitedHello());

              Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
            },
            child: const Text(AppStrings.login),
          ),
        ],
      ),
    );
  }
}
