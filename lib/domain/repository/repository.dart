import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm/data/network/failure.dart';
import 'package:flutter_mvvm/data/request/request.dart';
import 'package:flutter_mvvm/data/responses/responses.dart';
import 'package:flutter_mvvm/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
