//
//  TealiumHelper.swift
//
//  Copyright © 2019 Tealium. All rights reserved.
//

import Foundation
import TealiumSwift

enum TealiumConfiguration {
    static let account = "sales-seoud"
    static let profile = "scb-phoenix"
    static let environment = "dev"
    static let dataSourceKey = "s2w7d5"
}

let enableLogs = true

class TealiumHelper {

    static let shared = TealiumHelper()

    let config = TealiumConfig(account: TealiumConfiguration.account,
                               profile: TealiumConfiguration.profile,
                               environment: TealiumConfiguration.environment,
                               dataSource: TealiumConfiguration.dataSourceKey)

    var tealium: Tealium?

    // MARK: Tealium Initilization
    private init() {

        if enableLogs { config.logLevel = .debug }

        // Set up consent manager
        config.consentLoggingEnabled = true
        config.consentPolicy = .gdpr // You can also create your own custom policy by using `.custom(MyCustomPolicy.self)`
        config.consentExpiry = (90, .days)
        config.onConsentExpiration = {
            print("Consent Expired")
        }

        // Add collectors
        config.collectors = [Collectors.Lifecycle]

        // Add dispatchers
        config.dispatchers = [Dispatchers.Collect]

        //tealium = Tealium(config: config)
        tealium = Tealium(config: config) { [weak self] _ in
            guard let self = self else {
                return
            }
            
            self.tealium?.consentManager?.userConsentStatus = .consented
            self.tealium?.track(TealiumEvent("tealium_initialized"))
        }
    }

    public func start() {
        _ = TealiumHelper.shared
    }
    
    class func trackScreen(_ view: UIViewController, name: String) {
        TealiumHelper.trackView(title: "screen_view",
                                dataLayer: ["screen_name": name,
                                            "screen_class": "\(view.classForCoder)"])
    }

    class func trackView(title: String, dataLayer: [String: Any]?) {
        let dispatch = TealiumView(title, dataLayer: dataLayer)
        TealiumHelper.shared.tealium?.track(dispatch)
    }

    class func trackEvent(title: String, dataLayer: [String: Any]?) {
        let dispatch = TealiumEvent(title, dataLayer: dataLayer)
        TealiumHelper.shared.tealium?.track(dispatch)
    }
    
    class func joinTrace(id: String) {
        TealiumHelper.shared.tealium?.joinTrace(id: id)
        TealiumHelper.trackEvent(title: "trace", dataLayer: ["tealium_trace_id": id])
    }

    class func leaveTrace() {
        TealiumHelper.shared.tealium?.leaveTrace()
    }

    class func killTrace(traceId: String) {
        TealiumHelper.trackEvent(title: "kill_trace",
                                 dataLayer: ["event": "kill_visitor_session",
                                             "cp.trace_id": traceId])
    }

    // MARK: Consent Manager Helper Mehthods
    func resetConsentPreferences() {
        tealium?.consentManager?.resetUserConsentPreferences()
    }

    func updateConsentPreferences(_ dictionary: [String: Any]) {
        if let status = dictionary["consentStatus"] as? String {
            var tealiumConsentCategories = [TealiumConsentCategories]()
            let tealiumConsentStatus = (status == "consented") ? TealiumConsentStatus.consented : TealiumConsentStatus.notConsented
            if let categories = dictionary["consentCategories"] as? [String] {
                tealiumConsentCategories = TealiumConsentCategories.consentCategoriesStringArrayToEnum(categories)
            }
            self.tealium?.consentManager?.userConsentStatus = tealiumConsentStatus
            self.tealium?.consentManager?.userConsentCategories = tealiumConsentCategories
        }
    }

    func simpleConsent(_ dict: [String: Any]) {
        if let status = dict["consentStatus"] as? String {
            let tealiumConsentStatus = (status == "consented") ? TealiumConsentStatus.consented : TealiumConsentStatus.notConsented
            self.tealium?.consentManager?.userConsentStatus = tealiumConsentStatus
        }
    }

    var currentConsentPreferences: [String: Any]? {
        guard let status = self.tealium?.consentManager?.userConsentStatus,
              let categories = self.tealium?.consentManager?.userConsentCategories else {
            return nil
        }
        let stringStatus = status == .consented ? "consented" : "notConsented"
        let stringCategories = categories.map { $0.rawValue }
        return ["tracking_consented": stringStatus, "consent_categories": stringCategories]
    }

}

// Create your own consent policy
class MyCustomPolicy: ConsentPolicy {
    
    var preferences: UserConsentPreferences
    
    required init(_ preferences: UserConsentPreferences) {
        self.preferences = preferences
    }
    
    var name: String = "Acme Custom Consent Policy"
    
    var defaultConsentExpiry: (time: Int, unit: TimeUnit) = (45, .days)
    
    var shouldUpdateConsentCookie: Bool = false
    
    var updateConsentCookieEventName: String = ""
    
    var consentPolicyStatusInfo: [String : Any]? {
        var info = [String: Any]()
        if let categories = preferences.consentCategories {
            info["allowed_tracking_categories"] = categories.map { $0.rawValue }
        }
        info["privacy_preference"] = preferences.consentStatus.rawValue
        info["last_updated"] = Date().extendedIso8601String
        info["policy_name"] = name
        return info
    }
    
    var trackAction: TealiumConsentTrackAction = .trackingAllowed
    
    var consentTrackingEventName: String = "privacy_preference_update"
    
    var shouldLogConsentStatus: Bool = true
    
}

// Extend and override the existing GDPR or CCPA consent policies
class MyCustomGDPRPolicy: GDPRConsentPolicyCreatable {
    
    var preferences: UserConsentPreferences
    
    required init(_ preferences: UserConsentPreferences) {
        self.preferences = preferences
    }
    
    // Override the default GDPR consent policy name
    var name: String = "Acme GDPR Preferences"
    
    // Override the default GDPR consent keys and add additional info
    var consentPolicyStatusInfo: [String : Any]? {
        var info = [String: Any]()
        if let categories = preferences.consentCategories {
            info["gdpr_categories"] = categories.map { $0.rawValue }
        }
        info["gdpr_consent"] = preferences.consentStatus.rawValue
        info["last_updated"] = Date().extendedIso8601String
        info["gdpr_policy_name"] = name
        return info
    }
    
}
