import 'package:flutter/cupertino.dart';
import '../utils/utils.dart';
import 'api_exception.dart';

class ErrorHandler {
  void handleApiError(error, BuildContext context) {
    switch (error) {
      case BadRequestException:
        Utils.hideLoading(context);
        Utils.showSnackBar("${error.errorName}: ${error.message}", context);
        break;
      case ApiNotRespondingException:
        Utils.hideLoading(context);
        Utils.showSnackBar("${error.errorName}: ${error.message}", context);
        break;

      case ProcessDataException:
        Utils.hideLoading(context);
        Utils.showSnackBar("${error.errorName}: ${error.message}", context);
        break;

      default:
        Utils.hideLoading(context);
        Utils.showSnackBar("${error.errorName}: ${error.message}", context);
        break;
      // show error dialog
    }
  }
}
