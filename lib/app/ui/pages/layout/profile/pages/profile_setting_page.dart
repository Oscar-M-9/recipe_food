import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuracion"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomListTile(
                  leading: Assets.svgs.language.svg(
                    height: 22,
                  ),
                  title: "Lenguaje",
                  onTap: () {},
                ),
                _CustomListTile(
                  leading: Assets.svgs.palette9.svg(
                    height: 22,
                  ),
                  title: "Apariencia",
                  onTap: () {},
                ),
                _CustomListTile(
                  leading: Assets.svgs.logout.svg(
                    height: 22,
                  ),
                  title: "Logout",
                  onTap: () {},
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    "OTROS",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.silver950.withOpacity(0.4),
                        ),
                  ),
                ),
                _CustomListTile(
                  leading: Assets.svgs.secureShieldPasswordProtectSafe.svg(
                    height: 22,
                  ),
                  title: "Politica de privacidad",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.title,
    this.leading,
    this.onTap,
  });

  final String title;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
    );
  }
}
