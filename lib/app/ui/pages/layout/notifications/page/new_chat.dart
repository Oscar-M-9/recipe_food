import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/layout/notifications/page/search_contact_page.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
    _animationController.forward();
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
    _animationController.reverse();
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Row(
              children: [
                if (!_isSearching) Text('Mensaje nuevo'),
                if (_isSearching)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.silver800.withOpacity(0.12),
                      ),
                      child: FadeTransition(
                        opacity: _widthAnimation,
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: CustomInput.searchInputDecoration(
                            context,
                            hint: AppLocalizations.of(context)!.labelSearch,
                          ),
                          style: theme.textTheme.bodyLarge,
                          onChanged: (query) {
                            // Lógica de búsqueda
                            print("Buscando: $query");
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            // icon: Icon(_isSearching ? Icons.close : Icons.search),
            icon: _isSearching
                ? Assets.svgs.closeCircle.svg()
                : Assets.svgs.iconSearch.svg(),
            onPressed: () {
              if (_isSearching) {
                _stopSearch();
              } else {
                _startSearch();
              }
            },
          ),
        ],
        // actions: [
        //   IconButton(
        //     tooltip: AppLocalizations.of(context)?.labelSearch,
        //     onPressed: () {
        //       // buscar los contactos
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const SearchContactPage(),
        //         ),
        //       );
        //     },
        //     icon: Assets.svgs.iconSearch.svg(),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 22,
                child: Assets.svgs.peopleCommunity.svg(),
              ),
              title: Text(
                'Chat en grupo',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
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
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 18,
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
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
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
          ],
        ),
      ),
    );
  }
}
