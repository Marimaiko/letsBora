//
//  CalendarView.swift
//  LetsBora
//
//  Created by Davi Paiva on 04/06/25.
//
import UIKit
protocol CalendarViewDelegate: AnyObject {
    func calendarViewDidConfirmDateTime(date: Date, time: Date)
}

class CalendarView: UIView {
    // MARK: - Variables
    private weak var delegate: CalendarViewDelegate?
    
    func delegateTo(_ delegate: CalendarViewDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - UI Properties
    struct layout {
        static let marginX: CGFloat = 8
        static let marginY: CGFloat = 8
    }
    // MARK: - UI Elements
    lazy var calendarContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    lazy var calendar: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.minimumDate = Date()
        return picker
    }()
    
    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    

    // MARK: - Functions/ Computed var
    
    var combinedDateAndTime: Date? {
        self.endEditing(true) // why use this ???
        let calendatDate = calendar.date
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: timePicker.date)
        guard let hour = timeComponents.hour,
              let minute = timeComponents.minute else { return nil }
        return Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: calendatDate)
    }
   
    // MARK: - LifeCyles
    init(with DateAndTime: Date? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = .systemGray6
        if let dateAndTime = DateAndTime {
            calendar.date = dateAndTime
            timePicker.date = dateAndTime
        }
        
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    func setupView(){
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy(){
        addSubview(calendar)
        addSubview(timePicker)
    }
    func setConstraints(){
        calendar
            .top(anchor: safeAreaLayoutGuide.topAnchor)
            .centerX(safeAreaLayoutGuide.centerXAnchor)
        timePicker
            .top(anchor: calendar.bottomAnchor, constant: layout.marginY)
            .centerX(safeAreaLayoutGuide.centerXAnchor)
    }
    
    
}
