/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myDashboardNode = Dashboard.fromJson(map);
*/
class Announcement {
  String id;
  String name;
  String description;
  String createby;
  String addeddate;
  String isactive;
  String isdelete;
  String createon;
  String updateon;

  Announcement({this.id, this.name, this.description, this.createby, this.addeddate, this.isactive, this.isdelete, this.createon, this.updateon});

  Announcement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createby = json['create_by'];
    addeddate = json['added_date'];
    isactive = json['is_active'];
    isdelete = json['is_delete'];
    createon = json['create_on'];
    updateon = json['update_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['create_by'] = createby;
    data['added_date'] = addeddate;
    data['is_active'] = isactive;
    data['is_delete'] = isdelete;
    data['create_on'] = createon;
    data['update_on'] = updateon;
    return data;
  }
}

class Data {
  String totalGuestVisit;
  String totalUserCount;
  String totalRevenue;

  Data({this.totalGuestVisit, this.totalUserCount, this.totalRevenue});

  Data.fromJson(Map<String, dynamic> json) {
    totalGuestVisit = json['totalGuestVisit'];
    totalUserCount = json['totalUserCount'];
    totalRevenue = json['totalRevenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalGuestVisit'] = totalGuestVisit;
    data['totalUserCount'] = totalUserCount;
    data['totalRevenue'] = totalRevenue;
    return data;
  }
}

class Interchepter {
  String id;
  String userid;
  String addeddate;
  String createby;
  String cityid;
  String chepterid;
  String location;
  String description;
  String photoproof;
  String isactive;
  String isdelete;
  String createon;
  String updateon;
  String username;
  String createbyname;

  Interchepter({this.id, this.userid, this.addeddate, this.createby, this.cityid, this.chepterid, this.location, this.description, this.photoproof, this.isactive, this.isdelete, this.createon, this.updateon, this.username, this.createbyname});

  Interchepter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['user_id'];
    addeddate = json['added_date'];
    createby = json['create_by'];
    cityid = json['city_id'];
    chepterid = json['chepter_id'];
    location = json['location'];
    description = json['description'];
    photoproof = json['photo_proof'];
    isactive = json['is_active'];
    isdelete = json['is_delete'];
    createon = json['create_on'];
    updateon = json['update_on'];
    username = json['user_name'];
    createbyname = json['create_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userid;
    data['added_date'] = addeddate;
    data['create_by'] = createby;
    data['city_id'] = cityid;
    data['chepter_id'] = chepterid;
    data['location'] = location;
    data['description'] = description;
    data['photo_proof'] = photoproof;
    data['is_active'] = isactive;
    data['is_delete'] = isdelete;
    data['create_on'] = createon;
    data['update_on'] = updateon;
    data['user_name'] = username;
    data['create_by_name'] = createbyname;
    return data;
  }
}

class OneToOneMeeting {
  String id;
  String userid;
  String cityid;
  String chepterid;
  String location;
  String description;
  String photoproof;
  String createby;
  String isactive;
  String isdelete;
  String addeddate;
  String createon;
  String updateon;
  String username;
  String createbyname;

  OneToOneMeeting({this.id, this.userid, this.cityid, this.chepterid, this.location, this.description, this.photoproof, this.createby, this.isactive, this.isdelete, this.addeddate, this.createon, this.updateon, this.username, this.createbyname});

  OneToOneMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['user_id'];
    cityid = json['city_id'];
    chepterid = json['chepter_id'];
    location = json['location'];
    description = json['description'];
    photoproof = json['photo_proof'];
    createby = json['create_by'];
    isactive = json['is_active'];
    isdelete = json['is_delete'];
    addeddate = json['added_date'];
    createon = json['create_on'];
    updateon = json['update_on'];
    username = json['user_name'];
    createbyname = json['create_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userid;
    data['city_id'] = cityid;
    data['chepter_id'] = chepterid;
    data['location'] = location;
    data['description'] = description;
    data['photo_proof'] = photoproof;
    data['create_by'] = createby;
    data['is_active'] = isactive;
    data['is_delete'] = isdelete;
    data['added_date'] = addeddate;
    data['create_on'] = createon;
    data['update_on'] = updateon;
    data['user_name'] = username;
    data['create_by_name'] = createbyname;
    return data;
  }
}

