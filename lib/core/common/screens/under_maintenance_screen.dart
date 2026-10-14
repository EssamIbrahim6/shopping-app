import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopping_app/core/common/widgets/error_info.dart';
import 'package:shopping_app/core/constants/app_assets.dart';
import 'package:shopping_app/core/routing/app_routes.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({
    super.key,
    this.details,
    this.showRetryButton = true,
  });

  final FlutterErrorDetails? details;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SvgPicture.string(
                    AppAssets.underMaintenanceIllustration,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Under Maintenance!",
                description:
                    details?.exception.toString() ??
                    "We are currently performing scheduled maintenance. Please check back later. Thank you for your patience.",
                btnText: "Retry",
                press: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.appSection,
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
