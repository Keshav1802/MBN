class UserList {
  int status;
  String message;
  List<Data> data;

  UserList({this.status, this.message, this.data});

  UserList.fromJson(Map<String, dynamic> json) {
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
  String roleId;
  String designationId;
  String name;
  String cityId;
  String email;
  String mobileNumber;
  String profilePic;
  String password;
  String status;
  String instagram;
  String about;
  String isTeam;
  String isTop;
  String feature;
  String companyName;
  String gst;
  String businessInformation;
  String businessCategory;
  String businessClassification;
  String yearsEstablishment;
  String businessPresence;
  String isDelete;
  String memberSince;
  String createdOn;
  String updatedOn;
  String fcmToken;
  String cityName;
  String designationName;
  String chepterName;
  String chepterId;
  String chepterUserId;

  Data(
      {this.id,
      this.roleId,
      this.designationId,
      this.name,
      this.cityId,
      this.email,
      this.mobileNumber,
      this.profilePic,
      this.password,
      this.status,
      this.instagram,
      this.about,
      this.isTeam,
      this.isTop,
      this.feature,
      this.companyName,
      this.gst,
      this.businessInformation,
      this.businessCategory,
      this.businessClassification,
      this.yearsEstablishment,
      this.businessPresence,
      this.isDelete,
      this.memberSince,
      this.createdOn,
      this.updatedOn,
      this.fcmToken,
      this.cityName,
      this.designationName,
      this.chepterName,
      this.chepterId,
      this.chepterUserId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    designationId = json['designation_id'];
    name = json['name'];
    cityId = json['city_id'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    profilePic = json['profile_pic'];
    password = json['password'];
    status = json['status'];
    instagram = json['instagram'];
    about = json['about'];
    isTeam = json['is_team'];
    isTop = json['is_top'];
    feature = json['feature'];
    companyName = json['company_name'];
    gst = json['gst'];
    businessInformation = json['business_information'];
    businessCategory = json['business_category'];
    businessClassification = json['business_classification'];
    yearsEstablishment = json['years_establishment'];
    businessPresence = json['business_presence'];
    isDelete = json['is_delete'];
    memberSince = json['member_since'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    fcmToken = json['fcm_token'];
    cityName = json['city_name'];
    designationName = json['designation_name'];
    chepterName = json['chepter_name'];
    chepterId = json['chepter_id'];
    chepterUserId = json['chepter_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['designation_id'] = this.designationId;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['profile_pic'] = this.profilePic;
    data['password'] = this.password;
    data['status'] = this.status;
    data['instagram'] = this.instagram;
    data['about'] = this.about;
    data['is_team'] = this.isTeam;
    data['is_top'] = this.isTop;
    data['feature'] = this.feature;
    data['company_name'] = this.companyName;
    data['gst'] = this.gst;
    data['business_information'] = this.businessInformation;
    data['business_category'] = this.businessCategory;
    data['business_classification'] = this.businessClassification;
    data['years_establishment'] = this.yearsEstablishment;
    data['business_presence'] = this.businessPresence;
    data['is_delete'] = this.isDelete;
    data['member_since'] = this.memberSince;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['fcm_token'] = this.fcmToken;
    data['city_name'] = this.cityName;
    data['designation_name'] = this.designationName;
    data['chepter_name'] = this.chepterName;
    data['chepter_id'] = this.chepterId;
    data['chepter_user_id'] = this.chepterUserId;
    return data;
  }
}
