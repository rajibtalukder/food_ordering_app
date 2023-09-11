import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/view/global_widgets/texts.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/shared_preferences.dart';
import '../../../view_model/cart_controller.dart';

PaymentSheet(BuildContext context, String url) {
  late final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(url)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(url));
  var pro = Provider.of<CartController>(context, listen: false);
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.sp),
            topRight: Radius.circular(30.sp),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 5.w, 10.h),
              child: Row(
                children: [
                  titleText("Payment"),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      pro.localCartItems = [];
                      pro.cartItemList = null;
                      SharedPref().saveList('carts', []);
                      Navigator.of(context)
                          .pushReplacementNamed("CustomNavigation");
                    },
                    icon: Icon(
                      Icons.close_outlined,
                      size: 25.sp,
                    ),
                    splashRadius: 25,
                  )
                ],
              ),
            ),
            Expanded(
              child: WebViewWidget(controller: controller),
            ),
          ],
        ),
      );
    },
  );
}
