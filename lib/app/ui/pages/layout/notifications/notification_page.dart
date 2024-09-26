import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/others/user_notification.dart';
import 'package:recipe_food/app/presenter/services/notification/notification_service.dart';
import 'package:recipe_food/app/ui/pages/layout/notifications/widget/card_notification.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<UserNotification> notifications;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  Future<List<UserNotification>> futureNotification() async {
    notifications = await NotificationService().getRecipesWithLikes();
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.labelNotifications),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              FutureBuilder<List<UserNotification>>(
                future: futureNotification(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Mientras se carga, mostramos un shimmer loading
                    return ListView.builder(
                      itemCount: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 4,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.silver700.withOpacity(0.3),
                            highlightColor:
                                AppColors.silver400.withOpacity(0.4),
                            child: Container(
                              height: 90.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // Si hay un error, muestra un mensaje
                    return const Center(
                      child: Text(
                        "Ocurrió un error inesperado",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final List<UserNotification> data = snapshot.data;
                    if (data.isNotEmpty) {
                      // Si hay datos, devolvemos una lista de notificaciones
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return CardNotification(
                            title:
                                '${data[index].user?.name!} le ha gustado tu receta',
                            subtitle:
                                "${data[index].user?.name!} le ha dado like a tu receta ${data[index].recipe?.title!}",
                          );
                        },
                      );
                    } else {
                      // Si no hay datos, mostramos un mensaje indicando que no hay notificaciones
                      return const Center(
                        child: Text(
                          "No hay datos",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      );
                    }
                  } else {
                    // Caso por defecto: si no hay datos y tampoco hay error
                    return const Center(
                      child: Text(
                        "No hay datos",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
