import 'package:faviorite_app/constants/color_constants.dart';
import 'package:faviorite_app/view/screens/free_tips_ativity_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/categories_cubit/category_cubit.dart';
import '../widgets/shimmer_loading.dart';

class FreeTipsPage extends StatefulWidget {
  const FreeTipsPage({super.key});

  @override
  State<FreeTipsPage> createState() => _FreeTipsPageState();
}

class _FreeTipsPageState extends State<FreeTipsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryCubit = context.read<CategoryCubit>();
      categoryCubit.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 20, right: 20.0, left: 20.0, bottom: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'free  '.toUpperCase(),
                      style: const TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    const Text(
                      "TIPS",
                      style: TextStyle(
                          fontFamily: "PilatExtended",
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/logoIcon.png",
                width: 65.0,
              ),
            ],
          ),
        ),
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
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
            } else if (state is CategoryLoaded) {
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
                              return FreeTipsAtivityPage();
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
            } else if (state is CategoryError) {
              return const Expanded(
                child: Center(
                  child: Text(
                    "Network Error! No data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
