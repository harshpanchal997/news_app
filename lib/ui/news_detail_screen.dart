import 'package:app/model/news_response_model.dart';
import 'package:app/provider/news_detail_provider.dart';
import 'package:app/utils/extensions/string_extension.dart';
import 'package:app/utils/text_styles.dart';
import 'package:app/utils/theme_const.dart';
import 'package:app/utils/time_ago.dart';
import 'package:app/utils/widget/cache_image.dart';
import 'package:app/utils/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsResponseModel? newsResponseModel;
  final int newsIndex;
  const NewsDetailScreen({Key? key, required this.newsResponseModel, required this.newsIndex}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  NewsDetailProvider newsDetailRead = NewsDetailProvider();
  NewsDetailProvider newsDetailWatch = NewsDetailProvider();

  ///Init State
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      newsDetailRead = context.read<NewsDetailProvider>();

      newsDetailRead.updateNewsIndex(widget.newsIndex);
    });
  }

  ///Dispose
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    newsDetailWatch.clearProviderData();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    newsDetailWatch = context.watch<NewsDetailProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "News Detail",
        appBar: AppBar(),
        action: [
          InkWell(
            onTap: () {
              Article? _dataObj = widget.newsResponseModel?.articles?[newsDetailWatch.newsIndex];

              Share.share("${_dataObj?.title ?? ""}\n\n${_dataObj?.url ?? ""}");
            },
            child: SizedBox(
              height: 34.h,
              width: 50.h,
              child: Icon(Icons.share, color: clrTheme, size: 20.h),
            ),
          )
        ],
      ),
      body: (widget.newsResponseModel == null) ? const Offstage() :_mainBody(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        color: clrTextGrey,
        height: 50.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if(newsDetailWatch.newsIndex > 0){
                  newsDetailWatch.updateNewsIndex(newsDetailWatch.newsIndex - 1);
                }
              },
              child: Container(
                height: 50.h,
                alignment: Alignment.center,
                child: Text(
                  "Prev",
                  style: TextStyles.txtRegular14.copyWith(color: (newsDetailWatch.newsIndex > 0) ? clrTheme : clrTextDarkGrey),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if(newsDetailWatch.newsIndex < ((widget.newsResponseModel?.articles?.length ?? 0) - 1)){
                  newsDetailWatch.updateNewsIndex(newsDetailWatch.newsIndex + 1);
                }
              },
              child: Container(
                height: 50.h,
                alignment: Alignment.center,
                child: Text(
                  "Next",
                  style: TextStyles.txtRegular14.copyWith(color: (newsDetailWatch.newsIndex < ((widget.newsResponseModel?.articles?.length ?? 0) - 1)) ? clrTheme : clrTextDarkGrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///Main Body
  Widget _mainBody() {
    Article? _dataObj = widget.newsResponseModel?.articles?[newsDetailWatch.newsIndex];

    return ListView(
      children: [
        CacheImage(
          imageURL: _dataObj?.urlToImage ?? "",
          // height: 200.h,
          height: (MediaQuery.of(context).size.width * 0.56),
          width: double.infinity,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Published before ${TimeAgo.timeAgoSinceDate((_dataObj?.publishedAt ?? "").getDateTimeObject(dateUTC))}",
                textAlign: TextAlign.right,
                style: TextStyles.txtMedium14,
              ),
              SizedBox(height: 10.h,),
              Text(
                _dataObj?.title ?? "",
                style: TextStyles.txtSemiBold18,
              ),
              SizedBox(height: 10.h,),
              Text(
                _dataObj?.description ?? "",
                style: TextStyles.txtRegular14.copyWith(color: clrTextDarkGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
