import 'package:app/utils/text_styles.dart';
import 'package:app/utils/theme_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CacheImage extends StatelessWidget {

  final String imageURL;
  final double height;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double width;
  final bool? setPlaceHolder;
  final String? placeholderImage;
  final BoxFit? contentMode;

  const CacheImage({Key? key, required this.imageURL, required this.height, required this.width, this.setPlaceHolder = true, this.placeholderImage, this.contentMode,this.bottomLeftRadius,this.bottomRightRadius,this.topLeftRadius,this.topRightRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageURL == "") ? NoImageAvailable(
      width: width,
      height: height,
      topLeftRadius: topLeftRadius,
      topRightRadius: topRightRadius,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
    ) : CachedNetworkImage(
      imageUrl: imageURL,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(topLeftRadius ?? 0.0),topRight:  Radius.circular(topRightRadius ?? 0.0),bottomRight:  Radius.circular(bottomRightRadius ?? 0.0),bottomLeft:  Radius.circular(bottomLeftRadius ?? 0.0)),
          image: DecorationImage(
            image: imageProvider,
            fit: contentMode ?? BoxFit.fill,
            // colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) {
        return NoImageAvailable(
          width: width,
          height: height,
          topLeftRadius: topLeftRadius,
          topRightRadius: topRightRadius,
          bottomLeftRadius: bottomLeftRadius,
          bottomRightRadius: bottomRightRadius,
        );
      },
      errorWidget: (context, url, error) {
        return NoImageAvailable(
          width: width,
          height: height,
          topLeftRadius: topLeftRadius,
          topRightRadius: topRightRadius,
          bottomLeftRadius: bottomLeftRadius,
          bottomRightRadius: bottomRightRadius,
        );
      },
    );
  }
}

class NoImageAvailable extends StatelessWidget {
  final double height;
  final double width;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  const NoImageAvailable({Key? key, required this.height, required this.width, this.bottomLeftRadius,this.bottomRightRadius,this.topLeftRadius,this.topRightRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: clrTextDark,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(topLeftRadius ?? 0.0),topRight:  Radius.circular(topRightRadius ?? 0.0),bottomRight:  Radius.circular(bottomRightRadius ?? 0.0),bottomLeft:  Radius.circular(bottomLeftRadius ?? 0.0)),
          ),
        ),
        Positioned(
          left: 20.w,
          top: 0.w,
          right: 20.w,
          bottom: 0.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wallpaper, size: (80.0).h,),
              SizedBox(height: 14.h,),
              Text(
                "No image available",
                style: TextStyles.txtRegular14,
              )
            ],
          ),
        )
      ],
    );
  }
}

