
import 'package:hive/hive.dart';
part "data.g.dart";

@HiveType(typeId: 0)
class Contct_list extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String contact;
  @HiveField(2)
  String city;

  Contct_list(this.name, this.contact, this.city);

  @override
  String toString() {
    return 'Contct_list{name: $name, contact: $contact, city: $city}';
  }
}


