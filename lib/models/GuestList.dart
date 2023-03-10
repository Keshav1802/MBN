class GuestList {
  int status;
  String message;
  List<Data> data;

  GuestList({this.status, this.message, this.data});

  GuestList.fromJson(Map<String, dynamic> json) {
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
  String category;
  String meetingDate;
  String categoryId;
  String isActive;
  String isDelete;
  String createOn;
  String updateOn;
  String categoryName;

  Data(
      {this.id,
      this.name,
      this.category,
      this.meetingDate,
      this.categoryId,
      this.isActive,
      this.isDelete,
      this.createOn,
      this.updateOn,
      this.categoryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    meetingDate = json['meeting_date'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createOn = json['create_on'];
    updateOn = json['update_on'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['meeting_date'] = this.meetingDate;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['create_on'] = this.createOn;
    data['update_on'] = this.updateOn;
    data['category_name'] = this.categoryName;
    return data;
  }
}
