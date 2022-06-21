import 'package:app/model/news_response_model.dart';
import 'package:app/provider/news_list_provider.dart';
import 'package:app/ui/news_detail_screen.dart';
import 'package:app/utils/text_styles.dart';
import 'package:app/utils/theme_const.dart';
import 'package:app/utils/widget/cache_image.dart';
import 'package:app/utils/widget/custom_app_bar.dart';
import 'package:app/utils/widget/dialog_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {

  TextEditingController txtSearch = TextEditingController();

  NewsListProvider newsListRead = NewsListProvider();
  NewsListProvider newsListWatch = NewsListProvider();

  ///Init State
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      newsListRead = context.read<NewsListProvider>();

      _getNewsList();
    });
  }

  ///Dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    newsListWatch.clearProviderData();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    newsListWatch = context.watch<NewsListProvider>();
    
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            title: "News List",
            appBar: AppBar(),
            isLeading: false,
          ),
          body: _mainBody(),
        ),
        DialogProgressBar(isLoading: newsListWatch.isLoading)
      ],
    );
  }

  ///Main Body
  Widget _mainBody() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: clrWhite
          ),
          height: 48.h,
          child: InkWell(
            splashColor: clrTextGrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(7.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Center(
                child: TextFormField(
                  controller: txtSearch,
                  cursorColor: clrTheme,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyles.txtMedium14.copyWith(color: clrTheme),
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    _getNewsList(fromSearch: true);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    hintStyle: TextStyles.txtMedium14.copyWith(color: clrTextDarkGrey.withOpacity(0.6)),
                    prefixIcon: SizedBox(
                        width: 32.w,
                        child: Icon(Icons.search, size: 18.w,)
                    ),
                    prefixIconConstraints:
                    BoxConstraints(minHeight: 10.h, minWidth: 20.w),
                    hintText: "Search here...",
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: (newsListWatch.newsResponseModel == null) ? const Offstage()
              : ((newsListWatch.newsResponseModel?.articles??[]).isEmpty) ? Center(child: Text("No data found", style: TextStyles.txtMedium16.copyWith(color: clrTextDarkGrey),),)
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: newsListWatch.newsResponseModel?.articles?.length ?? 0,
            itemBuilder: (context, index) {
              Article? _dataObj = newsListWatch.newsResponseModel?.articles?[index];

              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(newsResponseModel: newsListWatch.newsResponseModel, newsIndex: index,)));
                },
                child: Card(
                  margin: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 16.h),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CacheImage(
                        imageURL: _dataObj?.urlToImage ?? "",
                        height: ((MediaQuery.of(context).size.width * 0.5) > 200) ? 200.h : (MediaQuery.of(context).size.width * 0.5).h,
                        // height: 200.h,
                        width: double.infinity,
                        topLeftRadius: 10.r,
                        topRightRadius: 10.r,
                        contentMode: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          _dataObj?.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.txtSemiBold18,
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          _dataObj?.description ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.txtRegular14.copyWith(color: clrTextDarkGrey),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  ///Get News List Api
  Future _getNewsList({bool fromSearch = false}) async {
    bool connectivity = await checkInternetConnectivity();
    if(connectivity){
      await newsListWatch.getNewsListApi(context, txtSearch.text);
    }
    else{
      if(getLocalNews() != null && (fromSearch == false)){
        newsListWatch.fillResponseFromLocal(getLocalNews() ?? "");
      }
      else{
        showMessageDialog(context, "No internet connection", () {});
      }
    }
  }
}
