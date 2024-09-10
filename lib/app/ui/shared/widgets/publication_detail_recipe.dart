import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class PublicationDetailRecipe extends StatelessWidget {
  const PublicationDetailRecipe({
    super.key,
    required this.keyImageHero,
  });

  final String keyImageHero;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              // !! titulo
              Text(
                "How to make french toast ",
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15),
              // *!! imagen
              Hero(
                tag: keyImageHero,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 150),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Assets.images.onboarding1.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // !! Creador
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: Assets.images.onboarding3.provider(),
                  radius: 25,
                ),
                title: Text(
                  "Roberta Anny",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "120K followers",
                  style: textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(
                    "Follow",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // !! Dificultad de la receta
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dificutad",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Facil",
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.silver950.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Divider(
                  color: AppColors.silver950.withOpacity(0.2),
                ),
              ),
              // !! lista de los ingredientes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ingredientes",
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "5 items",
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.silver950.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // *lista de los ingredientes
              ...List.generate(
                5,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.silver900.withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Assets.svgs.ingredients.svg(
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Milk",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 60),
                            child: Text(
                              "200g",
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.silver950.withOpacity(0.5),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Divider(
                  color: AppColors.silver950.withOpacity(0.2),
                ),
              ),
              // !! Pasos de la receta
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pasos",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(
                5,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Lavar y secar las verduras. Pelar las zanahorias ligeramente si se desea con un pelaverduras. Desechar los extremos de ellas y del pimiento, y retirar los filamentos y semillas de este. Picar todo en trozos irregulares, no muy grandes, en un procesador de alimentos o picadora, o hacerlo a cuchillo.",
                      style: textTheme.bodyLarge,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
