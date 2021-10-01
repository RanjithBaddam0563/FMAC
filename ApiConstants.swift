//
//  ApiConstants.swift
//  Juvoxa
//
//  Created by sudhakar dalli on 28/01/19.
//  Copyright © 2019 Thukaram. All rights reserved.
//

import Foundation
//https://fmac.fujairah.ae/_api/web/lists/GetByTitle(%27Branches%27)/items
//https://microexcelae.sharepoint.com/sites/FMAC/_api/web/lists/

let BASEURL = "https://fmac.fujairah.ae/_api/web/lists/"
///https://fmac.fujairah.ae/Lists/News/Attachments/1/12.jpg
struct MyStrings {
    let BASEURL1 = "https://fmac.fujairah.ae/"
//    let BaseUrlGallery         =   BASEURL1 + "CampsGallery/"
//    let BaseUrlChampionships   =   BASEURL1 + "ChampionshipsGallery/"
//    let BaseUrlConferences     =   BASEURL1 + "ConferencesGallery/"
//    let BaseUrlTrainings       =   BASEURL1 + "TrainingsGallery/"
//https://fmac.fujairah.ae/en/pages/contact-us.aspx
    //https://fmac.fujairah.ae/ar/pages/contact-us.aspx
    
    
    
    let BranchesList_API                =   BASEURL +  "GetByTitle(%27Branches%27)/it"
    let TypeOfGame_API                =   BASEURL + "GetByTitle(%27Sports%27)/items"
    let socialCategory_API                =   BASEURL + "GetByTitle(%27SocialCategory%27)/items"
    let Nationality_API                =   BASEURL + "GetByTitle(%27Nationality%27)/items"

    let SelectYear_API                =   BASEURL + "GetByTitle(%27GalleryYears%27)/items"
    let GalleryGameTypesCham_API                =   BASEURL +  "GetByTitle(%27GalleryTypes%27)/items"
    let GalleryYears_API                =   BASEURL +  "GetByTitle(%27GalleryYears%27)/items"
    let GalleryGameTypesCamp_API                =   BASEURL +  "GetByTitle(%27CategoryTypes%27)/items"
    let Registrations_API                =   BASEURL +  "GetByTitle(%27CategoryTypes%27)/items"


    let TrainingScheduleList_API                =   BASEURL + "GetByTitle(%27trainingschedule%27)/items?$select=TrainingDays,ID,Title,Branch/BranchName,Branch/BranchNameAr,Coach/CoachName,Coach/CoachNameAr,Sport/SportName,Sport/SportNameAr,FromTime,ToTime&$expand=Coach,Sport,Branch&$filter=Branch/BranchName%20eq%20%27"
    
   //_api/web/lists/GetByTitle(%27trainingschedule%27)/items?$select=TrainingDays,ID,Title,Branch/BranchName,Branch/BranchNameAr,Coach/CoachName,Coach/CoachNameAr,Sport/SportName,Sport/SportNameAr,FromTime,ToTime&$expand=Coach,Sport,Branch&$filter=Branch/BranchName%20eq%20%27"+branchName+"%27%20and%20TrainingDays%20eq%20%27"+days+"%27
    
    //GetByTitle(%27TrainingSchedule%27)/items?$filter=Branch%20eq%20%27Dibba%20Branch
    let LeadershipMessage_API                =   BASEURL + "GetByTitle(%27LeadershipMessages%27)/items?$expand=AttachmentFiles"
    let ContactUs_API                =   BASEURL + "GetByTitle(%27ContactDetails%27)/items"
    


    let Event_API                =   BASEURL + "GetByTitle(%27Events%27)/items?$filter=EventType%20eq%20%27Local%27&$expand=AttachmentFiles"
    let International_Event_API                =   BASEURL + "GetByTitle(%27Events%27)/items?$filter=EventType%20eq%20%27International%27&$expand=AttachmentFiles"

    let News_API                =   BASEURL + "GetByTitle(%27News%27)/items?$filter=NewsType%20eq%20%27Local%27&$expand=AttachmentFiles"
    let Internation_News_API                =   BASEURL + "GetByTitle(%27News%27)/items?$filter=NewsType%20eq%20%27International%27&$expand=AttachmentFiles"
    let OurTeam_API                =   BASEURL + "GetByTitle(%27OurTeam%27)/items?$expand=AttachmentFiles"
    let Achivements_API                =   BASEURL + "GetByTitle(%27Achievements%27)/items?$expand=AttachmentFiles"

    
    let TrainingsGallery_API            =   BASEURL + "GetByTitle(%27TrainingGalleriesList%27)/items?$expand=AttachmentFiles"
    let TotalTrainingsGalleryImages_API            =   BASEURL + "GetByTitle(%27TrainingsGallery%27)/items?$filter=GalleryName/Title%20eq%20%27"
    
    let TrainingsGallerySelectGameAPI            =   BASEURL + "GetByTitle(%27TrainingGalleriesList%27)/items?$filter=Sport/Title%20eq%20%27"
    
    
    let ChampionshipsGallery_API        =   BASEURL + "GetByTitle(%27ChampionshipGalleriesList%27)/items?$expand=AttachmentFiles"

    let TotalChampionshipsGalleryImages_API            =   BASEURL + "GetByTitle(%27ChampionshipsGallery%27)/items?$filter=GalleryName/Title%20eq%20%27"
    let ChampionshipsGallerySelectGameAPI            =   BASEURL + "GetByTitle(%27ChampionshipGalleriesList%27)/items?$filter=Category/Title%20eq%20%27"
    let ChampionshipsGallerySelectGameByYearAPI            =   BASEURL + "GetByTitle(%27ChampionshipGalleriesList%27)/items?$filter=GalleryYear/Title%20eq%20%27"
    let ChampionshipsGallerySelectGameByCategoryAndYearAPI            =   BASEURL + "GetByTitle(%27ChampionshipGalleriesList%27)/items?$expand=AttachmentFiles&$expaned=Category/Title,GalleryYear/Title&$filter=Category/Title%20eq%20%27"
//_api/web/lists/getbytitle(%27"+galleryTypeList+"%27)/items?$expand=AttachmentFiles&$expaned=Category/Title,GalleryYear/Title&$filter=Category/Title%20eq%20%27"+selectedGalleryType+"%27%20and%20GalleryYear/Title%20eq%20%27"+galleryYear+"%27
    
    //https://fmac.fujairah.ae/_api/web/lists/GetByTitle(%27TrainingGalleriesList%27)/items?$filter=Sport/Title%20eq%20%27Boxing%27&filter=Sport/Title%20eq%20%27Boxing%27&$expand=AttachmentFiles

    let CampsGallery_API                =   BASEURL + "GetByTitle(%27CampsGalleriesList%27)/items?$expand=AttachmentFiles"
    let TotalCampsGalleryImages_API            =   BASEURL + "GetByTitle(%27CampsGallery%27)/items?$filter=GalleryName/Title%20eq%20%27"
    let CampsGallerySelectGameAPI            =   BASEURL + "GetByTitle(%27CampsGalleriesList%27)/items?$filter=GalleryYear/Title%20eq%20%27"

    let ConferencesGallery_API                =   BASEURL + "GetByTitle(%27ConferenceGalleriesList%27)/items?$expand=AttachmentFiles"
    let TotalConferencesGalleryImages_API            =   BASEURL + "GetByTitle(%27ConferencesGallery%27)/items?$filter=GalleryName/Title%20eq%20%27"

}

