class InviteList {
  int status;
  String message;
  List<Data> data;

  InviteList({this.status, this.message, this.data});

  InviteList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String userId;
  String cityId;
  String chepterId;
  String email;
  String isActive;
  String isDelete;
  String createOn;
  String updateOn;
  String name;
  String cityName;
  String chepterName;

  Data(
      {this.id,
      this.userId,
      this.cityId,
      this.chepterId,
      this.email,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn,
      this.name,
      this.cityName,
      this.chepterName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    chepterId = json['chepter_id'];
    email = json['email'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
    name = json['name'];
    cityName = json['city_name'];
    chepterName = json['chepter_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['chepter_id'] = this.chepterId;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    data['name'] = this.name;
    data['city_name'] = this.cityName;
    data['chepter_name'] = this.chepterName;
    return data;
  }
}
