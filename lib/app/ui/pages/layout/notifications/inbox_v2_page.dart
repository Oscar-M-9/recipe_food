import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/layout/notifications/page/chat_page.dart';
import 'package:recipe_food/app/ui/pages/layout/notifications/page/new_chat.dart';
import 'package:recipe_food/app/ui/pages/layout/notifications/page/search_contact_page.dart';
import 'package:recipe_food/app/ui/shared/widgets/story.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class InboxV2Page extends StatefulWidget {
  const InboxV2Page({super.key});

  @override
  State<InboxV2Page> createState() => _InboxV2PageState();
}

class _InboxV2PageState extends State<InboxV2Page> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const Color newMessageColor = AppColors.visVis400;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            // abre una vista igual a la de tiktok
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bandeja de entrada',
                style: theme.textTheme.titleMedium?.copyWith(
                  height: 1.0,
                ),
              ),
              // const SizedBox(width: 5),
              // Container(
              //   width: 12,
              //   height: 12,
              //   decoration: const BoxDecoration(
              //     color: AppColors.jade400,
              //     shape: BoxShape.circle,
              //   ),
              // ),
              // Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   tooltip: "Nuevo Chat",
        //   onPressed: () {
        //     // abre una vista igual a la de whatsapp
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const NewChat(),
        //       ),
        //     );
        //   },
        //   icon: Assets.svgs.messageAdd.svg(),
        // ),
        actions: [
          IconButton(
            tooltip: "Nuevo Chat",
            onPressed: () {
              // abre una vista igual a la de whatsapp
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewChat(),
                ),
              );
            },
            icon: Transform(
              transform: Matrix4.identity()
                ..scale(-1.0, 1.0, 1.0)
                ..translate(-24.5),
              child: Assets.svgs.messageAdd.svg(height: 24, width: 24),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    // user
                    StoryWidget(
                      imageUrl: Assets.images.onboarding1.path,
                      isNew: true,
                      isCreate: true,
                      addChild: Column(
                        children: [
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 75,
                            ),
                            child: Text(
                              "Crear",
                              style: theme.textTheme.labelSmall?.apply(
                                fontSizeFactor: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // seguidos
                    StoryWidget(
                      imageUrl: Assets.images.onboarding3.path,
                      isNew: true,
                      addChild: Column(
                        children: [
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 75,
                            ),
                            child: Text(
                              "Usuario 1",
                              style: theme.textTheme.labelSmall?.apply(
                                fontSizeFactor: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StoryWidget(
                      imageUrl: Assets.images.onboarding3.path,
                      isNew: true,
                      isOnline: true,
                      addChild: Column(
                        children: [
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 75,
                            ),
                            child: Text(
                              "Usuario 1.1",
                              style: theme.textTheme.labelSmall?.apply(
                                fontSizeFactor: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StoryWidget(
                      imageUrl: Assets.images.onboarding3.path,
                      isViewed: true,
                      addChild: Column(
                        children: [
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 75,
                            ),
                            child: Text(
                              "Usuario 2",
                              style: theme.textTheme.labelSmall?.apply(
                                fontSizeFactor: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StoryWidget(
                      imageUrl: Assets.images.onboarding3.path,
                      isLive: true,
                      isOnline: true,
                      addChild: Column(
                        children: [
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 75,
                            ),
                            child: Text(
                              "Usuario 3.3",
                              style: theme.textTheme.labelSmall?.apply(
                                fontSizeFactor: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Añade más historias aquí
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.visVis500,
                          AppColors.visVis300,
                          AppColors.jade300,
                          AppColors.jade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 2.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: Assets.images.onboarding2.provider(),
                      ),
                    ),
                  ),
                  // leading: CircleAvatar(
                  //   backgroundImage: Assets.images.onboarding3.provider(),
                  //   radius: 25,
                  // ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Nuevo seguidor ksjdnuifba fiweb ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.apply(
                            fontWeightDelta: 1,
                            fontSizeFactor: 1.12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '12/12/24',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: newMessageColor,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'user$index comenzó a seguirtejsdsdishdudfgiusgdfhiukasdifga',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: newMessageColor,
                        ),
                        child: Text(
                          "5",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.appBarTheme.backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  // trailing: Icon(Icons.camera_alt),
                  onTap: () {
                    print('Current path: ${context.router.current.path}');
                    print('Current path: ${context.router.root.currentPath}');
                    // context.router.root.push(ChatRoute());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(),
                      ),
                    );
                    // context.router.push(ChatRoute());
                    // context.tabsRouter.navigate(ChatRoute());
                    // context.router.root.pushNamed("/dahsboard/inbox/chat");
                  },
                );
              },
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       // height: 100,
      //       color: Colors.pink,
      //       child: ListView(
      //         scrollDirection: Axis.horizontal,
      //         children: [
      //           // user
      //           Padding(
      //             padding: const EdgeInsets.all(5.0),
      //             child: Column(
      //               children: [
      //                 Stack(
      //                   alignment: Alignment.center,
      //                   children: [
      //                     Container(
      //                       padding: const EdgeInsets.all(3),
      //                       decoration: const BoxDecoration(
      //                         shape: BoxShape.circle,
      //                         gradient: LinearGradient(
      //                           colors: [
      //                             AppColors.visVis500,
      //                             AppColors.visVis300,
      //                             AppColors.jade300,
      //                             AppColors.jade600,
      //                           ],
      //                           begin: Alignment.topLeft,
      //                           end: Alignment.bottomRight,
      //                         ),
      //                       ),
      //                       child: Container(
      //                         decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           border: Border.all(
      //                             color:
      //                                 Theme.of(context).scaffoldBackgroundColor,
      //                             width: 2.0,
      //                           ),
      //                         ),
      //                         child: CircleAvatar(
      //                           radius: 30,
      //                           backgroundImage:
      //                               Assets.images.onboarding1.provider(),
      //                         ),
      //                       ),
      //                     ),
      //                     Positioned(
      //                       bottom: 0,
      //                       right: 5,
      //                       child: Container(
      //                         decoration: BoxDecoration(
      //                           color: AppColors.jade500,
      //                           shape: BoxShape.circle,
      //                           border: Border.all(
      //                             color: theme.scaffoldBackgroundColor,
      //                             width: 2.5,
      //                           ),
      //                         ),
      //                         child: const Icon(
      //                           Icons.add_rounded,
      //                           color: Colors.white,
      //                           size: 15,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 5),
      //                 Text("crear", style: TextStyle(fontSize: 12)),
      //               ],
      //             ),
      //           ),
      //           // seguidos
      //           StoryWidget(
      //             username: 'Usuario 1',
      //             imageUrl: Assets.images.onboarding3.path,
      //             isNew: true,
      //           ),
      //           StoryWidget(
      //             username: 'Usuario 2',
      //             imageUrl: Assets.images.onboarding3.path,
      //             isViewed: true,
      //           ),
      //           StoryWidget(
      //             username: 'Usuario 3',
      //             imageUrl: Assets.images.onboarding3.path,
      //             isLive: true,
      //           ),
      //           // Añade más historias aquí
      //         ],
      //       ),
      //     ),
      //     // Expanded(
      //     //   child: ListView.builder(
      //     //     itemCount: 20,
      //     //     itemBuilder: (context, index) {
      //     //       return ListTile(
      //     //         leading: CircleAvatar(
      //     //           backgroundImage: Assets.images.onboarding3.provider(),
      //     //         ),
      //     //         title: Text('Nuevo seguidor'),
      //     //         subtitle: Text('user$index comenzó a seguirte'),
      //     //         trailing: Icon(Icons.camera_alt),
      //     //         onTap: () {
      //     //           Navigator.push(
      //     //             context,
      //     //             MaterialPageRoute(
      //     //               builder: (context) => ChatPage(),
      //     //             ),
      //     //           );
      //     //         },
      //     //       );
      //     //     },
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
