//
//  sideMenuAdminViewController.swift
//  FMAC
//
//  Created by MicroExcel on 6/5/21.
//  Copyright © 2021 Fujairah. All rights reserved.
//

import UIKit

class sideMenuAdminViewController: UIViewController {
    var lang_code : String = ""

    var Groups : String = ""
    var RegArray = [String]()
    var ChampionShipsArray = [String]()
    var CampsArray = [String]()
    var AchievementsArray = [String]()
    var Leave_RequestsArray = [String]()
    var Player_InjuryArray = [String]()
    var Player_TreatmentArray = [String]()
    var Player_SalaryArray = [String]()
    var Schedule_Of_Upcoming_ParticipationArray = [String]()
    var Open_FormsArray = [String]()
    var Student_SurveyArray = [String]()
    var Coach_Training_PlanArray = [String]()
    var Sport_ChangingArray = [String]()
    var Coach_AssesmentArray = [String]()
    var Student_AssesmentArray = [String]()
    
    var Equipment_FormArray = [String]()
    var Medical_Purchase_FormArray = [String]()
    

    @IBOutlet var tblView: UITableView!
    struct cellData {
        var Opened = Bool()
        var title = String()
        var sectionData = [String]()
        var Imgtitle = String()

    }
    var tableViewData = [cellData]()

