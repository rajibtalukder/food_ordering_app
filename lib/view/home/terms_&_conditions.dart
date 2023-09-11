import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klio/constants/colors.dart';
import 'package:klio/constants/fonts_constants.dart';
import 'package:klio/view/global_widgets/custom_button.dart';
import 'package:klio/view/global_widgets/texts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText('Terms and Conditions', size: fontVeryBig),
                    const SizedBox(height: 5),
                    titleText('Last updated July 28, 2022',
                        size: fontMedium,
                        color: primaryColor.withOpacity(0.7)),
                    const SizedBox(height: 5),
                    Text(
                      'Please read these terms & conditions carefully before using out application.',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: fontVerySmall,
                      ),
                    ),
                    const SizedBox(height: 15),
                    titleText('Acknowledgement', size: fontMedium),
                    const SizedBox(height: 5),
                    Text(
                      'These terms and conditions outline the rules '
                      'and regulations for the use of Company Name\'s Website, located'
                      ' at Website.com.By accessing this website we assume you accept'
                      ' these terms and conditions. \n\nDo not continue to use Website Name '
                      'if you do not agree to take all of the terms and conditions stated'
                      ' on this page. \n\nParts of this website offer an opportunity for users to post '
                      'and exchange opinions and information in certain areas of the'
                      ' website. Company Name does not filter, edit, publish or '
                      'review Comments prior to their presence on the website. '
                      'Comments do not reflect the views and opinions of Company '
                      'Name,its agents and/or affiliates. Comments reflect the views'
                      ' and opinions of the person who post their views and opinions.'
                      ' \n\nTo the extent permitted by applicable laws, Company Name shall'
                      ' not be liable for the Comments or for any liability, damages'
                      ' or expenses caused and/or suffered as a result of any use of'
                      ' and/or posting of and/or appearance of the Comments on this website.'
                      '\n\nWe reserve the right to request that you remove all links or any '
                      'particular link to our Website. You approve to immediately remove '
                      'all links to our Website upon request. We also reserve the right to'
                      ' amen these terms and conditions and it\'s linking policy at any time. '
                      'By continuously linking to our Website, you agree to be bound to and '
                      'follow these linking terms and conditions.',
                      style: TextStyle(
                        color: secondaryTextColor,
                        fontSize: fontVerySmall,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: 25,
                      blurRadius: 25,
                      offset: const Offset(-5, -5), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customButton(
                        text: 'Decline',
                        width: 150.w,
                        color: secondaryTextColor),
                    customButton(text: 'Accept', width: 150.w,color: primaryColor.withOpacity(0.7)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