class RecentUser {
  String id;
  String roleid;
  String designationid;
  String name;
  String cityid;
  String email;
  String mobilenumber;
  String profilepic;
  String password;
  String status;
  String instagram;
  String about;
  String isteam;
  String istop;
  String feature;
  String companyname;
  String gst;
  String businessinformation;
  String businesscategory;
  String businessclassification;
  String yearsestablishment;
  String businesspresence;
  String isdelete;
  String membersince;
  String createdon;
  String updatedon;
  String fcmtoken;
  String cityname;
  String designationname;
  String cheptername;
  String chepterid;
  String chepteruserid;

  RecentUser({this.id, this.roleid, this.designationid, this.name, this.cityid, this.email, this.mobilenumber, this.profilepic, this.password, this.status, this.instagram, this.about, this.isteam, this.istop, this.feature, this.companyname, this.gst, this.businessinformation, this.businesscategory, this.businessclassification, this.yearsestablishment, this.businesspresence, this.isdelete, this.membersince, this.createdon, this.updatedon, this.fcmtoken, this.cityname, this.designationname, this.cheptername, this.chepterid, this.chepteruserid});

  RecentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleid = json['role_id'];
    designationid = json['designation_id'];
    name = json['name'];
    cityid = json['city_id'];
    email = json['email'];
    mobilenumber = json['mobile_number'];
    profilepic = json['profile_pic'];
    password = json['password'];
    status = json['status'];
    instagram = json['instagram'];
    about = json['about'];
    isteam = json['is_team'];
    istop = json['is_top'];
    feature = json['feature'];
    companyname = json['company_name'];
    gst = json['gst'];
    businessinformation = json['business_information'];
    businesscategory = json['business_category'];
    businessclassification = json['business_classification'];
    yearsestablishment = json['years_establishment'];
    businesspresence = json['business_presence'];
    isdelete = json['is_delete'];
    membersince = json['member_since'];
    createdon = json['created_on'];
    updatedon = json['updated_on'];
    fcmtoken = json['fcm_token'];
    cityname = json['city_name'];
    designationname = json['designation_name'];
    cheptername = json['chepter_name'];
    chepterid = json['chepter_id'];
    chepteruserid = json['chepter_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role_id'] = roleid;
    data['designation_id'] = designationid;
    data['name'] = name;
    data['city_id'] = cityid;
    data['email'] = email;
    data['mobile_number'] = mobilenumber;
    data['profile_pic'] = profilepic;
    data['password'] = password;
    data['status'] = status;
    data['instagram'] = instagram;
    data['about'] = about;
    data['is_team'] = isteam;
    data['is_top'] = istop;
    data['feature'] = feature;
    data['company_name'] = companyname;
    data['gst'] = gst;
    data['business_information'] = businessinformation;
    data['business_category'] = businesscategory;
    data['business_classification'] = businessclassification;
    data['years_establishment'] = yearsestablishment;
    data['business_presence'] = businesspresence;
    data['is_delete'] = isdelete;
    data['member_since'] = membersince;
    data['created_on'] = createdon;
    data['updated_on'] = updatedon;
    data['fcm_token'] = fcmtoken;
    data['city_name'] = cityname;
    data['designation_name'] = designationname;
    data['chepter_name'] = cheptername;
    data['chepter_id'] = chepterid;
    data['chepter_user_id'] = chepteruserid;
    return data;
  }
}

class Dashboard {
  int status;
  String message;
  Data data;
  List<RecentUser> recentusers;
  List<Announcement> announcement;
  List<OneToOneMeeting> onetoonemeeting;
  List<Interchepter> interchepter;
  List<TopUser> topusers;

  Dashboard({this.status, this.message, this.data, this.recentusers, this.announcement, this.onetoonemeeting, this.interchepter, this.topusers});

  Dashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['recent_users'] != null) {
      recentusers = <RecentUser>[];
      json['recent_users'].forEach((v) {
        recentusers.add(RecentUser.fromJson(v));
      });
    }
    if (json['announcement'] != null) {
      announcement = <Announcement>[];
      json['announcement'].forEach((v) {
        announcement.add(Announcement.fromJson(v));
      });
    }
    if (json['one_to_one_meeting'] != null) {
      onetoonemeeting = <OneToOneMeeting>[];
      json['one_to_one_meeting'].forEach((v) {
        onetoonemeeting.add(OneToOneMeeting.fromJson(v));
      });
    }
    if (json['interchepter'] != null) {
      interchepter = <Interchepter>[];
      json['interchepter'].forEach((v) {
        interchepter.add(Interchepter.fromJson(v));
      });
    }
    // if (json['top_users'] != null) {
    //   topusers = <TopUser>[];
    //   json['top_users'].forEach((v) {
    //     topusers.add(TopUser.fromJson(v));
    //   });
    // }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['status'] = status;
  //   data['message'] = message;
  //   data['data'] = data!.toJson();
  //   data['recent_users'] =recent_users != null ? recentusers.map((v) => v.toJson()).toList() : null;
  //   data['announcement'] =announcement != null ? announcement.map((v) => v.toJson()).toList() : null;
  //   data['one_to_one_meeting'] =one_to_one_meeting != null ? onetoonemeeting.map((v) => v.toJson()).toList() : null;
  //   data['interchepter'] =interchepter != null ? interchepter.map((v) => v.toJson()).toList() : null;
  //   data['top_users'] =top_users != null ? topusers.map((v) => v.toJson()).toList() : null;
  //   return data;
  // }
}

class TopUser {
  String id;
  String roleid;
  String designationid;
  String name;
  String cityid;
  String email;
  String mobilenumber;
  String profilepic;
  String password;
  String status;
  String instagram;
  String about;
  String isteam;
  String istop;
  String feature;
  String companyname;
  String gst;
  String businessinformation;
  String businesscategory;
  String businessclassification;
  String yearsestablishment;
  String businesspresence;
  String isdelete;
  String membersince;
  String createdon;
  String updatedon;
  String fcmtoken;
  String cityname;
  String designationname;
  String cheptername;
  String chepterid;
  String chepteruserid;

  TopUser({this.id, this.roleid, this.designationid, this.name, this.cityid, this.email, this.mobilenumber, this.profilepic, this.password, this.status, this.instagram, this.about, this.isteam, this.istop, this.feature, this.companyname, this.gst, this.businessinformation, this.businesscategory, this.businessclassification, this.yearsestablishment, this.businesspresence, this.isdelete, this.membersince, this.createdon, this.updatedon, this.fcmtoken, this.cityname, this.designationname, this.cheptername, this.chepterid, this.chepteruserid});

  TopUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleid = json['role_id'];
    designationid = json['designation_id'];
    name = json['name'];
    cityid = json['city_id'];
    email = json['email'];
    mobilenumber = json['mobile_number'];
    profilepic = json['profile_pic'];
    password = json['password'];
    status = json['status'];
    instagram = json['instagram'];
    about = json['about'];
    isteam = json['is_team'];
    istop = json['is_top'];
    feature = json['feature'];
    companyname = json['company_name'];
    gst = json['gst'];
    businessinformation = json['business_information'];
    businesscategory = json['business_category'];
    businessclassification = json['business_classification'];
    yearsestablishment = json['years_establishment'];
    businesspresence = json['business_presence'];
    isdelete = json['is_delete'];
    membersince = json['member_since'];
    createdon = json['created_on'];
    updatedon = json['updated_on'];
    fcmtoken = json['fcm_token'];
    cityname = json['city_name'];
    designationname = json['designation_name'];
    cheptername = json['chepter_name'];
    chepterid = json['chepter_id'];
    chepteruserid = json['chepter_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role_id'] = roleid;
    data['designation_id'] = designationid;
    data['name'] = name;
    data['city_id'] = cityid;
    data['email'] = email;
    data['mobile_number'] = mobilenumber;
    data['profile_pic'] = profilepic;
    data['password'] = password;
    data['status'] = status;
    data['instagram'] = instagram;
    data['about'] = about;
    data['is_team'] = isteam;
    data['is_top'] = istop;
    data['feature'] = feature;
    data['company_name'] = companyname;
    data['gst'] = gst;
    data['business_information'] = businessinformation;
    data['business_category'] = businesscategory;
    data['business_classification'] = businessclassification;
    data['years_establishment'] = yearsestablishment;
    data['business_presence'] = businesspresence;
    data['is_delete'] = isdelete;
    data['member_since'] = membersince;
    data['created_on'] = createdon;
    data['updated_on'] = updatedon;
    data['fcm_token'] = fcmtoken;
    data['city_name'] = cityname;
    data['designation_name'] = designationname;
    data['chepter_name'] = cheptername;
    data['chepter_id'] = chepterid;
    data['chepter_user_id'] = chepteruserid;
    return data;
  }
}