    override func viewWillAppear(_ animated: Bool) {
        let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
        if lang_code == "ar" {
            self.langChange(strLan: "ar")
            self.tblView.register(UINib.init(nibName: "MenuArTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuArTableViewCell")
            tblView.dataSource = self
            tblView.delegate = self
            tblView.reloadData()

        }else{
            self.langChange(strLan: "en")
            self.tblView.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
            tblView.dataSource = self
            tblView.delegate = self
            tblView.reloadData()
        }
    }
    func langChange(strLan : String)
    {
        RegArray.removeAll()
        ChampionShipsArray.removeAll()
        CampsArray.removeAll()
        AchievementsArray.removeAll()
        Leave_RequestsArray.removeAll()
        Player_InjuryArray.removeAll()
        Player_TreatmentArray.removeAll()
        Player_SalaryArray.removeAll()
        Schedule_Of_Upcoming_ParticipationArray.removeAll()
        Open_FormsArray.removeAll()
        Student_SurveyArray.removeAll()
        Coach_Training_PlanArray.removeAll()
        Sport_ChangingArray.removeAll()
        Coach_AssesmentArray.removeAll()
        Student_AssesmentArray.removeAll()
        Equipment_FormArray.removeAll()
        Medical_Purchase_FormArray.removeAll()


        self.Groups =  UserDefaults.standard.string(forKey: "GroupName")!
        print("self.Groups :\(self.Groups)")

        if self.Groups == "FMACSuperAdmin"
        {
            RegArray.append("Registration_Approval".localizableString(loc: strLan))
            RegArray.append("Medical_Test".localizableString(loc: strLan))
            RegArray.append("Physical_Test".localizableString(loc: strLan))
            RegArray.append("Technical_Manager_Approval".localizableString(loc: strLan))
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            RegArray.append("Rejected_Players".localizableString(loc: strLan))
            RegArray.append("Pending_Players".localizableString(loc: strLan))

            ChampionShipsArray.append("ChampionShips_New".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_EventCoordinator".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_TechnicalManager".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_GeneralManager".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Rejected".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Pending".localizableString(loc: strLan))
            
            CampsArray.append("Camps_New".localizableString(loc: strLan))
            CampsArray.append("Camps_Event_Coordinator".localizableString(loc: strLan))
            CampsArray.append("Camps_Technical_Manager".localizableString(loc: strLan))
            CampsArray.append("Camps_General_Manager".localizableString(loc: strLan))
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            CampsArray.append("Camps_Rejected".localizableString(loc: strLan))
            CampsArray.append("Camps_Pending".localizableString(loc: strLan))

            AchievementsArray.append("Achievements_New".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Technical_Manager".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_General_Manager".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Rejected".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Pending".localizableString(loc: strLan))

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Coordinator".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Finance_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Operational_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Technical_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))
            Leave_RequestsArray.append("Upload_Employee_Attendence_Sheet".localizableString(loc: strLan))

            Player_InjuryArray.append("Player_Injuries_Doctor".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Technical_Manager".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Pending".localizableString(loc: strLan))

            Player_TreatmentArray.append("Player_Treatement_Coach".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Doctor".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Technical_Manager".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Rejected".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Pending".localizableString(loc: strLan))

            
            Player_SalaryArray.append("Player_Salary_New".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Technical_Manager".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_General_Manager".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Rejected".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Pending".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Attendence_Sheet_Upload".localizableString(loc: strLan))


            Schedule_Of_Upcoming_ParticipationArray.append("Participations_New_coach".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Technical_Manager".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Operational_Manager".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Rejected".localizableString(loc: strLan))

            Open_FormsArray.append("Department_Open_Forms_General_Manager".localizableString(loc: strLan))
            Open_FormsArray.append("Technical_Department_Open_Forms".localizableString(loc: strLan))
            Open_FormsArray.append("Operational_Department_Open_Forms".localizableString(loc: strLan))
            Open_FormsArray.append("HRFinance_Department_Open_Forms".localizableString(loc: strLan))

            Student_SurveyArray.append("Student_Survey_Student".localizableString(loc: strLan))
            Student_SurveyArray.append("Student_listDetails_TM".localizableString(loc: strLan))
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_New".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Technical_Manager".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Pending".localizableString(loc: strLan))

            Sport_ChangingArray.append("Sport_Changing_New".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Technical_Manager".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Rejected".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Pending".localizableString(loc: strLan))

            Coach_AssesmentArray.append("Coach_Assesment_New".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_GeneralManager".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Approved".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Rejected".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Pending".localizableString(loc: strLan))
            
            
            Student_AssesmentArray.append("Student_Assessment_New_Coach".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_TechnicalManager".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Approved".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Rejected".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Pending".localizableString(loc: strLan))
            
            Medical_Purchase_FormArray.append("Medical_Purchase_New_Doctor".localizableString(loc: strLan))
            Medical_Purchase_FormArray.append("Medical_Purchase_HR_And_Finance_Mgr".localizableString(loc: strLan))
            Medical_Purchase_FormArray.append("Medical_Purchase_Approved".localizableString(loc: strLan))
            Medical_Purchase_FormArray.append("Medical_Purchase_Rejected".localizableString(loc: strLan))
            Medical_Purchase_FormArray.append("Medical_Purchase_Pending".localizableString(loc: strLan))

            Equipment_FormArray.append("Equipment_New".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_TechnicalManager".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_WarehouseCororidnator".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_OperationalManager".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Rejected".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Pending".localizableString(loc: strLan))
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Open_Forms".localizableString(loc: strLan), sectionData: Open_FormsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Student_Survey".localizableString(loc: strLan), sectionData: Student_SurveyArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Assesment".localizableString(loc: strLan), sectionData: Coach_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Student_Assesment".localizableString(loc: strLan), sectionData: Student_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                           cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACPlayer"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            Student_SurveyArray.append("Student_Survey_Student".localizableString(loc: strLan))

            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                                                          
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                                             
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                                
                            cellData(Opened: false, title: "Student_Survey".localizableString(loc: strLan), sectionData: Student_SurveyArray,Imgtitle: "home"),
                            
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                    
            ]
        }else if self.Groups == "FMACRegAdmin"
        {
            RegArray.append("Registration_Approval".localizableString(loc: strLan))
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            RegArray.append("Rejected_Players".localizableString(loc: strLan))
            RegArray.append("Pending_Players".localizableString(loc: strLan))

            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

            Equipment_FormArray.append("Equipment_WarehouseCororidnator".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Rejected".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Pending".localizableString(loc: strLan))
            
            


            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                
            ]
        }else if self.Groups == "FMACCoach"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))
           

            ChampionShipsArray.append("ChampionShips_New".localizableString(loc: strLan))
            
            
            CampsArray.append("Camps_New".localizableString(loc: strLan))
           

          
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Rejected".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Pending".localizableString(loc: strLan))

            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
           

            
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Pending".localizableString(loc: strLan))

            Player_TreatmentArray.append("Player_Treatement_Coach".localizableString(loc: strLan))
            
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Rejected".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Pending".localizableString(loc: strLan))

            
            Player_SalaryArray.append("Player_Salary_New".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Technical_Manager".localizableString(loc: strLan))
            


            Schedule_Of_Upcoming_ParticipationArray.append("Participations_New_coach".localizableString(loc: strLan))
            
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_New".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))

            Sport_ChangingArray.append("Sport_Changing_New".localizableString(loc: strLan))
            
            Student_AssesmentArray.append("Student_Assessment_New_Coach".localizableString(loc: strLan))
            
            Equipment_FormArray.append("Equipment_New".localizableString(loc: strLan))
            
            
            


            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Student_Assesment".localizableString(loc: strLan), sectionData: Student_AssesmentArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACPhysicalTrainer"
        {
            RegArray.append("Physical_Test".localizableString(loc: strLan))
            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            
            Equipment_FormArray.append("Equipment_New".localizableString(loc: strLan))
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                            
            ]
        }else if self.Groups == "FMACDoctor"
        {
            RegArray.append("Medical_Test".localizableString(loc: strLan))
            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

            Player_InjuryArray.append("Player_Injuries_Doctor".localizableString(loc: strLan))
            

            Player_TreatmentArray.append("Player_Treatment_Doctor".localizableString(loc: strLan))
            
            
            Medical_Purchase_FormArray.append("Medical_Purchase_New_Doctor".localizableString(loc: strLan))
            
            Equipment_FormArray.append("Equipment_New".localizableString(loc: strLan))
            
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                            
            ]
        }else if self.Groups == "FMACTechnicalManager"
        {
           
            RegArray.append("Technical_Manager_Approval".localizableString(loc: strLan))
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            RegArray.append("Rejected_Players".localizableString(loc: strLan))
            RegArray.append("Pending_Players".localizableString(loc: strLan))

           
            ChampionShipsArray.append("ChampionShips_TechnicalManager".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Rejected".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Pending".localizableString(loc: strLan))
            
            CampsArray.append("Camps_Technical_Manager".localizableString(loc: strLan))
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            CampsArray.append("Camps_Rejected".localizableString(loc: strLan))
            CampsArray.append("Camps_Pending".localizableString(loc: strLan))

            AchievementsArray.append("Achievements_Technical_Manager".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Rejected".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Pending".localizableString(loc: strLan))

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Coordinator".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Finance_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))

            Player_InjuryArray.append("Player_Injuries_Technical_Manager".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))

