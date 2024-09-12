import 'package:freezed_annotation/freezed_annotation.dart';

part 'received_notification.freezed.dart';
part 'received_notification.g.dart';

@freezed
abstract class ReceivedNotificationModel with _$ReceivedNotificationModel {
  factory ReceivedNotificationModel({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) = _RecivedNotificationModel;
  factory ReceivedNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivedNotificationModelFromJson(json);
}
