
import Mindbox
import UserNotifications

final public class HandlerDidTapPushNotificationService {
    
    public var presentAdvertising: ((PushModel) -> Void)?
    
    public var pushModel: PushModel?
    
    public func handler(with response: UNNotificationResponse){
        let userInfo = response.notification.request.content.userInfo
        guard let pushModel = parse(with: userInfo) else { return }
        Mindbox.shared.pushClicked(response: response)
        if self.presentAdvertising == nil {
            self.pushModel = pushModel
        } else {
            self.presentAdvertising?(pushModel)
        }
    }
    
    private func parse(with userInfo: [AnyHashable : Any]) -> PushModel? {
        let clickUrlString = (userInfo["clickUrl"] as? String) ?? ""
        let homeUrlString = (userInfo["payload"] as? String) ?? ""
        let clickUrl = URL(string: clickUrlString)
        let homeUrl = URL(string: homeUrlString)
        let pushModel = PushModel(
            homeUrl: homeUrl,
            clickUrl: clickUrl
        )
        return pushModel
    }
    
    public struct PushModel {
        public let homeUrl: URL?
        public let clickUrl: URL?
        
        public init(
            homeUrl: URL?,
            clickUrl: URL?
        ) {
            self.homeUrl = homeUrl
            self.clickUrl = clickUrl
        }
    }
    public init() {}
}
