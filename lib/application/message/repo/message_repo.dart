import 'package:shared_preferences/shared_preferences.dart';
import 'package:voltly_app/api_service/api_service.dart';
import 'package:voltly_app/application/message/model/chat_history_model.dart';
import 'package:voltly_app/application/message/model/chat_host_model.dart';
import 'package:voltly_app/application/message/model/chat_list_model.dart';
import 'package:voltly_app/constant/app_urls.dart';

class MessageRepo {
  Future<ChatListModel> fetchChatsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.getChatList,
      authToken: preferences.getString("authToken"),
    );

    return ChatListModel.fromJson(response);
  }

  Future<HostChatModel> fetchHostChatsList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await ApiService().getData(
      AppUrls.getChatListHost,
      authToken: preferences.getString("authToken"),
    );

    return HostChatModel.fromJson(response);
  }

  Future<ChatHistoryModel> getChatHistory(int roomId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final reponse = await ApiService().getData(
      "${AppUrls.chatHistory}${roomId}/",
      authToken: preferences.getString("authToken"),
    );
    return ChatHistoryModel.fromJson(reponse);
  }
}
