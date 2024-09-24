import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/services/profile/profile_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  Future<void> loadUserData() async {
    if (state == null) {
      // Solo cargamos los datos si no se han cargado anteriormente
      final userData = await ProfileService().getUserData();
      state = userData;
    }
  }

  Future<void> logout() async {
    state = null;
    var box = await Hive.openBox('user');
    await box.delete('user');
  }
}
