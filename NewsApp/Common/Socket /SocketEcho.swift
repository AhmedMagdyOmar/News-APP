//
//  SocketEcho.swift
//  Caberz
//
//  Created by Ahmed Elesawy on 12/17/20.
//

import Foundation

protocol SocketEchoProtocol: AnyObject {
//    func newMessage(chat: ChattingModel?)
    func updateLocation(lat: Double, lng: Double, driverId: Int)
    func removeDriver(driverId: Int)
    func trackDriver(lat: Double, lng: Double)
}

extension SocketEchoProtocol {
//    func newMessage(chat: ChattingModel?){}
    func updateLocation(lat: Double, lng: Double, driverId: Int){}
    func removeDriver(driverId: Int){}
    func trackDriver(lat: Double, lng: Double) {}
}

class SocketEcho {
    private var echo: Echo?
    static var shared = SocketEcho()
    private var iChannel: IChannel?
    weak var delegate:SocketEchoProtocol?
    private let cacheService = CacheService()
    private init() {
        iniSocket()
    }
    deinit {
        echo = nil
    }
    
    private func iniSocket() {
        
       // guard let token = cacheService.getUserData()?.token else{return}
//        print(token)
        let token = "444"
        let host = "\(Constants.baseUrlKey):\(ConstantsEnum.echoPort)"
        echo = Echo(options: ["host":host, "auth": [
                                "headers": ["Authorization": "Bearer " + token, "broadcaster": "socket.io"],"Content-Type": "Application/json"]])
        print(echo?.options)
    }
    func connect(completion: @escaping()-> Void) {
        echo?.connected { [weak self] (data, ack) in
            print("data in socket is \(data)")
            print("ack in socket is \(ack)")
           completion()
        }
    }
    
    func join() {
        let _ = echo?.join(channel: "ureem-online")
    }
    
    func connectToDriverUpdateLocation(){
        iChannel = echo?.privateChannel(channel: "ureem-update-location.driver")
    }
    
    
    func updateLocation(lat: Double, lng: Double, angle: Double, speed: Double){
         let id = 77777 //cacheService.getUserData()?.id else {return}
                
        let data = [
            "driver_id": "\(id)",
            "lat": "\(lat)",
            "lng": "\(lng)",
            "angle": "\(angle)",
            "speed":  "\(speed)"
        ]
        guard let channelEmit = iChannel as? IPrivateChannel else{ return }
        
        let _ = channelEmit.whisper(eventName: "moving", data: data)
//        print("----- Sen Location to seocket ---------- \(id)")
        let _ =  self.echo?.privateChannel(channel: "ureem-update-location.driver").listenForWhisper(event: "moving") { (data, ack) in
//            print(data)
//            print("----- Sen Location to seocket ---------- \(id)")
            
        }
    }
    
    func getDriversLocationForClient() {
        let _ = echo?.privateChannel(channel: "ureem-update-location.driver").listenForWhisper(event: "moving", callback: { [weak self](data, ack) in
            // check with driver id
            print("--------------------------------------")
            let json = SwiftyJSON(data)
            guard let arr = json.array, arr.count == 2 else {return}
            let lat = arr[1]["lat"].doubleValue
            let lng = arr[1]["lng"].doubleValue
            let sokcetdriverId = arr[1]["driver_id"].intValue
            self?.delegate?.updateLocation(lat: lat, lng: lng, driverId: sokcetdriverId)
        })
    }
    
    func offlineDrivers() {
        let _ =  self.echo?.join(channel: "online").leaving(callback: { (data, ack) in
            let json = SwiftyJSON(data)
            guard let arr = json.array, arr.count == 2 else {return}
            let sokcetdriverId = arr[1]["driver_id"].intValue
            self.delegate?.removeDriver(driverId: sokcetdriverId)
        })
    }
    
    func disconnect() {
        echo?.disconnect()
        echo = nil
    }
    
    var chatChannel:  IChannel?
}



// MARK:- Listen
extension SocketEcho {
    
    func moving(driverId: String) {
        let channel = echo?.privateChannel(channel: "ureem-update-location.driver")
        channel?.subscribe()
        let _ = channel?.listenForWhisper(event: "moving", callback: { [weak self](data, ack) in
            // check with driver id
            let json = SwiftyJSON(data)
            guard let arr = json.array, arr.count == 2 else {return}
            let sokcetdriverId = arr[1]["driver_id"].stringValue
            guard driverId == sokcetdriverId else {return}
//            print("-------------------------------------- \(sokcetdriverId) my \(driverId)")
            let lat = arr[1]["lat"].doubleValue
            let lng = arr[1]["lng"].doubleValue
//            print("latingggg \(lat)")
            self?.delegate?.trackDriver(lat: lat, lng: lng)
        })
    }
    
    func unSubscribeMoving(){
        echo?.privateChannel(channel: "ureem-update-location.driver").unsubscribe()
    }
    
    func chat(chatId: String) {
        let channel = echo?.privateChannel(channel: "naqliya-chat.\(chatId)")
        channel?.subscribe()
        let _ =   channel?.listen(event: ".NewMessage", callback: { [weak self] data, ack in
//            print(data)
            let model = data.filter({ !($0 is String) })
            let json  = SwiftyJSON(model)
            do {
//                let model = try JSONDecoder.decodeFromData([ChattingModel].self, data: json.rawData(options: .fragmentsAllowed))
//                self?.delegate?.newMessage(chat: model.first)
//                print(json)
            } catch {
                #if DEBUG
//                self?.delegate?.newMessage(chat: nil)
                #endif
            }
        })
    }
    
    func unSubscribeChat(_ chatID: String){
        echo?.privateChannel(channel: "naqliya-chat.\(chatID)").unsubscribe()
    }
}
