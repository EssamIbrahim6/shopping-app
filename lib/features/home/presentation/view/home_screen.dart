import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/constants/app_spacing.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/sections/categories_section.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/sections/header_section.dart';
import 'package:shopping_app/features/home/presentation/view/widgets/sections/products_section.dart';
import 'package:shopping_app/features/home/presentation/view_model/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ProductsCubit>().fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),

              CategoriesSection(),
              verticalSpace(AppSpacing.x3),
              ProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
