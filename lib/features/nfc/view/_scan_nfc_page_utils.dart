part of "scan_nfc_page.dart";

mixin _ScanNfcPageUtils on ConsumerState<ScanNfcPage> {
  final String statusText = tr(LocaleKeys.nfc_statusText);
  final String pleaseHoldYourPhoneNearTheNFCTagText =
      tr(LocaleKeys.nfc_pleaseHoldYourPhoneNearTheNFCTagText);
  final String cancelText = tr(LocaleKeys.nfc_cancelText);
  final String nfcReadSuccessfully = tr(LocaleKeys.nfc_nfcReadSuccessfully);

  /// This function listens the [nfcStateProvider]'s state changes
  void stateListener(BuildContext context) {
    return ref.listen(
        NfcProviders.nfcStateProvider({
          "isWrite": widget.isWrite,
          "tag": widget.tag,
        }), (prev, current) {
      if (current is DataSuccess) {
        _successCallback(context, current.data);
      } else if (current is DataFailed) {
        _failedCallback(context, current.exception);
      }
    });
  }

  void _successCallback(BuildContext context, Tag tag) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Toast.succToast(title: nfcReadSuccessfully);
    });

    /// Navigate to the tag detail page
    context.goNamed(
      Routes.tagLoading.name,
      extra: tag,
    );
  }

  void _failedCallback(BuildContext context, String? exception) {
    logger.e(exception);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Toast.errToast(title: exception);

      /// Navigate to the prepare NFC page again
      context.goNamed(
        Routes.prepareNfc.name,
        extra: {
          "isWrite": widget.isWrite,
          "tag": widget.tag,
        },
      );
    });
  }
}
