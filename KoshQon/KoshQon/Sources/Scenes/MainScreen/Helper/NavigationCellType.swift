enum NavigationCellType: CaseIterable {
    case main(Main)
    case settings(Settings)
    case privacy(Privacy)
    case theme(Theme)
    case language(Language)
    
    static var allCases: [NavigationCellType] {
        var cases: [NavigationCellType] = []
        cases.append(contentsOf: Main.allCases.map { NavigationCellType.main($0) })
        cases.append(contentsOf: Settings.allCases.map { NavigationCellType.settings($0) })
        cases.append(contentsOf: Privacy.allCases.map { NavigationCellType.privacy($0) })
        cases.append(contentsOf: Theme.allCases.map { NavigationCellType.theme($0) })
        cases.append(contentsOf: Language.allCases.map { NavigationCellType.language($0) })
        return cases
    }
    
    enum Main: String, CaseIterable {
        case search
        case myAnnouncements
        case guide
    }
    
    enum Settings: String, CaseIterable {
        case personal
        case privacy
        case theme
        case language
        case about
        case quit
    }
    
    enum Privacy: String, CaseIterable {
        case deactivate
    }
    
    enum Theme: String, CaseIterable {
        case themeLight
        case themeDark
        case themeDefault
        
        var appTheme: AppTheme {
            switch self {
            case .themeLight:
                return .light
            case .themeDark:
                return .dark
            case .themeDefault:
                return .phone
            }
        }
    }
    
    enum Language: String, CaseIterable {
        case languageKazakh
        case languageRussian
        case languageEnglish
    }
}
