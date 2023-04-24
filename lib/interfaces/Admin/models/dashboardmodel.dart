import 'package:json_annotation/json_annotation.dart';

part 'dashboardmodel.g.dart';

@JsonSerializable()
class DashboardModel {
  int? totalProduct;
  int ?totalSoldProduct;
  int? totalPendingProduct;
  int? totalApprovedProduct;
  int? totalInActiveProduct;
  int? totalDeletedProduct;
  String? totalProductAmount;
  String? totalSoldProductAmount;
  int? totalUser;
  int? totalMessage;

  DashboardModel(
      {this.totalProduct=20000,
      this.totalSoldProduct=15000,
      this.totalPendingProduct=150,
      this.totalApprovedProduct=300,
      this.totalInActiveProduct=150,
      this.totalDeletedProduct=20,
      this.totalProductAmount="1000000",
      this.totalSoldProductAmount="900000",
      this.totalUser=50000,
      this.totalMessage=1000});

   factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

}
