//
//  Extensions.swift
//  TMDB
//
//  Created by Byron Chavarría on 28/12/20.
//   
//

import UIKit
import Presentr
import Moya

public func setupAttributedLabels(with mainString: String, and stringForRange: String, and color: UIColor?) -> NSAttributedString {
    let attributedText = NSMutableAttributedString.attributedString(
        mainString,
        font: .systemFont(ofSize: 16),
        color: color ?? R.Colors.dark.color
    )
    
    let rangeName = (mainString as NSString).range(of: stringForRange)
    attributedText.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.preferredFont(forTextStyle: .caption1),
        range: rangeName
    )
    return attributedText
}

func minutesBetweenDates(_ oldDate: Date, _ newDate: Date) -> Int {
    
    let dateFormatterNow = DateFormatter()
    dateFormatterNow.dateFormat = "yyyy-MM-dd hh:mm a"
    dateFormatterNow.timeZone = TimeZone(abbreviation: "EST")
    
    let diffInMins = Calendar.current.dateComponents([.minute], from: oldDate, to: newDate.addingTimeInterval(-(3600 * 6))).minute
    return diffInMins ?? 0
    
}

public func setupAttributedLabelNavigation(with mainString: String, and stringForRange: String, and color: UIColor?) -> NSAttributedString {
    let attributedText = NSMutableAttributedString.attributedString(
        mainString,
        font: .systemFont(ofSize: 20, weight: .bold),
        color: color ?? R.Colors.dark.color
    )
    
    let rangeName = (mainString as NSString).range(of: stringForRange)
    attributedText.addAttribute(
        NSAttributedString.Key.font,
        value: UIFont.preferredFont(forTextStyle: .caption1),
        range: rangeName
    )
    return attributedText
}

func getDateFromTimeStamp(unixtimeInterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: unixtimeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current //Set timezone that you want
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    return strDate
}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}

extension String {
    func convertToTimeStamp() -> Int {
        let dfmatter = DateFormatter()
        if self != "" {
            let date = dfmatter.date(from: self)
            let dateStamp: TimeInterval = date!.timeIntervalSince1970
            let dateSt: Int = Int(dateStamp)
            return dateSt
        } else {
            return 0
        }
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

extension UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

extension Double {
    func parseTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
    
    func parseToMoney() -> String {
        return String(format: "$%.2f", self)
    }
    
    func porcentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSDecimalNumber(decimal: Decimal(self))) ?? ""
    }
}

extension UILabel {
    func setBulletList(text:String, bullet: String, bulletColor: UIColor, attributes: [NSAttributedString.Key: Any]) {
        let r0 = text.replacingOccurrences(of: ";", with: "\n\n" + bullet)
        let r = bullet + r0
        
        let attributedString = NSMutableAttributedString(string: r)
        
        attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.length))
        
        let greenColorAttribure = [NSAttributedString.Key.foregroundColor: bulletColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]
        
        do {
            
            let regex = try NSRegularExpression(pattern: bullet, options: NSRegularExpression.Options.caseInsensitive)
            
            regex.enumerateMatches(in: r as String, options: [], range: NSMakeRange(0, r.count), using: { (result, flags, pointer) -> Void in
                
                if let result = result{
                    attributedString.addAttributes(greenColorAttribure, range:result.range)
                }
            })
            
            self.attributedText = attributedString
            
        } catch {
            self.attributedText = attributedString
        }
    }
    
}

extension UIView {
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    func addDashedBorder() {
        let color = UIColor.white.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func cornerRadius2(with corners: UIRectCorner, cornerRadii: CGSize) {
        let path = UIBezierPath(
            roundedRect: self.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func cornerRadius(with corners: CACornerMask, cornerRadii: CGFloat) {
        self.layer.cornerRadius = cornerRadii
        self.layer.maskedCorners = corners
    }
    
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIImage {
    
    func rotate(with radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
    func convertToBase64() -> String {
        let imageData = self.jpegData(compressionQuality: 1)
        let imageBase64String = imageData?.base64EncodedString()
        return imageBase64String ?? ""
    }
    
    func rotate(radians: CGFloat) -> UIImage {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}

extension UIViewController {
    func handleNetworkError(with error: MoyaError?, completitionHandler: (() -> Void)?) {
        let response: Response? = error?.response
        let statusCode: HTTPStatusCode? = response?.status
        let responseType: HTTPStatusCode.ResponseType? = response?.responseType
        var errorMessage: String?
        switch responseType {
        case .success:
            if statusCode == .noContent {
                errorMessage = L10n.notValidData
            } else {
                errorMessage = L10n.errorHasOcurred
            }
        case .clientError:
            if statusCode == .unauthorized {
                errorMessage = L10n.sessionHasExpired
            } else {
                errorMessage = L10n.errorHasOcurred
            }
        case .serverError:
            errorMessage = L10n.errorHasOcurred
        default:
            print("No error in response")
        }
        
        let screenSize: CGRect = UIScreen.main.bounds
//        let controller = DefaultModalViewController()
//        controller.descriptionLabel.text = errorMessage
//        controller.completitionHandler = completitionHandler
//        controller.type = .error
//
//        self.presentModal(
//            controller,
//            width: .custom(size: Float(screenSize.width - 32)),
//            height: .custom(size: 210),
//            backgroundOpacity: 0.4
//        )
        
    }
    func handleError(with error: String, completitionHandler: (() -> Void)?) {
        let screenSize: CGRect = UIScreen.main.bounds
//        let controller = DefaultModalViewController()
//        var errorToShow = error
//        if error == L10n.defaultMoyaErrorMessage {
//            errorToShow = L10n.defaultErrorMessage
//        }
//        controller.descriptionLabel.text = errorToShow
//        controller.completitionHandler = completitionHandler
//        controller.type = .error
//
//        self.presentModal(
//            controller,
//            width: .custom(size: Float(screenSize.width - 32)),
//            height: .custom(size: 210),
//            backgroundOpacity: 0.4
//        )
    }
    
    func presentModal(with text: String, and completitionHandler: (() -> Void)?) {
        let screenSize: CGRect = UIScreen.main.bounds
//        let controller = DefaultModalViewController()
//        controller.type = .changePassword
//        controller.descriptionLabel.text = text
//        controller.button.setTitle("Ver resolución", for: .normal)
//        controller.completitionHandler = completitionHandler
//
//        self.presentModal(
//            controller,
//            width: .custom(size: Float(screenSize.width - 32)),
//            height: .custom(size: 210),
//            backgroundOpacity: 0.4
//        )
    }
    
    func presentModal(
        _ viewController: UIViewController,
        width: ModalSize,
        height: ModalSize,
        backgroundOpacity: Float) {
        
        let presenter = Presentr.defaultPresenter(width: width, height: height)
        presenter.backgroundColor = .black
        presenter.backgroundOpacity = backgroundOpacity
        presenter.dismissOnSwipe = false
        presenter.roundCorners = true
        presenter.backgroundTap = .noAction
        presenter.cornerRadius = 8
        presenter.backgroundTap = .noAction
        
        self.customPresentViewController(
            presenter,
            viewController: viewController,
            animated: true
        )
    }
    
    internal func handleOperationResult(type: Int, height: Float = 180, handler: (() -> Void)? = nil) {
//        let actionViewController = BalanceAdvanceViewController()
//        actionViewController.view.cornerRadius(with: [.layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 32)
//        presentModal(
//            actionViewController,
//            width: .fluid(percentage: 0.8986666667),
//            height: .custom(size: height),
//            backgroundOpacity: 0.8
//        )
    }
}
