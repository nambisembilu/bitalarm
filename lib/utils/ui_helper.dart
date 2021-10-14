import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class UiHelper {
  // LAYOUT
  static double baseWidth = 360;
  static double baseHeight = 600;
  final EdgeInsets marginList = EdgeInsets.only(
    top: 3,
    bottom: 3,
  );
  final EdgeInsets paddingList = EdgeInsets.only(
    top: 5,
    left: 15,
    right: 15,
  );
  final double radiusBorder = 8.0;
  final double radiusBorderRounded = 15;
  final double elevation = 1;

  // FONT
  final String fontFamilyStyled = 'Mont';
  final String fontFamilyNormal = 'SansPro';
  final String fontFamilyArial = 'Arial';
  static double baseFontSize = 12;
  final double fontSuperBig = baseFontSize + 12;
  final double fontVeryBig = baseFontSize + 8;
  final double fontBig = baseFontSize + 4;
  final double fontHeading = baseFontSize + 6;
  final double fontSubHeading = baseFontSize + 4;
  final double fontAppBar = baseFontSize + 8;
  final double fontSubAppBar = baseFontSize + 2;
  final double fontTitleContent = baseFontSize + 2;
  final double fontContent = baseFontSize;
  final double fontSmall = baseFontSize - 2;
  final double fontVerySmall = baseFontSize - 4;
  final double fontFormLabelField = baseFontSize + 2;
  final double fontFormField = baseFontSize + 1;

  // ICON
  static double baseIconSize = 18;
  final double iconVeryBig = baseIconSize + 8;
  final double iconBottomNav = baseIconSize + 2;
  final double iconBig = baseIconSize + 4;
  final double iconNormal = baseIconSize;
  final double iconSmall = baseIconSize - 4;
  final double iconVerySmall = baseIconSize - 8;
  final double iconSuperSmall = baseIconSize - 12;

  // TEXT
  final String currencySymbol = 'Rp. ';

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  // COLOR
  final bgLight = Colors.white;
  final bgColor = Colors.grey[200];
  final primaryColor = Color(0xff00bf71);
  final secondaryColor = Color(0xfff57c00);
  final confirmColor = Colors.green[800];
  final infoColor = Colors.lightBlue[800];
  final denyColor = Color(0xfff57c00);
  final warningColor = Colors.orange;
  final successColor = Colors.green;
  final dangerColor = Colors.red[700];
  final gradientColor = [Colors.blueAccent, Colors.lightBlue[300]];
  final gradientColorDarker = [Colors.blue[700], Colors.blue[700]];
  final gradientColorLightSame = [Colors.grey[100], Colors.grey[100]];
  final gradientColorLight = [Colors.grey[200], Colors.white];

  // GRADIENT
  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> leave = [Color(0xFF079444), Color(0xFF93edb9)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<List<Color>> gradientTemplate = [
    sky,
    sea,
    leave,
    mango,
    sunset,
    fire,
  ];

  // MEDIA QUERY
  Size screenDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  bool isKeyboardShow(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0 ? true : false;
  }

  bool isLongDevice(BuildContext context) {
    return MediaQuery.of(context).size.height > 650 ? true : false;
  }

  double screenAwareSize(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  double screenHeightPer(BuildContext context, double per) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double xHeight = baseHeight / per;
    double yHeight = deviceHeight - baseHeight;
    double widgetHeight = xHeight + (yHeight / 8.3);
    double returnHeight = widgetHeight >= deviceHeight ? widgetHeight - 30 : widgetHeight;
    // print("$returnHeight > $deviceHeight");
    return returnHeight;
  }

  double screenWidthtPer(BuildContext context, double per) {
    return (MediaQuery.of(context).size.width) / per;
  }

  // DECORATION

  ShapeBorder roundedShape({double radius = 10}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
  }

  BorderRadius roundedBorder() {
    return BorderRadius.circular(radiusBorder);
  }

  BoxDecoration roundBoxBorder({bgColor = Colors.white, isShadhow = false}) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radiusBorder),
      boxShadow: [
        isShadhow
            ? BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1, offset: Offset(1, 1))
            : BoxShadow(
                color: Colors.transparent,
              ),
      ],
    );
  }

  BoxDecoration roundedBoxBorder([bgColor = Colors.white, isShadhow = false]) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radiusBorder),
      boxShadow: [
        isShadhow
            ? BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 2),
              )
            : BoxShadow(
                color: Colors.transparent,
              ),
      ],
    );
  }

  BoxDecoration roundedBoxBorderGradient({List<Color> gradientColor}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: gradientColor,
      ),
      borderRadius: BorderRadius.circular(radiusBorder),
    );
  }

  BoxDecoration roundedBoxTopBottomBorder([bgColor = Colors.white]) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10), top: Radius.circular(10)),
    );
  }

  BoxDecoration roundedBoxTopBorder([bgColor = Colors.white]) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    );
  }

  BoxDecoration roundedBoxBottomBorder([bgColor = Colors.white]) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    );
  }

  // WIDGET

  Widget appBarLeadingIcon() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Image.asset('assets/icons/berbisnis-favicon.png'),
    );
  }

  Widget appBarTitleLogoText() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20),
      child: Image.asset(
        'assets/images/berbisnis-logo-horizontal-text.png',
        width: 135,
      ),
    );
  }

  Widget appBarLeadingBack(
    BuildContext context, [
    Color color = Colors.white,
    IconData icon = Icons.arrow_back,
  ]) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        icon,
        color: color,
        size: iconBig,
      ),
    );
  }

  Widget appBarHeading(text, {Color textColor = Colors.white, double textSize}) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(
            fontFamily: fontFamilyStyled,
            fontWeight: FontWeight.bold,
            fontSize: textSize != null ? textSize : fontAppBar,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget appBarHeadingWithIcon(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset('assets/icons/berbisnis-favicon.png'),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 0,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: fontFamilyStyled,
              fontWeight: FontWeight.bold,
              fontSize: fontAppBar,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // BACK SCOPE

  Widget willScopeScaffold({
    @required Widget child,
    Function onWillPop,
    bool forceExit = false,
  }) {
    if (forceExit) {
      return WillPopScope(
        onWillPop: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: child,
      );
    }
    return WillPopScope(
      onWillPop: onWillPop != null ? onWillPop : () async => false,
      child: child,
    );
  }

  // HEADER

  Widget gradientContentHeaderTitleOnly({
    @required String title,
    Widget childTitle,
    Widget leading,
    Widget action,
    double bottomMargin,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: bottomMargin != null ? bottomMargin : 10,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 150.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColor,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: leading != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        leading,
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  heading(title, 10, 0, Colors.white),
                                ],
                              ),
                            ),
                            action != null ? action : Container()
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              heading(title, 10, 0, Colors.white),
                            ],
                          ),
                        ),
                        action != null ? action : Container()
                      ],
                    ),
            ),
            childTitle != null ? childTitle : Container(),
            bottomMargin != null
                ? SizedBox(
                    height: 10.0,
                  )
                : SizedBox(
                    height: 20.0,
                  ),
          ],
        )
      ],
    );
  }

  Widget gradientContentHeaderTitleOnlyWhite({
    @required String title,
    Widget childTitle,
    Widget leading,
    Widget action,
    double bottomMargin,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: bottomMargin != null ? bottomMargin : 10,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 150.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColorLightSame,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: leading != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        leading,
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  heading(title, 10, 0, Colors.black),
                                ],
                              ),
                            ),
                            action != null ? action : Container()
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              heading(title, 10, 0, Colors.black),
                            ],
                          ),
                        ),
                        action != null ? action : Container()
                      ],
                    ),
            ),
            childTitle != null ? childTitle : Container(),
            bottomMargin != null
                ? SizedBox(
                    height: 10.0,
                  )
                : SizedBox(
                    height: 20.0,
                  ),
          ],
        )
      ],
    );
  }

  Widget gradientContentHeaderWhite({
    @required String title,
    @required String subtitle,
    Widget childTitle,
    Widget leading,
    Widget action,
    double bottomMargin,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: bottomMargin != null ? bottomMargin : 10,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 200.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColorLightSame,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: leading != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        leading,
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  heading(title, 10, 0, Colors.black),
                                  subHeading(subtitle, 3, 0, Colors.grey[600]),
                                ],
                              ),
                            ),
                            action != null ? action : Container()
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              heading(title, 10, 0, Colors.black),
                              subHeading(subtitle, 3, 0, Colors.grey[600]),
                            ],
                          ),
                        ),
                        action != null ? action : Container()
                      ],
                    ),
            ),
            childTitle != null ? childTitle : Container(),
            bottomMargin != null
                ? SizedBox(
                    height: 10.0,
                  )
                : SizedBox(
                    height: 20.0,
                  ),
          ],
        )
      ],
    );
  }

  Widget gradientContentHeader({
    @required String title,
    @required String subtitle,
    Widget childTitle,
    Widget leading,
    Widget action,
    double bottomMargin,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: bottomMargin != null ? bottomMargin : 10,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 200.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColorDarker,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: leading != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        leading,
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  heading(title, 10, 0, Colors.white),
                                  subHeading(subtitle, 3, 0, Colors.grey[300]),
                                ],
                              ),
                            ),
                            action != null ? action : Container()
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              heading(title, 10, 0, Colors.white),
                              subHeading(subtitle, 3, 0, Colors.grey[300]),
                            ],
                          ),
                        ),
                        action != null ? action : Container()
                      ],
                    ),
            ),
            childTitle != null ? childTitle : Container(),
            bottomMargin != null
                ? SizedBox(
                    height: 10.0,
                  )
                : SizedBox(
                    height: 20.0,
                  ),
          ],
        )
      ],
    );
  }

  Widget gradientContentHeaderWithChild({
    @required Widget content,
    double bottomMargin,
    double paddingHorizontal = 15,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: bottomMargin != null ? bottomMargin : 10,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 150.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColorDarker,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: paddingHorizontal,
              ),
              child: content,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        )
      ],
    );
  }

  Widget gradientContentHeaderBoxed({
    Widget content,
    Widget action,
    double paddingHorizontal = 15,
  }) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 10.0,
          left: 0,
          right: 0,
          child: Container(
            width: 400.0,
            height: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColorLight,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: paddingHorizontal,
              ),
              child: action != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[content, action],
                    )
                  : content,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        )
      ],
    );
  }

  Widget heading(String text, [double top = 30.0, double left = 20.0, textColor]) {
    return Container(
      padding: EdgeInsets.only(
        top: top,
        left: left,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamilyStyled,
          fontWeight: FontWeight.w600,
          fontSize: fontHeading,
          color: textColor != '' ? textColor : Colors.grey[800],
        ),
      ),
    );
  }

  Widget subHeading(
    String text, [
    double top,
    double left,
    textColor,
    double bottom = 10,
  ]) {
    top = top != null ? top : 5.0;
    left = left != null ? left : 20.0;
    return Container(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        bottom: bottom,
      ),
      child: Text(
        text,
        softWrap: true,
        style: TextStyle(
          fontFamily: fontFamilyNormal,
          fontSize: fontSubHeading,
          color: textColor != '' ? textColor : Colors.grey[600],
        ),
        maxLines: 1,
      ),
    );
  }

  Widget textSubHeading({
    String text,
    double padTop = 5.0,
    double padLeft = 20.0,
    double padBottom = 10,
    Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.only(top: padTop, left: padLeft, bottom: padBottom),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: fontFamilyStyled,
          fontSize: fontSubHeading,
          color: textColor != null ? textColor : Colors.grey[600],
        ),
        maxLines: 1,
      ),
    );
  }

  Widget headingContent({
    @required String text,
    double padTop = 5.0,
    double padBottom = 10,
    double padLeft = 10,
    double padRight = 10,
    @required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: padTop,
        bottom: padBottom,
        left: padLeft,
        right: padRight,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamilyStyled,
          color: textColor,
          fontSize: fontBig,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget subHeadingContent({
    @required String text,
    double padTop = 5.0,
    double padBottom = 10,
    double padLeft = 10,
    double padRight = 10,
    @required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: padTop,
        bottom: padBottom,
        left: padLeft,
        right: padRight,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: fontFamilyStyled,
          color: textColor,
          fontSize: fontTitleContent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // LIST AND GRID

  double itemGridHeight(BuildContext context) {
    return screenHeightPer(context, 3.2);
  }

  double itemGridHeightWithPrice(BuildContext context) {
    return screenHeightPer(context, 3.3);
  }

  Widget loadingItemGrid(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: roundedBoxBorder(Colors.white, true),
      child: Column(
        children: <Widget>[
          loadingButtonWithText(
            height: 0.6 *
                screenHeightPer(
                  context,
                  3.2,
                ),
          )
        ],
      ),
    );
  }

  Widget loadingImageItemGrid(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        color: Colors.grey,
        width: double.infinity,
        height: 0.6 * screenHeightPer(context, 3.3),
      ),
    );
  }

  // BOX AND BUTTON

  Widget colorBoxButtonIcon({
    BuildContext context,
    Color backgroundColor,
    IconData icon,
    double iconSize,
    String title,
    double titleSize,
    Color color,
    Widget page,
    Function tapFunc,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  }) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: tapFunc != null
              ? tapFunc
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
                },
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor != null ? backgroundColor : Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusBorder),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor != null ? backgroundColor.withOpacity(0.5) : Colors.grey[100].withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: iconSize != null ? iconSize : iconBig,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize != null ? titleSize : fontTitleContent,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontFamily: fontFamilyNormal,
          ),
        ),
      ],
    );
  }

  Widget colorBoxButtonIconImage({
    BuildContext context,
    Widget icon,
    String title,
    Color color,
    Widget page,
    Function tapFunc,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  }) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: tapFunc != null
              ? tapFunc
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
                },
          child: Container(
            padding: padding,
            child: icon,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontTitleContent,
            color: Colors.black38,
            fontWeight: FontWeight.w600,
            fontFamily: fontFamilyNormal,
          ),
        ),
      ],
    );
  }

  Widget roundedButtonLight({
    @required EdgeInsetsGeometry margin,
    @required IconData icon,
    @required Function tapFunc,
  }) {
    return GestureDetector(
      child: Container(
        margin: margin,
        padding: EdgeInsets.all(8),
        decoration: roundedBoxBorder(Colors.white),
        child: Icon(
          icon,
          color: Colors.blueGrey[300],
          size: iconSmall,
        ),
      ),
      onTap: tapFunc,
    );
  }

  Widget boxWithShadowColor({BuildContext context, String title, Color color, double paddingHorizontal}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radiusBorder),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.5), blurRadius: 15, spreadRadius: 1, offset: Offset(0, 5)),
          ],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontTitleContent,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  // ERROR

  Widget haveError(
    BuildContext context, {
    String title = "Error",
    String message = "Maaf, terjadi kesalahan",
    String description = "",
    bool withImage = false,
  }) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            withImage
                ? Image.asset(
                    'assets/images/error.png',
                    width: screenWidthtPer(context, 1.6),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black54, fontSize: fontTitleContent, fontWeight: FontWeight.bold, fontFamily: fontFamilyStyled),
            ),
            Text(
              message,
              style: TextStyle(color: Colors.red[300], fontSize: fontTitleContent, fontWeight: FontWeight.w400, fontFamily: fontFamilyStyled),
            ),
            Text(
              description,
              style: TextStyle(color: Colors.grey, fontSize: fontContent, fontWeight: FontWeight.w400, fontFamily: fontFamilyStyled),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemListEmpty(
    BuildContext context,
    double heightRatio, {
    String message = "No data available",
    String description = "",
    Widget childContent,
    bool withImage = false,
  }) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            withImage
                ? Image.asset(
                    'assets/images/no-data.png',
                    width: screenWidthtPer(
                      context,
                      heightRatio != null ? heightRatio : 1.5,
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontTitleContent,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontContent,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            childContent != null ? childContent : Container()
          ],
        ),
      ),
    );
  }

  Widget itemListEmptyImageModernOnly(
    BuildContext context,
    double heightRatio, {
    String message = "No data available",
    String description = "",
    Widget childContent,
  }) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/no-data.png',
              width: screenWidthtPer(context, heightRatio),
            ),
            SizedBox(
              height: 10,
            ),
            childContent != null ? childContent : Container()
          ],
        ),
      ),
    );
  }

  Widget itemListEmptyImageOnly(
    BuildContext context,
    double heightRatio, {
    String message = "No data available",
    String description = "",
    Widget childContent,
  }) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/no-data.png',
              width: screenWidthtPer(context, heightRatio),
            ),
            childContent != null ? childContent : Container()
          ],
        ),
      ),
    );
  }

  Widget itemListInfo(
    BuildContext context, {
    Color messageColor,
    String message = "Informasi tambahan",
    String description = "Deskripsi",
    Widget childContent,
    bool withImage = false,
  }) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            withImage
                ? Image.asset(
                    'assets/images/empty-result.png',
                    width: screenWidthtPer(context, 2),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              message,
              style: TextStyle(
                color: messageColor != null ? messageColor : Colors.blue[800],
                fontSize: fontTitleContent,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamilyStyled,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontContent,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamilyStyled,
              ),
            ),
            description != null && description != ''
                ? Padding(
                    padding: EdgeInsets.all(5),
                  )
                : Container(),
            childContent != null ? childContent : Container()
          ],
        ),
      ),
    );
  }

  Widget emptyWidgetInfo(
    BuildContext context, {
    Color messageColor,
    String message = "Informasi tambahan",
    String description = "Deskripsi",
    Widget childContent,
    bool withImage = false,
    String image = 'assets/images/empty-result.png',
  }) {
    return Container(
      child: Center(
        heightFactor: 1,
        widthFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            withImage
                ? Image.asset(
                    image,
                    width: screenWidthtPer(context, 2),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              message,
              style: TextStyle(
                color: messageColor != null ? messageColor : Colors.blue[800],
                fontSize: fontTitleContent,
                fontWeight: FontWeight.w600,
                fontFamily: fontFamilyStyled,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: fontContent,
                fontWeight: FontWeight.w400,
                fontFamily: fontFamilyStyled,
              ),
              textAlign: TextAlign.center,
            ),
            description != null && description != ''
                ? Padding(
                    padding: EdgeInsets.all(5),
                  )
                : Container(),
            childContent != null ? childContent : Container()
          ],
        ),
      ),
    );
  }

  Widget noInternet(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/no-internet.png',
              width: screenWidthtPer(context, 2),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Oops",
              style: TextStyle(color: Colors.red[700], fontSize: fontTitleContent, fontWeight: FontWeight.bold, fontFamily: fontFamilyStyled),
            ),
            Text(
              "Koneksi internet tidak ditemukan",
              style: TextStyle(color: Colors.red[300], fontSize: fontTitleContent, fontWeight: FontWeight.w400, fontFamily: fontFamilyStyled),
            ),
            // Text(
            //   "Klik tombol Sync, setelah internet hidup",
            //   style: TextStyle(
            //       color: Colors.grey,
            //       fontSize: fontContent,
            //       fontWeight: FontWeight.w400,
            //       fontFamily: fontFamilyStyled),
            // ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }

  // ALERT
  Widget alertSuccess({
    String text = "Ini adalah alert success",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(Colors.teal[700], true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertInfo({
    String text = "Ini adalah alert info",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(Colors.blue[600], true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertWarning({
    String text = "Ini adalah alert warning",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(Colors.orange[600], true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertError({
    String text = "Ini adalah alert error",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(Colors.red[700], true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertDefault({
    String text = "Ini adalah alert default",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(Colors.grey[700], true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget alertCustom({
    Color color,
    String text = "Ini adalah alert default",
    double paddingHorizontal = 10,
  }) {
    return Container(
      decoration: roundedBoxBorder(color, true),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.info_outline,
            color: Colors.white,
            size: iconNormal,
          ),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            child: Text(
              text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamilyStyled,
                fontWeight: FontWeight.w600,
                fontSize: fontContent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FORM

  get formTextStyle {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: fontFormField,
    );
  }

  get formTextStyleBigBold {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: fontBig,
    );
  }

  get formInputDecorationBoxed {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 12,
      ),
    );
  }

  InputDecoration formInputDecorationUnderline(
      {Widget prefix,
      Widget suffix,
      String hintText,
      EdgeInsets contentPad = const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      )}) {
    return InputDecoration(
      prefix: prefix != null ? prefix : null,
      suffix: suffix != null ? suffix : null,
      hintText: hintText != null ? hintText : null,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      isDense: true,
      contentPadding: contentPad,
    );
  }

  Widget formTitleText(String title, {double fontSize}) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: fontBig,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamilyStyled,
      ),
    );
  }

  Widget formLabel(String label, {double paddingTop = 8, bool isOptional = false, bool isReadOnly = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: paddingTop),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey,
              fontSize: fontFormLabelField,
            ),
          ),
        ),
        isOptional
            ? Padding(
                padding: EdgeInsets.only(left: 5.0, top: paddingTop),
                child: Text(
                  "Optional",
                  style: TextStyle(
                    fontSize: fontSmall,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    fontFamily: fontFamilyStyled,
                  ),
                ),
              )
            : Container(),
        isReadOnly
            ? Padding(
                padding: EdgeInsets.only(left: 5.0, top: paddingTop),
                child: Text(
                  "Readonly",
                  style: TextStyle(
                    fontSize: fontSmall,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                    fontFamily: fontFamilyStyled,
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget formFieldWrapperFullBorder({Widget childField, @required EdgeInsets margin}) {
    return Container(
      margin: margin,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[400],
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: childField,
    );
  }

  Widget formFieldWrapper({Widget childField}) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[400],
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: childField,
    );
  }

  Widget formFieldWrapperNoBorder({Widget childField}) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      alignment: Alignment.center,
      child: childField,
    );
  }

  Widget formTextHint(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamilyStyled,
        color: Colors.black45,
        fontSize: fontContent,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // DIVIDER

  Widget fullDividerLine({double height = 30, Color color = Colors.grey, double marginLeft = 15}) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Divider(
        height: height,
        color: color,
        thickness: 2,
      ),
    );
  }

  Widget subDividerLine(BuildContext context, {double height = 20, double marginLeft = 15}) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Divider(
        height: height,
        endIndent: screenWidthtPer(context, 4),
        color: Colors.grey,
        thickness: 0.7,
      ),
    );
  }

  // LOADING

  Widget loadingButton({double height: 20.0, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Container(
        height: height,
        width: width,
        decoration: roundedBoxBorder(Colors.grey[300]),
      ),
    );
  }

  Widget loadingButtonWithText({double height: 20.0, double width = double.infinity}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[100],
          child: Container(
            height: height,
            width: width,
            decoration: roundedBoxBorder(Colors.grey[300]),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Container(
              height: 10,
              width: width - 10,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget loadingMultipleLineText({
    @required int line,
    double height: 8.0,
    double width = double.infinity,
    double marginBetween = 5,
  }) {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < line; i++) {
      list.add(
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[300],
          child: Container(
            margin: EdgeInsets.only(
              bottom: marginBetween,
            ),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(radiusBorder),
            ),
          ),
        ),
      );
    }
    return Column(children: list);
  }

  Widget loadingText({double height: 8.0, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radiusBorder),
        ),
      ),
    );
  }

  Widget loadingAvatar({
    double width = 80,
    double height = 80,
    double radius = 30,
    @required EdgeInsetsGeometry margin,
  }) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
          width: 3.0,
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }

  void showCustomModalSheet({
    @required BuildContext context,
    @required double height,
    @required String title,
    @required Widget content,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return simpleBottomSheet(
          heightModal: height,
          context: context,
          textTitle: title,
          childContent: content,
        );
      },
    );
  }

  void showModalInfo(String title, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Icons.info_outline,
                  size: 20.0,
                  color: Colors.blue[800],
                ),
              ),
              Text(
                title,
                style: TextStyle(fontFamily: fontFamilyStyled, fontSize: fontSmall, color: Colors.blue[600], fontWeight: FontWeight.bold),
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
        );
      },
    );
  }

  void showModalError(String message, BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: alertError(text: message.length > 60 ? message.substring(0, 45) + '....' : message, paddingHorizontal: 10),
          padding: EdgeInsets.all(20),
        );
      },
    );
  }

  void showModalErrorWithChild({String message, BuildContext context, Widget child, double heightModal = 500}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: heightModal,
          width: MediaQuery.of(context).size.width * 0.9,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(
                      Icons.error,
                      size: 20.0,
                      color: Colors.redAccent,
                    ),
                  ),
                  Text(
                    message.length > 60 ? message.substring(0, 45) + '....' : message,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: fontFamilyStyled,
                      fontSize: fontContent,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Container(
                height: heightModal - 100,
                child: child,
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
        );
      },
    );
  }

  Widget styledBottomSheet({
    String textTitle,
    Widget childContent,
    List<Color> headerColor,
    Color boxShadow = Colors.grey,
    double heightModal = 600,
  }) {
    headerColor = headerColor != null ? headerColor : gradientColor;
    return Container(
      height: heightModal,
      color: Color(0xff737373).withOpacity(1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusBorder),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 5),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(radiusBorder),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: headerColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: boxShadow.withOpacity(0.6),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  textTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontBig,
                    fontWeight: FontWeight.w700,
                    fontFamily: fontFamilyStyled,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: childContent,
            ),
          ],
        ),
      ),
    );
  }

  Widget simpleBottomSheet({
    BuildContext context,
    String textTitle,
    Widget childContent,
    List<Color> headerColor,
    Color boxShadow = Colors.grey,
    double heightModal = 600,
  }) {
    headerColor = headerColor != null ? headerColor : gradientColor;
    return Container(
      height: heightModal,
      color: Color(0xff737373).withOpacity(1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Divider(
                color: Colors.grey,
                height: 5,
                thickness: 5,
                indent: screenWidthtPer(context, 2.2),
                endIndent: screenWidthtPer(context, 2.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontBig,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontFamilyStyled,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: childContent,
            ),
          ],
        ),
      ),
    );
  }

// FUNCTION

  void showAlertDialog({BuildContext context, String title, Widget child}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusBorder),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
          elevation: elevation,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontBig,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              child,
            ],
          ),
        );
      },
    );
  }

  void showAlertDialogThreeMenu({BuildContext context, String title, Widget child}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.all(5),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: fontFamilyStyled,
            ),
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: fontBig,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusBorder),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
          elevation: elevation,
          content: child,
        );
      },
    );
  }
}
