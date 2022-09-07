import 'package:dio/dio.dart';
import 'package:flutter_mvvm/data/network/failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}

class NetworkErrorHandler implements Exception {
  late Failure failure;

  NetworkErrorHandler.handle(dynamic error) {
    // dio error = error from response of the api
    if (error is DioError) {
      failure = _handleDioError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
      default:
        return DataSource.CONNECT_TIMEOUT.getFailure();
    }
  }
}

class ResponseCode {
  // api status code
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no content
  static const int BAD_REQUEST = 400; // failutre, api rejected the request
  static const int FORBIDDEN = 403; // failutre, api rejected the request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int NOT_FOUND =
      404; // faiutre, api url is not correct and not found
  static const int INTERNAL_SERVER_ERROR =
      500; // failure, crash happend in server side

  // local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  // api status code
  static const String SUCCESS = 'success'; // success with data
  static const String NO_CONTENT =
      'success with no content'; // success with no content
  static const String BAD_REQUEST =
      'Bad request, try again later'; // failutre, api rejected the request
  static const String FORBIDDEN =
      'Forbidden request, try again later'; // failutre, api rejected the request
  static const String UNAUTHORIZED =
      'User is not authorized'; // failure, user is not authorized
  static const String NOT_FOUND =
      'Url is not found'; // faiutre, api url is not correct and not found
  static const String INTERNAL_SERVER_ERROR =
      'Something went wrong'; // failure, crash happend in server side

  // local status code
  static const String UNKNOWN = 'Something went wrong';
  static const String CONNECT_TIMEOUT = 'Timeout error';
  static const String CANCEL = 'Request was cancelled';
  static const String RECEIVE_TIMEOUT = 'Timeout error';
  static const String SEND_TIMEOUT = 'Timeout error';
  static const String CACHE_ERROR = 'Cache error';
  static const String NO_INTERNET_CONNECTION =
      'Please check your internet connection';

  static const String DEFAULT = 'Something went wrong';
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
