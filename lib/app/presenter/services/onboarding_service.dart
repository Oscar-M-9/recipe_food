// import 'package:hive/hive.dart';

// class OnboardingService {
//   static const String boxName = 'setting';

//   Future<bool> hasSeenOnboarding() async {
//     final Box box = Hive.box(boxName);
//     return box.get('onboarding') ?? true;
//   }

//   Future<void> setOnboardingSeen(bool? isOnboarding) async {
//     var box = Hive.box(boxName);
//     box.put('onboarding', isOnboarding);
//   }
// }
