//
//  calender.swift
//  FirebaseTemplate
//
//  Created by Retaj Al-Otaibi on 01/05/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//
//
//import SwiftUI
//import KVKCalendar
//
//
//struct CalendarContentView: View {
//    @State var events: [Event] = []
//
//    var body: some View {
//        calenderRepresentable()
//    }
//}
//
////class CalenderKIT: UIViewController {
////    override func viewDidLoad() {
////        super.viewDidLoad()
////    }
////}
//protocol DatePickerControllerDelegate: AnyObject {
//  func datePicker(controller: DatePickerController, didSelect date: Date?)
//}
//
//class DatePickerController: UIViewController {
//
//  weak var delegate: DatePickerControllerDelegate?
//
//  var date: Date {
//    get {
//      return datePicker.date
//    }
//    set(value) {
//      datePicker.setDate(value, animated: false)
//    }
//  }
//
//  lazy var datePicker: UIDatePicker = {
//    let v = UIDatePicker()
//    v.datePickerMode = .date
//    return v
//  }()
//
//  override func loadView() {
//    view = datePicker
//  }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .white
//    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
//                                                        target: self,
//                                                        action: #selector(DatePickerController.doneButtonDidTap))
//
//    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
//                                                       target: self,
//                                                       action: #selector(DatePickerController.cancelButtonDidTap))
//  }
//
//  @objc func doneButtonDidTap() {
//    delegate?.datePicker(controller: self, didSelect: date)
//  }
//
//  @objc func cancelButtonDidTap() {
//    delegate?.datePicker(controller: self, didSelect: nil)
//  }
//}
//
//
//
//struct calenderRepresentable : UIViewControllerRepresentable{
//    func makeUIViewController(context: UIViewControllerRepresentableContext<calenderRepresentable>) -> DatePickerController {
//        return DatePickerController()
//    }
//    func updateUIViewController(_ uiViewController: DatePickerController, context:     UIViewControllerRepresentableContext<calenderRepresentable>) {
//
//    }
//}
import SwiftUI
import ElegantCalendar

struct ExampleCalendarView: View {

    // Start & End date should be configured based on your needs.
    @State var days: [Date]
    
    var body: some View {
        VStack{
            MultiDatePicker(anyDays: $days)
            VStack {
                HStack{
                    Text("     ").background(Color(.blue)).clipShape(Capsule())
                    Text("start at 2021-05-3 to 2021-05-4").fontWeight(.bold)
                }.padding()
                HStack{
                    Text("     ").background(Color.red).clipShape(Capsule())
                    Text("start at 2021-05-6 to 2021-05-7").fontWeight(.bold)
                }.padding()
                HStack{
                    Text("     ").background(Color.purple).clipShape(Capsule())
                    Text("start at 2021-05-11 to 2021-05-12").fontWeight(.bold)
                }.padding()
            }.padding()
        }
    }

}
extension String {
    func getMyDate() -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        let date = dateFormatter.date(from: self)
        let dateComp = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date!)
        return dateComp
    }
}
