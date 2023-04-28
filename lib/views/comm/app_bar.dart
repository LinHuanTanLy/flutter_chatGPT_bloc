import 'package:flutter/material.dart';

///自定义appBar
class PageBar extends PreferredSize {
  //标题
  final String? title;
  final Widget? titleWidget;
  final BuildContext context;

  //右边widget
  final Widget? prefixBtn;

  //右边widget
  final Widget? suffixBtn;

  //是否隐藏左边返回键
  final bool? hiddenLeading;

  //背景颜色
  final Color backgroundColor;

  //标题颜色
  final Color titleColor;

  ///返回颜色
  final Color? backBtnColor;

  //返回键点击回调
  final VoidCallback? goBack;

  final Widget? rightWidget;

  PageBar(this.context,
      {Key? key,
      this.title,
      this.rightWidget,
      this.titleWidget,
      this.hiddenLeading,
      this.suffixBtn,
      this.prefixBtn,
      this.backBtnColor,
      this.backgroundColor = Colors.white,
      this.titleColor = Colors.black,
      this.goBack})
      : assert(title != null || titleWidget != null),
        super(
            key: key,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).padding.top + 8,
                  0,
                 5),
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (prefixBtn != null && hiddenLeading != true)
                          prefixBtn,
                        if (prefixBtn == null && hiddenLeading != true)
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(padding: const EdgeInsets.only(left: 12), child: Icon(Icons.arrow_back_ios,color: backBtnColor??Colors.black,)),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(right:12),
                          child: suffixBtn ?? const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: titleWidget ??
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(
                              left: 30, right: 30),
                          alignment: Alignment.center,
                          child: Text(
                            title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17,
                                color: titleColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                  ),
                  rightWidget != null
                      ? Positioned(right: 0,child: rightWidget,)
                      : const SizedBox.shrink()
                ],
              ),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width,
                44));
}
