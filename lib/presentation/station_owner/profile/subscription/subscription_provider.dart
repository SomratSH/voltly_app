import 'package:flutter/foundation.dart';
import 'package:voltly_app/application/host/subscription/model/subscription_model.dart';
import 'package:voltly_app/application/host/subscription/repo/subscription_repo.dart';

class SubscriptionProvider extends ChangeNotifier {
  List<SubcriptionModel> subscriptionList = [];

  bool isLoading = false;
  Future<void> getSubscriptionData() async {
    isLoading = true;
    notifyListeners();
    final response = await SubscriptionRepo().getSubscriptionList();
    subscriptionList = response;
    isLoading = false;
    notifyListeners();
  }
}
