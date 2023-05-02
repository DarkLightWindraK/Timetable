import Foundation
import PromiseKit

protocol TimeTablePresenter {
    var lessons: [Lesson] { get }
    
    func loadFirstState()
    func showNextDay()
    func showPreviousDay()
}

class TimeTablePresenterImpl: TimeTablePresenter {
    var lessons: [Lesson] = []
    var delegate: TimeTableCoordinator?
    weak var viewController: TimeTableView?
    
    private let timeTableService: TimeTableService
    private var displayedDate: Date = .now
    private let dateFormatter = DateFormatter()
    
    init(timeTableService: TimeTableService) {
        self.timeTableService = timeTableService
        
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE MMM d yyyy")
    }
    
    func getTimeTable() {
//        firstly {
//            timeTableService.getTimeTable(faculty: "35", course: 34, group: "243", subgroup: .first)
//        }.done { [weak self] response in
//            self?.lessons = LessonMapper.mapLessonModel(lessons: response.lessons)
//            self?.viewController?.showLessons()
//        }.catch { error in
//            print(error)
//        }
        lessons = TestData.makeLessons()
    }
    
    func showNextDay() {
        displayedDate.addTimeInterval(86400)
        viewController?.showNewDate(date: dateFormatter.string(from: displayedDate))
    }

    func showPreviousDay() {
        displayedDate.addTimeInterval(-86400)
        viewController?.showNewDate(date: dateFormatter.string(from: displayedDate))
    }
    
    func loadFirstState() {
        viewController?.showNewDate(date: dateFormatter.string(from: displayedDate))
        getTimeTable()
    }
}