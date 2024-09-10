import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Collecciones"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.add_rounded),
                title: const Text("Nueva coleccion"),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
                onTap: () {},
                splashColor: AppColors.visVis500.withOpacity(0.2),
                hoverColor: AppColors.visVis500.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: StaggeredGrid.count(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    ...List.generate(
                      20,
                      (index) {
                        final collectionPrivate = [4, 5, 8, 2, 3];
                        final isPrivate = collectionPrivate
                            .any((element) => element == index);
                        return Card(
                          elevation: 4,
                          shadowColor:
                              Theme.of(context).shadowColor.withOpacity(0.5),
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                      stops: [0.55, 0.9],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: Assets.images.onboarding1.image(
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 10,
                                  left: 10,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Sweet heloo heloo helooe helo",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                height: 1,
                                              ),
                                        ),
                                      ),
                                      if (isPrivate)
                                        Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
