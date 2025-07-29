import ExpoModulesCore
import UIKit

// MARK: - 核心滚轮日期选择器实现
class ExpoWheelDatepickerView: ExpoView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - Properties
    private let pickerView = UIPickerView()
    private let calendar = Calendar.current
    private var currentDate: Date
    
    var onDateSelected: ((Date) -> Void)?
    let onDateChange = EventDispatcher()
    
    var selectedDate: Date {
        get {
            let year = years[pickerView.selectedRow(inComponent: 0)]
            let month = months[pickerView.selectedRow(inComponent: 1)]
            let day = days[pickerView.selectedRow(inComponent: 2)]
            
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            
            return calendar.date(from: components) ?? Date()
        }
        set {
            currentDate = newValue
            updatePickers()
        }
    }
    
    // 数据数组
    private var years: [Int] {
        let currentYear = calendar.component(.year, from: Date())
        return Array((currentYear - 100)...(currentYear + 50))
    }
    
    private var months: [Int] {
        Array(1...12)
    }
    
    private var days: [Int] {
        let selectedYear = years[pickerView.selectedRow(inComponent: 0)]
        let selectedMonth = months[pickerView.selectedRow(inComponent: 1)]
        return daysInMonth(year: selectedYear, month: selectedMonth)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        self.currentDate = Date()
        super.init(frame: frame)
        setupView()
        setupPickerView()
        updatePickers()
    }
    
      required init(appContext: AppContext? = nil) {
        
          self.currentDate = Date()
          super.init(appContext: appContext)
          clipsToBounds = true
          setupView()
          setupPickerView()
          updatePickers()
      }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
    }
    
    // MARK: - Helpers
    private func daysInMonth(year: Int, month: Int) -> [Int] {
        let components = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return Array(1...31)
        }
        return Array(range)
    }
    
    private func updatePickers() {
        let year = calendar.component(.year, from: currentDate)
        if let yearIndex = years.firstIndex(of: year) {
            pickerView.selectRow(yearIndex, inComponent: 0, animated: false)
        }
        
        let month = calendar.component(.month, from: currentDate)
        if let monthIndex = months.firstIndex(of: month) {
            pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
        }
        
        pickerView.reloadComponent(2) // 重新加载日数据
        
        let day = calendar.component(.day, from: currentDate)
        if let dayIndex = days.firstIndex(of: day) {
            pickerView.selectRow(dayIndex, inComponent: 2, animated: false)
        }
    }
    
    // MARK: - UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3 // 年、月、日三个滚轮
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return years.count
        case 1: return months.count
        case 2: return days.count
        default: return 0
        }
    }
    
    // MARK: - UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(years[row])年"
        case 1: return "\(months[row])月"
        case 2: return "\(days[row])日"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 当月或年变化时，需要重新加载日数据
        if component == 0 || component == 1 {
            pickerView.reloadComponent(2)
        }
        onDateSelected?(selectedDate)
        
        // 创建一个日期格式化器
        let dateFormatter = DateFormatter()

        // 设置日期格式为 "YYYY-MM-dd"
        // 注意: 月份是大写的 "MM"，小写的 "mm" 表示分钟
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // 可选: 设置时区（根据需要调整）
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Shanghai")

        // 可选: 设置区域（影响本地化格式，但这里我们使用固定格式）
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // 执行格式化
        let formattedDate = dateFormatter.string(from: selectedDate)
        self.onDateChange(["date": formattedDate])
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // 根据屏幕宽度分配三个滚轮的宽度
        return bounds.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        40
    }
}
