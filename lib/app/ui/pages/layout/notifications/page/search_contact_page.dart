import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class SearchContactPage extends StatelessWidget {
  const SearchContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 42,
          // padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.silver800.withOpacity(0.15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Assets.svgs.iconSearch.svg(
                  height: 22,
                  width: 22,
                  // ignore: deprecated_member_use_from_same_package
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: CustomInput.searchInputDecoration(
                    context,
                    hint: "Search",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.5,
                  horizontal: 4,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Assets.svgs.closeCircle.svg(
                    // ignore: deprecated_member_use_from_same_package
                    color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 22,
              backgroundImage: Assets.images.onboarding2.provider(),
            ),
            title: Text(
              'Seguidor $index',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'user$index-ir',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            // trailing: Icon(Icons.camera_alt),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ChatPage(),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
