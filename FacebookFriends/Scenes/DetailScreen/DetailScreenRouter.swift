//
//  DetailScreenRouter.swift
//  FacebookFriends
//
//  Created by Abdullah onur Şimşek on 27.05.2023.
//

import UIKit
import MapKit

enum DetailScreenRouterPageType {
    case phone(String)
    case message(String)
    case email(String)
    case map(Double,Double)
    case wikipedia(URL)
}

protocol DetailScreenRouterProtocol: BaseRoutingProtocol,
                                     AnyObject {
    func route(to page: DetailScreenRouterPageType) throws
}

final class DetailScreenRouter: DetailScreenRouterProtocol {
    func route(to page: DetailScreenRouterPageType) throws {
        switch page {
        case .phone(let number):
            let baseUrl = "tel://)"
            guard let url = URL(string: baseUrl + number.onlyDigits()),
                  UIApplication.shared.canOpenURL(url)
            else {
                throw DetailScreenErrorTypes.cantOpenPhone
            }
            
            UIApplication.shared.open(url)
            
        case .message(let number):
            let baseUrl = "sms://"
            guard let url = URL(string: baseUrl + number.onlyDigits()),
                  UIApplication.shared.canOpenURL(url)
            else {
                throw DetailScreenErrorTypes.cantOpenSMS
            }
            
            UIApplication.shared.open(url)
            
        case .email(let userUrl):
            var isFoundError: Bool = true
            for services in emailServices.allCases {
                if let url: URL = .init(string: services.baseUrl + userUrl), UIApplication.shared.canOpenURL(url) {
                    print(url)
                    UIApplication.shared.open(url)
                    isFoundError = false
                    break
                }
            }
            
            if isFoundError {
                throw DetailScreenErrorTypes.cantOpenMail
            }
            
        case .map(let latitude, let longitude):
            let latitude: CLLocationDegrees = latitude
            let longitude: CLLocationDegrees = longitude
            
            let regionDistance:CLLocationDistance = 5000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates,
                                                latitudinalMeters: regionDistance,
                                                longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates,
                                        addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMaps(launchOptions: options)
            
        case .wikipedia(let url):
            UIApplication.shared.open(url)
            
        }
        
    }
    
}
