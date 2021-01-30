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
import Foundation

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

extension UIView {
    func cornerRadius(with corners: CACornerMask, cornerRadii: CGFloat) {
        self.layer.cornerRadius = cornerRadii
        self.layer.maskedCorners = corners
    }
}

extension UIImageView {
    func roundImage() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}

extension UICollectionView {
    
    func showLoagin(with message: String) {
        
        let spinner = UIActivityIndicatorView(style: .large)
        
        let view = UIView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 32)
        messageLabel.sizeToFit()
        
        view.addSubview(spinner)
        view.addSubview(messageLabel)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        messageLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 8).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.backgroundView = view;
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 32)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UIViewController {
    func showLoading(with message: String = "Please wait...") {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func handleOperationResult(type: ActionModalType, height: Float = 180, handler: (() -> Void)? = nil) {
        let actionViewController = DefaultModelViewController()
        actionViewController.actionableModal = type
        actionViewController.handler = handler
        
        presentModal(
            actionViewController,
            width: .fluid(percentage: 0.8),
            height: .custom(size: height),
            backgroundOpacity: 0.8
        )
    }
    
    internal func handleError(_ error: Error, handler: (() -> Void)? = nil) {
        switch error {
        case let localizableError as LocalizableErrorDescription:
            let description = localizableError.description
            
            let actionViewController = DefaultModelViewController()
            actionViewController.actionableModal = ActionModalType.exception(
                description: description
            )
            
            actionViewController.handler = handler
            
            presentModal(
                actionViewController,
                width: .fluid(percentage: 0.8),
                height: .custom(size: 200),
                backgroundOpacity: 0.8
            )
            
        case let validationException as ValidationException:
            let description = validationException.description
            
            let actionViewController = DefaultModelViewController()
            actionViewController.actionableModal = ActionModalType.exception(
                description: description
            )
            
            actionViewController.handler = handler
            
            presentModal(
                actionViewController,
                width: .fluid(percentage: 0.8),
                height: .custom(size: 200),
                backgroundOpacity: 0.8
            )
            
        default:
            let description = "Ocurrió un error inesperado, por favor inténtelo de nuevo más tarde"
            
            let actionViewController = DefaultModelViewController()
            actionViewController.actionableModal = ActionModalType.exception(
                description: description
            )
            
            actionViewController.handler = handler
            
            presentModal(
                actionViewController,
                width: .fluid(percentage: 0.8),
                height: .custom(size: 200),
                backgroundOpacity: 0.8
            )
        }
    }
}

extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
}

extension UITableView {
    func showLoagin(with message: String) {
        
        let spinner = UIActivityIndicatorView(style: .large)
        
        let view = UIView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 32)
        messageLabel.sizeToFit()
        
        view.addSubview(spinner)
        view.addSubview(messageLabel)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        messageLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 8).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.backgroundView = view;
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 32)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

