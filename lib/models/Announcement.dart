class Announcement {
  int status;
  String message;
  List<Data> data;

  Announcement({this.status, this.message, this.data});

  Announcement.fromJson(Map<String, dynamic> json) {
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
  String name;
  String description;
  String createBy;
  String addedDate;
  String isActive;
  String isDelete;
  String createOn;
  String updateOn;
  String createbyName;

  Data(
      {this.id,
        this.name,
        this.description,
        this.createBy,
        this.addedDate,
        this.isActive,
        this.isDelete,
        this.createOn,
        this.updateOn,
        this.createbyName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createBy = json['create_by'];
    addedDate = json['added_date'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
    createbyName = json['createby_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['create_by'] = this.createBy;
    data['added_date'] = this.addedDate;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    data['createby_name'] = this.createbyName;
    return data;
  }
}