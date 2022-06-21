import 'package:app/model/news_response_model.dart';
import 'package:app/utils/apis/api_end_points.dart';
import 'package:app/utils/apis/rest_client.dart';
import 'package:app/utils/theme_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NewsListProvider extends ChangeNotifier {

  bool isLoading = false;

  ///Clear Provider Data
  void clearProviderData() {
    isLoading = false;
    newsResponseModel = null;
  }

  ///Update Is Loading
  void updateIsLoading(bool value){
    isLoading = value;
    notifyListeners();
  }

  NewsResponseModel? newsResponseModel;

  ///Fill Local Data
  void fillResponseFromLocal(String responseData) {
    newsResponseModel = newsResponseModelFromJson(responseData);
    notifyListeners();
  }

  ///Get News List Api
  Future<void> getNewsListApi(BuildContext context, String search) async {
    updateIsLoading(true);

    String keyword = (search.isEmpty) ? "technology" : search;

    Response? response = await RestClient.getData(context, ApiEndPoints.newsList(keyword));

    if (response.statusCode == ApiEndPoints.apiStatus_200) {
      updateIsLoading(false);
      newsResponseModel = newsResponseModelFromJson(response.toString());
      if(getLocalNews() == null && ((newsResponseModel?.articles??[]).isNotEmpty)){
        saveLocalData(KEY_LOCAL_NEWS, response.toString());
      }
      notifyListeners();
    }
    else{
      updateIsLoading(false);
      showMessageDialog(context, response.statusMessage ?? "", () {
      });
    }
  }

}