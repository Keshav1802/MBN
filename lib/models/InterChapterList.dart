class InterChapterList {
  int status;
  String message;
  List<InterChapterData> data;

  InterChapterList({this.status, this.message, this.data});

  InterChapterList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InterChapterData>[];
      json['data'].forEach((v) {
        data.add(new InterChapterData.fromJson(v));
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

class InterChapterData {
  String id;
  String userId;
  String addedDate;
  String createBy;
  String cityId;
  String chepterId;
  String location;
  String description;
  String photoProof;
  String isActive;
  String isDelete;
  String createOn;
  String updateOn;
  String name;
  String cityName;
  String chepterName;

  InterChapterData(
      {this.id,
      this.userId,
      this.addedDate,
      this.createBy,
      this.cityId,
      this.chepterId,
      this.location,
      this.description,
      this.photoProof,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn,
      this.name,
      this.cityName,
      this.chepterName});

  InterChapterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addedDate = json['added_date'];
    createBy = json['create_by'];
    cityId = json['city_id'];
    chepterId = json['chepter_id'];
    location = json['location'];
    description = json['description'];
    photoProof = json['photo_proof'];
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
    data['added_date'] = this.addedDate;
    data['create_by'] = this.createBy;
    data['city_id'] = this.cityId;
    data['chepter_id'] = this.chepterId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['photo_proof'] = this.photoProof;
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
