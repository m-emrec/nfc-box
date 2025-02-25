import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_box/config/localization/lang/locale_keys.g.dart';

import '../../../config/routes/router.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_paddings.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/models/tag.dart';
import '../../../core/utils/widgets/buttons/buttons_import.dart';

part '_prepare_nfc_page_utils.dart';

class PrepareNfcPage extends StatelessWidget {
  final bool isWrite;
  final Tag? tag;
  const PrepareNfcPage({super.key, required this.isWrite, this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppPaddings.authHPadding +
            EdgeInsets.only(bottom: AppPaddings.sPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            /// Lottie animation
            FittedBox(
              child: Lottie.asset(
                AppAssets.howToReadNfcAni,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                height: context.screenSize.height * 0.4,
                width: context.screenSize.width,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _PrepareNfcPageUtils.howToUseNFCText,
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                Gap(AppPaddings.xxsPadding),
                Text(
                  _PrepareNfcPageUtils.explanationText,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            ResponsiveElevatedButton(
              onPressed: () async {
                _PrepareNfcPageUtils.onTapReady(
                  isWrite: isWrite,
                  tag: tag,
                  context: context,
                );
              },
              child: Text(_PrepareNfcPageUtils.ready),
            ),
          ],
        ),
      ),
    );
  }
}
