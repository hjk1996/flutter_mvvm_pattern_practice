// to convert the response into a non-nullable
import 'package:flutter_mvvm/app/extensions.dart';
import 'package:flutter_mvvm/data/responses/responses.dart';
import 'package:flutter_mvvm/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

// data layer -> domain layer
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? EMPTY,
      this?.name?.orEmpty() ?? EMPTY,
      this?.numOfNotifications?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain() as Customer,
      this?.contacts?.toDomain() as Contacts,
    );
  }
}
