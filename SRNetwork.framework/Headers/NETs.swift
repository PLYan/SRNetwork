//
//  NETs.swift
//  SRNetwork
//
//  Created by yanpeng on 2020/12/7.
//

import Foundation

public typealias SRRSuccess  = (Decodable) -> ()
public typealias SRRFailed   = (SRNetworkingError) -> Void
public typealias SRRProgress = (Progress) -> Void

public typealias SRNHeaders          = () -> [String: Any?]
public typealias SRNCommonParams     = () -> [String: Any?]
public typealias SRNDataPreprocessor = (Data) -> Data

public class NETs {
    
    public static func headers(headers: @escaping SRNHeaders)       { SRN.headersHandle = headers }
    public static func commons(params:  @escaping SRNCommonParams)  { SRN.paramsHandle  = params  }
    
    /*
     ResponseData preprocess function
     You can customize the pre-processed response data to facilitate decoding to the corresponding data model
     */
    public static func preprocess(handle: @escaping (Data) -> Data) { SRN.preprocessHandle = handle }
    
    /*
     Default 15 seconds.
     */
    public static func timeoutIntervalForRequest(timeout: TimeInterval) {
        SRN.session.sessionConfiguration.timeoutIntervalForRequest = timeout
    }
    
    /*
     Default 15 seconds.
     */
    public static func timeoutIntervalForResource(timeout: TimeInterval) {
        SRN.session.sessionConfiguration.timeoutIntervalForResource = timeout
    }
    
}

extension NETs {
    
    @discardableResult
    public static func get<T: Codable>(path: String, parameters: [String: Any]? = nil, decoding: T.Type, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.get(url: path, parameters: parameters, decoding: decoding).success {
            success($0)
        }.failed {
            failed($0)
        }
    }
    
    @discardableResult
    public static func post<T: Codable>(path: String, parameters: [String : Any]? = nil, decoding: T.Type, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.post(url: path, parameters: parameters, decoding: decoding).success {
            success($0)
        }.failed {
            failed($0)
        }
    }
    
    @discardableResult
    public static func upload<T: Codable>(path: String, parameters: [String : String]? = nil, headers: [String : String]? = nil ,data: [SRMultipartData]? = nil, decoding: T.Type, progress: @escaping SRRProgress, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.upload(url: path, parameters: parameters, headers: headers, datas: data, decoding: decoding).progress {
            progress($0)
        }.success {
            success($0)
        }.failed {
            failed($0)
        }
    }
    
    @discardableResult
    public static func put<T: Codable>(path: String, parameters: [String : Any]? = nil, decoding: T.Type, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.put(url: path, parameters: parameters, decoding: decoding).success {
            success($0)
        }.failed {
            failed($0)
        }
    }
    
    @discardableResult
    public static func delete<T: Codable>(path: String, parameters: [String : Any]? = nil, decoding: T.Type, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.delete(url: path, parameters: parameters, decoding: decoding).success {
            success($0)
        }.failed {
            failed($0)
        }
    }
    
    public static func download(path: String, parameters: [String : String]? = nil, headers: [String : String]? = nil, progress: @escaping SRRProgress, success: @escaping SRRSuccess, failed: @escaping SRRFailed) -> SRRequest {
        SRN.download(url: path, parameters: parameters, headers: headers).progress {
            progress($0)
        }.success {
            success($0)
        }.failed {
            failed($0)
        }
    }
}

extension NETs {
    public static func startMonitoring(listener: ((SRReachabilityStatus) -> Void)? = nil) {
        SRR.startMonitoring(listener: listener)
    }
    
    public static func stopMonitoring() {
        SRR.stopMonitoring()
    }
}
