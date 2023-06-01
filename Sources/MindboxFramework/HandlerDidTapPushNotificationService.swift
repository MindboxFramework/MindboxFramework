
import Mindbox
import UserNotifications

final public class HandlerDidTapPushNotificationService {
    
    public var presentAdvertising: ((String) -> Void)?
    
    public var urlAdvertising: String?
    
    public func handler(with response: UNNotificationResponse){
        let userInfo = response.notification.request.content.userInfo
        guard let urlAdvertising = parse(with: userInfo) else { return }
        Mindbox.shared.pushClicked(response: response)
        if self.presentAdvertising == nil {
            self.urlAdvertising = urlAdvertising
        } else {
            self.presentAdvertising?(urlAdvertising)
        }
    }
    
    private func parse(with userInfo: [AnyHashable : Any]) -> String? {
        let domainAdvertising = userInfo["clickUrl"] as? String
        return domainAdvertising
    }
    
    public init() {}
}
