import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/routing/app_routes.dart';
import 'package:shopping_app/features/auth/presentation/view_model/cubit/launcher/cubit/launcher_cubit.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_cubit.dart';
import 'package:shopping_app/features/hello/presentation/view_model/hello_intent.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_cubit.dart';
import 'package:shopping_app/features/onboarding/presentation/view_model/cubit/onboarding_state.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  double _rightPosition = -200;

  bool? _hasVisitedHello;
  bool? _isOnboardingSeen;
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
      _launch();
    });
  }

  void _startAnimation() {
    setState(() {
      _rightPosition = MediaQuery.of(context).size.width / 2 - 50;
    });
  }

  Future<void> _launch() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    context.read<OnboardingCubit>().intent(IntentIsOnboardingSeen());
    context.read<HelloCubit>().intent(HasVisitedHello());
    context.read<LauncherCubit>().intent(CheckAuthentication());
  }

  void _navigateIfReady() {
    if (_hasVisitedHello == null ||
        _isOnboardingSeen == null ||
        _isLoggedIn == null) {
      return;
    }

    if (!_isOnboardingSeen!) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingRoute);
    } else if (!_hasVisitedHello!) {
      Navigator.pushReplacementNamed(context, AppRoutes.helloRoute);
    } else if (!_isLoggedIn!) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.appSection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HelloCubit, HelloState>(
          listener: (context, state) {
            if (state is HelloVisited) {
              _hasVisitedHello = state.hasVisited;
              debugPrint("_hasVisitedHello: $_hasVisitedHello");
              _navigateIfReady();
            }
          },
        ),
        BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingSaving) {
              _isOnboardingSeen = state.hasVisited;
              debugPrint("_isOnboardingSeen: $_isOnboardingSeen");
              _navigateIfReady();
            }
          },
        ),
        BlocListener<LauncherCubit, LauncherState>(
          listener: (context, state) {
            if (state is LauncherAuthenticated) {
              _isLoggedIn = true;
              debugPrint("_isLoggedIn: $_isLoggedIn");
              _navigateIfReady();
            }

            if (state is LauncherUnauthenticated) {
              _isLoggedIn = false;
              debugPrint("_isLoggedIn: $_isLoggedIn");
              _navigateIfReady();
            }
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutBack,
              right: _rightPosition,
              top: MediaQuery.of(context).size.height * 0.4,
              child: SizedBox(
                width: 120,
                height: 120,
                child: Image.asset(AppAssets.appIcon, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
