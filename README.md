<h1 align="center">
    SRNetwork
</h1>

## Quick start

### Requirements and Installation


```Cocoapods
# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

target 'Your Target Name' do
  pod 'SRNetwork'
end
```

### Example Usage

If you want to monitor network status, you can do it like this：
```
NETs.startMonitoring { status in
    switch status {
    case .cellular:
        print("cellular")
    case .ethernetOrWiFi:
        print("wifi")
    case .notReachable:
        print("notReachable")
    case .unknown:
        print("unknown")
    }
}
```

If you want to set generic request headers, you can do it like this:
```
NETs.headers {
    return [
        "Content-type" : "application/json",
        "Accept" : "application/json"
    ]
}
```

If you want to set the public parameters of the request, you can do it like this:
```
NETs.commons {
    return ["cou" : "US",
            "lan" : "EN",
            "cur" : "USD",
            "tz"  : TimeZone.current.abbreviation() ?? "",
            "g_platform"     : "ios",
            "g_app_version"  : "1.0.1",
            "g_os_version"   : UIDevice.current.systemVersion,
            "g_device_id"    : "000000-000000-000000-000000",
            "g_device_model" : "iPhone12",
            "g_signal"       : "wifi"
    ]
}
```

If you want to set up a general way of preprocessing response data, you can do it like this:
```
NETs.preprocess { data in
    guard let dict = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? NSDictionary,
          let newDataDict = dict["data"] as? NSDictionary
    else { return data }
    return (try? JSONSerialization.data(withJSONObject: newDataDict, options: .fragmentsAllowed)) ?? data
}
```

