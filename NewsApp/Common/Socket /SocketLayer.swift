//
//  SocketLayer.swift
//  Caberz
//
//  Created by Youssef on 21/12/2020.
//

import Foundation
import SocketIO

protocol SocketServiceProtocol: AnyObject {
    func didDisconnect()
    func didConnect()
}

class SocketService {
    //instance
    static var instance: SocketService = SocketService()
    private let cacheService = CacheService()
    
    //    static var instance: SocketService {
    //        if currentInstance == nil {
    //             currentInstance = SocketService()
    //        }
    //        return currentInstance!
    //    }
    //    static var instance: SocketService?
    
    private let socketUrl = URL(string: "\(Constants.baseUrlKey):\(ConstantsEnum.socketPort)")!
    
    //    private let manager: SocketIOClient
    private var socket: SocketIOClient?
    weak var delegate: SocketServiceProtocol?
    let socketConfig: SocketIOClientConfiguration = [.log(true), .compress]
    var isConnected: Bool {
        return getConnectionStatus()
    }
    
    typealias comp = ((_ success: Bool) -> Void)?
    
    private init() {
        socket =   SocketIOClient(socketURL: socketUrl, config: socketConfig)
    }
    
    func establishConnection() {
        guard !getConnectionStatus() else { return }
        // guard delegate != nil else { return }
        
        socket?.connect()
        
        socket?.once(clientEvent: .connect) {[weak self] (data, ack) in
            print("socket connected")
            self?.delegate?.didConnect()
        }
        
        socket?.on(clientEvent: .disconnect) {[weak self] (data, ack) in
            print("socket disconnect")
            self?.delegate?.didDisconnect()
        }
    }
    
    
    private func getConnectionStatus() -> Bool {
        let socketConnectionStatus = socket?.status
        
        switch socketConnectionStatus {
        case .connected:
            return true
        case .connecting:
            return false
        case .disconnected:
            return false
        case .notConnected:
            return false
        case .none:
            return false
        }
    }
}

extension SocketService {
    func updateLocation(driverId: String, speed: Double, angle: Double, lat: Double, lng: Double) {
        let _ = "99"//cacheService.getUserData()?.token else {return}
        let token = FirebaseMessagingManger.firebaseMessagingToken
        
        let stringData = [
            "driver_id": driverId,
            "lat": lat,
            "lng": lng,
            "angle": angle,
            "type": "ios",
            "token": token,
            "speed": speed
        ] as [String : Any]
        // guard let data = converModelToJsonString(object: obj) else{return}
         print(stringData)
        socket?.emit("update_location", stringData)
    }
    
    //    func disconect() {
    //        socket = nil
    ////        SocketService.instance = nil
    //        socket?.disconnect()
    //
    //    }
}
