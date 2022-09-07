class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(
    this.title,
    this.subtitle,
    this.image,
  );
}

class Customer {
  String id;
  String name;
  int numOfNotification;

  Customer(
    this.id,
    this.name,
    this.numOfNotification,
  );
}

class Contacts {
  String email;
  String phone;

  Contacts(
    this.email,
    this.phone,
  );
}

class Authentication {
  Customer customer;
  Contacts contacts;

  Authentication(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}
