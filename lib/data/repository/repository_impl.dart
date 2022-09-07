import 'package:flutter_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm/data/network/network_error_handler.dart';
import 'package:flutter_mvvm/data/network/network_info.dart';
import 'package:flutter_mvvm/domain/repository/repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm/data/network/failure.dart';
import 'package:flutter_mvvm/data/request/request.dart';
import 'package:flutter_mvvm/domain/model/model.dart';
import 'package:flutter_mvvm/data/mapper/mapper.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    // 네트워크 연결 확인
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);

        // response를 성공적으로 받았을 때
        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(
            response.status ?? ApiInternalStatus.FAILURE,
            response.message ?? ResponseMessage.DEFAULT,
          ));
        }
      } catch (error) {
        return Left(NetworkErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
