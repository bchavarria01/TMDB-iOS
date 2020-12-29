//
//  UIViewController+deviceType.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit

enum DeviceTypeModel {
    case unknow
    case iphoneX
    case iphone8Plus
    case iphone8
    case iphoneSE //SE is the like iphone 5 and iphone 5s
    case iphone4s
}

extension UIViewController {
    func currentDevice() -> DeviceTypeModel {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return .iphoneX
            case 1920:
                return .iphone8Plus
            case 1334:
                return .iphone8
            case 1136:
                return .iphoneSE
            default:
                return .iphone4s
            }
        }
        return .unknow
    }
}
