//
//  googleMap+.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 28/10/2021.
//
import Foundation
import GoogleMaps

private struct MapPath : Decodable{
    var routes : [RouteMap]?
}

private struct RouteMap : Decodable{
    var overview_polyline : OverView?
}

private struct OverView : Decodable {
    var points : String?
}

extension GMSMapView {
    
    func camer(lat:Double , lng : Double, zoom:Float){
        let camer =   GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: zoom)
        self.camera = camer
    }
    //MARK:- Call API for polygon points
//
    
    func drawPolygon(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, complition: ((_ path: [LocationAddress], _ duration: Int?, _ distance: Int?) -> Void)? = nil){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Constants.apiGoogleMap)") else {
          return
        }
        print(url)
        DispatchQueue.main.async {
          session.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
              complition?([], nil, nil)
              return
            }
            do {
              let route = try JSONDecoder().decode(GoogleMapModel.self, from: data!)
                
              let firstRouter = route.routes?.first
              if let points = firstRouter?.overviewPolyline?.points {
                self.drawPath(with: points)
    //            let path = firstRouter?.overviewPolyline?.points
                let time = firstRouter?.legs?.first?.duration?.value
                let distance = firstRouter?.legs?.first?.distance?.value
                var arrPoints: [LocationAddress] = []
                if let steps = firstRouter?.legs?.first?.steps {
                  steps.forEach({
                    arrPoints.append(LocationAddress(latitude: $0.startLocation?.lat, longitude: $0.startLocation?.lng))
                    arrPoints.append(LocationAddress(latitude: $0.endLocation?.lat, longitude: $0.endLocation?.lng))
                  })
                }
                complition?(arrPoints, time, distance)
              }
              // print(route.routes?.first?.overview_polyline?.points)
            } catch let error {
              print("Failed to draw ",error.localizedDescription)
              complition?([], nil, nil)
            }
          }.resume()
        }
      }

    
    //MARK:- Draw polygon
    func drawPath(with points : String){
        DispatchQueue.main.async {
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3.0
            polyline.strokeColor = .mainColor
            polyline.map = self
        }
    }
    
    
    func drawPath(with path: GMSMutablePath) {
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .mainColor
        polyline.map = self
    }
    
    func drawShadow(with points: String) {
        DispatchQueue.main.async {
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 4.0
            polyline.strokeColor = UIColor.black.withAlphaComponent(0.2)
            polyline.map = self
        }
    }
    
    func removePathDraw(with points : String) {
        let path = GMSPath(fromEncodedPath: points)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = .mainColor
        polyline.map = nil
        
        
    }
    
    func marker(lat:Double, lng:Double, color:UIColor){
        let pos =  CLLocationCoordinate2DMake(lat, lng)
        let marker = GMSMarker(position: pos)
        let picColor = color
        marker.icon = GMSMarker.markerImage(with: picColor)
        marker.map = self
    }
    
    @discardableResult
    func markerView(lat:Double, lng:Double, image : UIImage, title: String? = nil)->GMSMarker {
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let marker = GMSMarker(position: position)
        marker.title = title
       
        let imageView = UIImageView(image: image)
        imageView.withHeight(30)
        imageView.withWidth(30)
        marker.iconView = imageView
//        marker.iconView = UIImageView(image: UIImage(named: ""))
        marker.map = self
        return marker
    }
    @discardableResult
    func markerView(lat:Double, lng:Double, imageUrl : String, title: String? = nil)->GMSMarker {
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let marker = GMSMarker(position: position)
        marker.title = title
//        marker.iconView = UIImageView(image: image)
        UIImageView().load(with: imageUrl) { (_image) in
            guard let image = _image else {return}
            let imageView = UIImageView(image: image)
            imageView.withHeight(30)
            imageView.withWidth(30)
            marker.iconView = imageView
        }
//        marker.iconView = UIImageView(image: UIImage(named: ""))
        marker.map = self
        return marker
    }
}


struct GoogleMapModel: Codable {
    let geocodedWaypoints: [GeocodedWaypoint]?
    let routes: [Route]?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case geocodedWaypoints = "geocoded_waypoints"
        case routes, status
    }
}

// MARK: - GeocodedWaypoint
struct GeocodedWaypoint: Codable {
    let geocoderStatus, placeID: String?
    let types: [String]?

    enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
    }
}

// MARK: - Route
struct Route: Codable {
    let bounds: Bounds?
    let copyrights: String?
    let legs: [Leg]?
    let overviewPolyline: Polyline?
    let summary: String?
//    let warnings, waypointOrder: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case bounds, copyrights, legs
        case overviewPolyline = "overview_polyline"
        case summary//, //warnings
//        case waypointOrder = "waypoint_order"
    }
}



// MARK: - Northeast
struct Northeast: Codable {
    let lat, lng: Double?
}

// MARK: - Leg
struct Leg: Codable {
    let distance, duration: Distance?
    let endAddress: String?
    let endLocation: Northeast?
    let startAddress: String?
    let startLocation: Northeast?
    let steps: [Step]?
//    let trafficSpeedEntry, viaWaypoint: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case distance, duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
        case steps
//        case trafficSpeedEntry = "traffic_speed_entry"
//        case viaWaypoint = "via_waypoint"
    }
}

// MARK: - Distance
struct Distance: Codable {
    let text: String?
    let value: Int?
}

// MARK: - Step
struct Step: Codable {
    let distance, duration: Distance?
    let endLocation: Northeast?
    let polyline: Polyline?
    let startLocation: Northeast?
    let travelMode, maneuver: String?

    enum CodingKeys: String, CodingKey {
        case distance, duration
        case endLocation = "end_location"
        case polyline
        case startLocation = "start_location"
        case travelMode = "travel_mode"
        case maneuver
    }
}

// MARK: - Polyline
struct Polyline: Codable {
    let points: String?
}

// MARK: - Encode/decode helpers



    
struct LocationAddress: Codable {
  var latitude: Double?
  var longitude: Double?
    
    
    func getBody() -> [String: Any] {
        let x = ["longitude": longitude, "latitude": latitude].compactMapValues({$0})
        return x
    }
}

struct LocationRoute: Codable {
  let lat: Double
  let lng: Double
    
    
}

import MapKit

extension GMSCoordinateBounds {
    var region: MKCoordinateRegion {
        get {
            let latitudeDelta = northEast.latitude - southWest.latitude
            let longitudeDelta = northEast.longitude - southWest.longitude
            let center = CLLocationCoordinate2DMake(
                (southWest.latitude + northEast.latitude) / 2,
                (southWest.longitude + northEast.longitude) / 2)
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            return MKCoordinateRegion(center: center, span: span)

        }
    }
}

extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