            Player_TreatmentArray.append("Player_Treatment_Technical_Manager".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Rejected".localizableString(loc: strLan))

            
            Player_SalaryArray.append("Player_Salary_Technical_Manager".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Rejected".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Attendence_Sheet_Upload".localizableString(loc: strLan))


            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Technical_Manager".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Rejected".localizableString(loc: strLan))

            
            Open_FormsArray.append("Technical_Department_Open_Forms".localizableString(loc: strLan))
            

            Student_SurveyArray.append("Student_listDetails_TM".localizableString(loc: strLan))
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_Technical_Manager".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Pending".localizableString(loc: strLan))

            Sport_ChangingArray.append("Sport_Changing_Technical_Manager".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Rejected".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Pending".localizableString(loc: strLan))

            Coach_AssesmentArray.append("Coach_Assesment_New".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Approved".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Rejected".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Pending".localizableString(loc: strLan))
            
            
            Medical_Purchase_FormArray.append("Medical_Purchase_Approved".localizableString(loc: strLan))
            
            
            
            Student_AssesmentArray.append("Student_Assessment_TechnicalManager".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Approved".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Rejected".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Pending".localizableString(loc: strLan))


            Equipment_FormArray.append("Equipment_TechnicalManager".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Rejected".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Pending".localizableString(loc: strLan))
            
           


            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Open_Forms".localizableString(loc: strLan), sectionData: Open_FormsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Student_Survey".localizableString(loc: strLan), sectionData: Student_SurveyArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Assesment".localizableString(loc: strLan), sectionData: Coach_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Student_Assesment".localizableString(loc: strLan), sectionData: Student_AssesmentArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                  
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACGeneralManager"
        {
         
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            RegArray.append("Rejected_Players".localizableString(loc: strLan))
            RegArray.append("Pending_Players".localizableString(loc: strLan))

            
            ChampionShipsArray.append("ChampionShips_GeneralManager".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Rejected".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Pending".localizableString(loc: strLan))
            
            
            CampsArray.append("Camps_General_Manager".localizableString(loc: strLan))
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            CampsArray.append("Camps_Rejected".localizableString(loc: strLan))
            CampsArray.append("Camps_Pending".localizableString(loc: strLan))

            
            AchievementsArray.append("Achievements_General_Manager".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Rejected".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Pending".localizableString(loc: strLan))

          
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))
            

            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))
            

            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            Player_TreatmentArray.append("Player_Treatment_Rejected".localizableString(loc: strLan))
            
            
           
            Player_SalaryArray.append("Player_Salary_General_Manager".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Rejected".localizableString(loc: strLan))
           


            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Rejected".localizableString(loc: strLan))

            

            Student_SurveyArray.append("Student_Survey_Student".localizableString(loc: strLan))
            Student_SurveyArray.append("Student_listDetails_TM".localizableString(loc: strLan))
            
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Pending".localizableString(loc: strLan))

            
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Rejected".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Pending".localizableString(loc: strLan))

        
            Coach_AssesmentArray.append("Coach_Assesment_GeneralManager".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Approved".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Rejected".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Pending".localizableString(loc: strLan))
           
            
            Medical_Purchase_FormArray.append("Medical_Purchase_Approved".localizableString(loc: strLan))
            
            
            
            Student_AssesmentArray.append("Student_Assessment_Approved".localizableString(loc: strLan))
           


            
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            
            
           


            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Student_Survey".localizableString(loc: strLan), sectionData: Student_SurveyArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Assesment".localizableString(loc: strLan), sectionData: Coach_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Student_Assesment".localizableString(loc: strLan), sectionData: Student_AssesmentArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                        cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                            
            ]
        }else if self.Groups == "FMACHRFinanceManager"
        {
           
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            
           
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            

            
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
           

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))

        
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
          

            
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
           
            
           
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            


            
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            

           
            Open_FormsArray.append("HRFinance_Department_Open_Forms".localizableString(loc: strLan))
            
            Medical_Purchase_FormArray.append("Medical_Purchase_HR_And_Finance_Mgr".localizableString(loc: strLan))
            

            
            Equipment_FormArray.append("Equipment_OperationalManager".localizableString(loc: strLan))
            
            
            tableViewData = [
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Open_Forms".localizableString(loc: strLan), sectionData: Open_FormsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                            
            ]
        }else if self.Groups == "FMACHRCoordinator"
        {
            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Finance_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))
            Leave_RequestsArray.append("Upload_Employee_Attendence_Sheet".localizableString(loc: strLan))

           
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))
            
         
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Rejected".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Pending".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Attendence_Sheet_Upload".localizableString(loc: strLan))
            
            tableViewData = [
                            
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

                            
            ]
        }else if self.Groups == "FMACOperationalManager"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            RegArray.append("Rejected_Players".localizableString(loc: strLan))
            RegArray.append("Pending_Players".localizableString(loc: strLan))

            
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Rejected".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Pending".localizableString(loc: strLan))
            
            
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            CampsArray.append("Camps_Rejected".localizableString(loc: strLan))
            CampsArray.append("Camps_Pending".localizableString(loc: strLan))

            

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Coordinator".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_HR_Finance_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_General_Manager".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Approved".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Rejected".localizableString(loc: strLan))
            Leave_RequestsArray.append("Leaves_Pending".localizableString(loc: strLan))

            

            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Operational_Manager".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Rejected".localizableString(loc: strLan))

            
            Open_FormsArray.append("Operational_Department_Open_Forms".localizableString(loc: strLan))
            
            
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Pending".localizableString(loc: strLan))

            
            Equipment_FormArray.append("Equipment_OperationalManager".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Rejected".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Pending".localizableString(loc: strLan))
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Open_Forms".localizableString(loc: strLan), sectionData: Open_FormsArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACEventCoordinator"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))

            
            ChampionShipsArray.append("ChampionShips_EventCoordinator".localizableString(loc: strLan))
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Rejected".localizableString(loc: strLan))
            ChampionShipsArray.append("Championships_Pending".localizableString(loc: strLan))
            
            
            CampsArray.append("Camps_Event_Coordinator".localizableString(loc: strLan))
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            CampsArray.append("Camps_Rejected".localizableString(loc: strLan))
            CampsArray.append("Camps_Pending".localizableString(loc: strLan))

            
            AchievementsArray.append("Achievements_New".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Rejected".localizableString(loc: strLan))
            AchievementsArray.append("Achievements_Pending".localizableString(loc: strLan))

            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

           
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            Player_InjuryArray.append("Player_Injuries_Rejected".localizableString(loc: strLan))


            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Rejected".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Salary_Pending".localizableString(loc: strLan))
            Player_SalaryArray.append("Player_Attendence_Sheet_Upload".localizableString(loc: strLan))


            
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Operational_Manager".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Rejected".localizableString(loc: strLan))


            
         
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Rejected".localizableString(loc: strLan))
            Coach_Training_PlanArray.append("Coach_Training_Plan_Pending".localizableString(loc: strLan))

            
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Rejected".localizableString(loc: strLan))
            Sport_ChangingArray.append("Sport_Changing_Pending".localizableString(loc: strLan))

            
            Coach_AssesmentArray.append("Coach_Assesment_Approved".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Rejected".localizableString(loc: strLan))
            Coach_AssesmentArray.append("Coach_Assesment_Pending".localizableString(loc: strLan))
            
            
        
            Student_AssesmentArray.append("Student_Assessment_Approved".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Rejected".localizableString(loc: strLan))
            Student_AssesmentArray.append("Student_Assessment_Pending".localizableString(loc: strLan))
            
            

            
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Assesment".localizableString(loc: strLan), sectionData: Coach_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Student_Assesment".localizableString(loc: strLan), sectionData: Student_AssesmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACAccountant"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))

            
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            
           
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))

            
            
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
           

            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))

            
            
            
            Medical_Purchase_FormArray.append("Medical_Purchase_Approved".localizableString(loc: strLan))
           

            
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                            
                            cellData(Opened: false, title: "Medical_Purchase_Form".localizableString(loc: strLan), sectionData: Medical_Purchase_FormArray,Imgtitle: "home"),

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACOfficeAdmin"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))
            

            
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
            
            
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            

            
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            
            
            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

            
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            

            
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            

            
            
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            

            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            

            

            
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            

            
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            

            

            Equipment_FormArray.append("Equipment_New".localizableString(loc: strLan))
            
            Equipment_FormArray.append("Equipment_Approved".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Rejected".localizableString(loc: strLan))
            Equipment_FormArray.append("Equipment_Pending".localizableString(loc: strLan))
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            

                
                            cellData(Opened: false, title: "Equipment_Form".localizableString(loc: strLan), sectionData: Equipment_FormArray,Imgtitle: "home"),
                
                 
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }else if self.Groups == "FMACMediaCoordinator"
        {
            
            RegArray.append("Approved_Players".localizableString(loc: strLan))

            
            ChampionShipsArray.append("ChampionShips_Approved".localizableString(loc: strLan))
           
            
            
            CampsArray.append("Camps_Approved".localizableString(loc: strLan))
            

            
            AchievementsArray.append("Achievements_Approved".localizableString(loc: strLan))
            

            Leave_RequestsArray.append("Leaves_New".localizableString(loc: strLan))
            

            
            Player_InjuryArray.append("Player_Injuries_Approved".localizableString(loc: strLan))
            

            
            Player_TreatmentArray.append("Player_Treatment_Approved".localizableString(loc: strLan))
            

            
            
            Player_SalaryArray.append("Player_Salary_Approved".localizableString(loc: strLan))
            


            
            Schedule_Of_Upcoming_ParticipationArray.append("Participations_Approved".localizableString(loc: strLan))
            

            

            Student_SurveyArray.append("Student_Survey_Student".localizableString(loc: strLan))
            Student_SurveyArray.append("Student_listDetails_TM".localizableString(loc: strLan))
            
            
            Coach_Training_PlanArray.append("Coach_Training_Plan_Approved".localizableString(loc: strLan))
            

           
            Sport_ChangingArray.append("Sport_Changing_Approved".localizableString(loc: strLan))
            

            
            
            
            
            
            tableViewData = [
                            cellData(Opened: false, title: "Registrations".localizableString(loc: strLan), sectionData: RegArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "ChampionShips".localizableString(loc: strLan), sectionData: ChampionShipsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Camps".localizableString(loc: strLan), sectionData: CampsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Achievements".localizableString(loc: strLan), sectionData: AchievementsArray,Imgtitle: "home"),
                             
                             cellData(Opened: false, title: "Leave_Requests".localizableString(loc: strLan), sectionData: Leave_RequestsArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Injury".localizableString(loc: strLan), sectionData: Player_InjuryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Treatment".localizableString(loc: strLan), sectionData: Player_TreatmentArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Player_Salary".localizableString(loc: strLan), sectionData: Player_SalaryArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Schedule_Of_Upcoming_Participation".localizableString(loc: strLan), sectionData: Schedule_Of_Upcoming_ParticipationArray,Imgtitle: "home"),
                
                
                            cellData(Opened: false, title: "Student_Survey".localizableString(loc: strLan), sectionData: Student_SurveyArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Coach_Training_Plan".localizableString(loc: strLan), sectionData: Coach_Training_PlanArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Sport_Changing".localizableString(loc: strLan), sectionData: Sport_ChangingArray,Imgtitle: "home"),
                
                            cellData(Opened: false, title: "Arabic".localizableString(loc: strLan), sectionData: []),

            ]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
extension sideMenuAdminViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if tableViewData.count == 0
        {
            return 0
        }else{
           return tableViewData.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableViewData[section].Opened == true {
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
      
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 0
        }else{
            return 7
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.black
   
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 &&  tableViewData[indexPath.section].Opened == false{
            
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                
                    cell.menuArrowView.image = UIImage(named:"backArrow")
                    cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
                
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }else{
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell
                
                    cell.menuArrowView.image = UIImage(named:"rightArrow")
                    cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat.zero)
                
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }
            
        }else if indexPath.row == 0 &&  tableViewData[indexPath.section].Opened == true{
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                cell.menuArrowView.image = UIImage(named:"backArrow")
                cell.menuArrowView.contentMode = .scaleAspectFit
                cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }else{
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell
                cell.menuArrowView.image = UIImage(named:"rightArrow")
                cell.menuArrowView.contentMode = .scaleAspectFit
                cell.menuArrowView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont(name: "Oswald-Medium", size: 18)
                cell.menuTitleLbl.textColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].title
                
                return cell
            }
            
        }else{
                    
            
            let lang_code = UserDefaults.standard.value(forKey: "lang_code")as? String
            if lang_code == "ar" {
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuArTableViewCell", for: indexPath)as! MenuArTableViewCell
                cell.menuArrowView.image = UIImage(named:"black-box")
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont.systemFont(ofSize: 16.0)
                cell.menuTitleLbl.textColor = UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                return cell
            }else{
                let cell = self.tblView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)as! MenuTableViewCell

                cell.menuArrowView.image = UIImage(named:"black-box")
                cell.backgroundColor = UIColor.black
                cell.menuTitleLbl.font = UIFont.systemFont(ofSize: 16.0)
                cell.menuTitleLbl.textColor = UIColor.init(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
                cell.menuTitleLbl.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
                return cell
            }
            

                }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let tit = self.tableViewData[indexPath.section].title
            if tit == "Arabic".localizableString(loc: "en") || tit == "Arabic".localizableString(loc: "ar") {
                let lang_code1 = UserDefaults.standard.value(forKey: "lang_code")as? String
                if  lang_code1 == ""{
                    lang_code = "ar"
                    UserDefaults.standard.set(lang_code, forKey: "lang_code")
                    UserDefaults.standard.synchronize()
                }else if lang_code1 == "ar" {
                    lang_code = "en"
                    UserDefaults.standard.set(lang_code, forKey: "lang_code")
                    UserDefaults.standard.synchronize()
                }else{
                    lang_code = "ar"
                    UserDefaults.standard.set(lang_code, forKey: "lang_code")
                    UserDefaults.standard.synchronize()
                }
                
                    if #available(iOS 13.0, *) {
                        let vc = self.storyboard?.instantiateViewController(identifier: "NewAdminLoginViewController")as! NewAdminLoginViewController
                        self.navigationController?.pushViewController(vc, animated: false)

                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewAdminLoginViewController")as! NewAdminLoginViewController
                        self.navigationController?.pushViewController(vc, animated: false)
                        
                    }

                
                
            }else{
            if tableViewData[indexPath.section].Opened == true {
                tableViewData[indexPath.section].Opened = false
                let sections = IndexSet.init(integer: indexPath.section)
             tableView.reloadSections(sections, with: .none) // play Around with this
                
            }else{
             
                tableViewData[indexPath.section].Opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                print("Selectedsections:\(sections)")
                tableView.reloadSections(sections, with: .none)
                
            }
            }
            }else{
                let titArray = self.tableViewData[indexPath.section].sectionData
                print("titArray:\(titArray)")
                let titname = titArray[indexPath.row - 1]
                print("titname:\(titname)")
                
                if titname == "Registration_Approval".localizableString(loc: "ar") || titname == "Registration_Approval".localizableString(loc: "en") {
                    

                }else if titname == "Medical_Test".localizableString(loc: "ar") || titname == "Medical_Test".localizableString(loc: "en") {
                    
                    
                }else if titname == "Physical_Test".localizableString(loc: "ar") || titname == "Physical_Test".localizableString(loc: "en") {
                    
                    
                }else if titname == "Technical_Manager_Approval".localizableString(loc: "ar") || titname == "Technical_Manager_Approval".localizableString(loc: "en") {
                    
                    
                }else if titname == "Approved_Players".localizableString(loc: "ar") || titname == "Approved_Players".localizableString(loc: "en") {
                    
                    
                }else if titname == "Rejected_Players".localizableString(loc: "ar") || titname == "Rejected_Players".localizableString(loc: "en") {
                    
                    
                }else if titname == "Pending_Players".localizableString(loc: "ar") || titname == "Pending_Players".localizableString(loc: "en") {
                    
                    
                }//Reg
                
                
                else if titname == "Pending_Players".localizableString(loc: "ar") || titname == "Pending_Players".localizableString(loc: "en") {
                    
                    
                }
                
                
                
                
                else{
                    print("NotRegistration_Approval")
                }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
        
    }
    
    
}
