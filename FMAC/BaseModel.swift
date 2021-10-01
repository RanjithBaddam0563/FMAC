//
//  BaseModel.swift
//  Alain
//
//  Created by MicroExcel on 7/9/20.
//  Copyright © 2020 Microexcel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct TrainingScheduleModel {
    var ID = Int()
    var ToTime : String = ""
    var FromTime : String = ""

    
    init() {
        
    }
    init(json : JSON){
        ID = json["ID"].intValue
        ToTime = json["ToTime"].stringValue
        FromTime = json["FromTime"].stringValue

    }
}
struct SportsTrainingScheduleModel {
    
    var SportName : String = ""
    var SportNameAr : String = ""

    init() {
        
    }
    init(json : JSON){
        SportName = json["SportName"].stringValue
        SportNameAr = json["SportNameAr"].stringValue

    }
}
struct CoachTrainingScheduleModel {
    
    var CoachName : String = ""
    var CoachNameAr : String = ""

    init() {
        
    }
    init(json : JSON){
        CoachName = json["CoachName"].stringValue
        CoachNameAr = json["CoachNameAr"].stringValue

    }
}
struct LeadershipModel {
    
    var Title : String = ""
    var TitleAr : String = ""
    var Description : String = ""
    var DescriptionAr : String = ""
    
    init() {
        
    }
    init(json : JSON){
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        Description = json["Description"].stringValue
        DescriptionAr = json["DescriptionAr"].stringValue
    }
}
struct ContactUsModel {
    
    var Value : String = ""
    var ID = Int()
    var Title : String = ""
    var TitleAr : String = ""
    var IconClass : String = ""
    

    
    init() {
        
    }
    init(json : JSON){
        Value = json["Value"].stringValue
        ID = json["ID"].intValue
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        IconClass = json["IconClass"].stringValue
    }
}
struct EventModel {
    
    var ID = Int()
    var Title : String = ""
    var TitleAr : String = ""
    var PublishDate : String = ""
    var EventType : String = ""
    var Year : String = ""
    

    
    init() {
        
    }
    init(json : JSON){
        ID = json["ID"].intValue
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        PublishDate = json["PublishDate"].stringValue
        EventType = json["EventType"].stringValue
        Year = json["Year"].stringValue

    }
}
    

struct NewsModel {
    
    var ID = Int()
    var Title : String = ""
    var TitleAr : String = ""
    var DescriptionAr : String = ""
    var Description : String = ""
    var PublishDate : String = ""
    var Photo : String = ""

    
    init() {
        
    }
    init(json : JSON){
        ID = json["ID"].intValue
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        PublishDate = json["PublishDate"].stringValue
        DescriptionAr = json["DescriptionAr"].stringValue
        Description = json["Description"].stringValue
        Photo = json["Photo"].stringValue

    }
}
struct NewsModelFile {
    var DecodedUrl : String = ""
    init() {
    }
    init(json : JSON){
        DecodedUrl = json["DecodedUrl"].stringValue
    }
}

struct OurTeamModel {
    
    var ID = Int()
    var Title : String = ""
    var TitleAr : String = ""
    var DescriptionAr : String = ""
    var Description : String = ""
    var Olympiad : String = ""
    var OlympiadAr : String = ""
    var GameInFMAC : String = ""
    var GameInFMACAr : String = ""
    var LocalAchievements : String = ""
    var LocalAchievementsAr : String = ""
    var InternationalAchievements : String = ""
    var InternationalAchievementsAr : String = ""
    var BackgroundColor : String = ""
    

    
    init() {
        
    }
    init(json : JSON){
        ID = json["ID"].intValue
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        Olympiad = json["Olympiad"].stringValue
        OlympiadAr = json["OlympiadAr"].stringValue
        DescriptionAr = json["DescriptionAr"].stringValue
        Description = json["Description"].stringValue
        GameInFMAC = json["GameInFMAC"].stringValue
        GameInFMACAr = json["GameInFMACAr"].stringValue
        LocalAchievements = json["LocalAchievements"].stringValue
        LocalAchievementsAr = json["LocalAchievementsAr"].stringValue
        InternationalAchievements = json["InternationalAchievements"].stringValue
        InternationalAchievementsAr = json["InternationalAchievementsAr"].stringValue
        BackgroundColor = json["BackgroundColor"].stringValue

    }
}
struct GalleryModel {
    var Title : String = ""
    var TitleAr : String = ""
    var PublishDate : String = ""
    var SportId = Int()
    var ID = Int()
    

    init() {
    }
    init(json : JSON){
        ID = json["ID"].intValue
        SportId = json["SportId"].intValue
        Title = json["Title"].stringValue
        TitleAr = json["TitleAr"].stringValue
        PublishDate = json["PublishDate"].stringValue

    }
}
struct GalleryModelFile {
    var DecodedUrl : String = ""
    init() {
    }
    init(json : JSON){
        DecodedUrl = json["DecodedUrl"].stringValue
    }
}
struct TrainingModelFiles {
    var ServerRelativeUrl : String = ""
    init() {
    }
    init(json : JSON){
        ServerRelativeUrl = json["ServerRelativeUrl"].stringValue
    }
}

struct BranchListModel {
    var BranchNameAr : String = ""
    var BranchName : String = ""
    var Id = Int()

    init() {
    }
    init(json : JSON){
        BranchNameAr = json["BranchNameAr"].stringValue
        BranchName = json["BranchName"].stringValue
        Id = json["Id"].intValue

    }
}
struct TypeOfGamesListModel {
    var SportNameArabic : String = ""
    var SportName : String = ""
    var ID = Int()

    init() {
    }
    init(json : JSON){
        SportNameArabic = json["SportNameArabic"].stringValue
        SportName = json["SportName"].stringValue
        ID = json["ID"].intValue

    }
}
struct AchievementsListModel {
    var TitleAr : String = ""
    var Title : String = ""
    var PublishDate : String = ""
    var DescriptionAr : String = ""
    var Description : String = ""
    
    
    var ID = Int()

    init() {
    }
    init(json : JSON){
        TitleAr = json["TitleAr"].stringValue
        Title = json["Title"].stringValue
        PublishDate = json["PublishDate"].stringValue
        DescriptionAr = json["DescriptionAr"].stringValue
        Description = json["Description"].stringValue
        ID = json["ID"].intValue

    }
}
struct AchievementsFileModel {
    var ServerRelativeUrl : String = ""

    init() {
    }
    init(json : JSON){
        ServerRelativeUrl = json["ServerRelativeUrl"].stringValue
    }
}
struct GroupsModel {
    var Title : String = ""

    init() {
    }
    init(json : JSON){
        Title = json["Title"].stringValue
    }
}

