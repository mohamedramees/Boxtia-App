import 'package:hive/hive.dart';
part 'DB_Model.g.dart';




@HiveType(typeId: 1)
class userModel extends HiveObject {

  @HiveField(0)
  final String compName;
  @HiveField(1)
  final String mobNumber;
  @HiveField(2)
  String password;
  @HiveField(3)
  final String Cpassword;


  userModel({
   required this.compName,
   required this.mobNumber,
   required this.password,
   required this.Cpassword,
});
}
