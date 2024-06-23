import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/screens/free_tips_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/free_tips_categories_cubit/free_tips_category_cubit.dart';
import '../../cubits/tips_cubit/tips_cubit.dart';
import '../../icons/tips_activity_logo_icons.dart';
import '../../repositories/category_repository.dart';
import '../widgets/shimmer_loading.dart';

class FreeTipsScreen extends StatefulWidget {
  const FreeTipsScreen({super.key});

  @override
  State<FreeTipsScreen> createState() => _FreeTipsScreenState();
}

class _FreeTipsScreenState extends State<FreeTipsScreen> {
  late FreeTipsCategoryCubit categoryCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryCubit = context.read<FreeTipsCategoryCubit>();
      categoryCubit.fetchCategories();
    });
  }

  final categoryRepository = CategoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xff424242)
                          : const Color(0xffd3d3d3),
                      size: 28.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  const Expanded(
                    child: Text(
                      "Free Tips",
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    TipsActivityLogo.tipsactivitylogo,
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xff424242)
                        : const Color(0xffd3d3d3),
                    size: 30.0,
                  ),
                ],
              ),
            ),
            BlocBuilder<FreeTipsCategoryCubit, FreeTipsCategoryState>(
              builder: (context, state) {
                if (state is FreeTipsCategoryLoading) {
                  return Expanded(
                    child: ShimmerLoading(
                      child: GridView.count(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 20.0, // Space between columns
                        mainAxisSpacing: 20.0, // Space between rows
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20),
                        children: List.generate(10, (index) {
                          return AspectRatio(
                            aspectRatio: 144 / 127,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryColor,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/freeTipsButton.png"), // Replace with your image path
                                    fit: BoxFit
                                        .fitHeight, // Adjust how the image fits within the container
                                    alignment: Alignment.centerLeft),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                } else if (state is FreeTipsCategoryLoaded) {
                  final categories = state.categories.data;
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 20.0, // Space between columns
                      mainAxisSpacing: 20.0, // Space between rows
                      padding: const EdgeInsets.all(10.0),
                      children: List.generate(categories.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) =>
                                        TipsCubit(categoryRepository),
                                    child: FreeTipsActivityPage(
                                        categoryId: categories[index].id,
                                        categoryName: categories[index].name),
                                  );
                                },
                              ),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 144 / 127,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryColor,
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/freeTipsButton.png"), // Replace with your image path
                                    fit: BoxFit
                                        .fitHeight, // Adjust how the image fits within the container
                                    alignment: Alignment.centerLeft),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipOval(
                                      child: FadeInImage.assetNetwork(
                                        width: 60,
                                        placeholder: 'assets/subCatIcon.png',
                                        image:
                                            "https://totaltipsbet.com/uploads/${categories[index].image}",
                                        placeholderScale: 1,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            size: 40,
                                          );
                                        },
                                        fadeInDuration:
                                            const Duration(milliseconds: 300),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      categories[index].name,
                                      maxLines:
                                          2, // Set the maximum number of lines
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: "PilatExtended",
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );

                  // child: CollapsableWidget(
                  //   isActive: activeSubCat == index ? true : false,
                  //   title: categories[randomNumbers[index]].name,
                  //   iconUrl:
                  //   "https://totaltipsbet.com/uploads/${categories[randomNumbers[index]].image}",
                  // ),
                } else if (state is FreeTipsCategoryError) {
                  return Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          final categoryCubit =
                              context.read<FreeTipsCategoryCubit>();
                          categoryCubit.fetchCategories();
                        },
                        child: Text(
                          "Network Error! No data\n Tap to Retry!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
