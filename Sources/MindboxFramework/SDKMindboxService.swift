
import Mindbox
import Foundation

final public class SDKMindboxService {
    
    private let endpointProduction: String
    private let endpointDevelopment: String
    private let domain = "api.mindbox.cloud"
    
    public init(
        endpointProduction: String,
        endpointDevelopment: String
    ) {
        self.endpointProduction = endpointProduction
        self.endpointDevelopment = endpointDevelopment
    }
    
    public func setup(with setup: Setup){
        let endpoint: String
        switch setup {
            case .production:
                endpoint = self.endpointProduction
            case .development:
                endpoint = self.endpointDevelopment
        }
        do {
            let mindboxSdkConfig = try MBConfiguration(
                endpoint: endpoint.fromBase64() ?? "",
                domain: self.domain,
                subscribeCustomerIfCreated: true,
                shouldCreateCustomer: true
            )
            self.inition(with: mindboxSdkConfig)
        } catch let error {
            print(error.localizedDescription, "mindboxSdkConfig error")
        }
    }
    
    private func inition(with mindboxSdkConfig: MBConfiguration){
        Mindbox.shared.initialization(configuration: mindboxSdkConfig)
        Mindbox.shared.getDeviceUUID { deviceUUID in
            print(deviceUUID)
        }
    }
}

public enum Setup {
    
    case production
    case development
}
