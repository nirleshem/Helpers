//
//  Extensions.swift
//  stam
//
//  Created by Nir L on 163 2021.
//

import Foundation
import UIKit

// MARK:- Init Nib
extension UIView {
    /// Helper method to init and setup the view from the Nib.
    func initNib() {
        let view = loadFromNib()
        addSubview(view)
        stretch(view: view)
    }
    /// Method to init the view from a Nib.
    ///
    /// - Returns: Optional UIView initialized from the Nib of the same class name.
    func loadFromNib<T: UIView>() -> T {
        let selfType = type(of: self)
        let bundle = Bundle(for: selfType)
        let nibName = String(describing: selfType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Error loading nib with name \(nibName)")
        }
        return view
    }
    /// Stretches the input view to the UIView frame using Auto-layout
    ///
    /// - Parameter view: The view to stretch.
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    static func instantiateView<T>(ofType type: T.Type = T.self) -> T where T: UIView {
        let nib = UINib(nibName: T.description(), bundle: Bundle(for: T.self))
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("‼️‼️‼️ The root view in \(nib) nib must be of type \(self)")
        }
        return view
    }
}

// MARK:- Corner Radius
extension UIView {
    func cornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

// MARK:- Border Line
extension UIView {
    func borderLine(width: CGFloat = 1, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}

// MARK:- Rounded
extension UIView {
    func rounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

// MARK:- Add Shadow
extension UIView {
    func addShadow(
       cornerRadius: CGFloat = 16,
       shadowColor: UIColor = UIColor(white: 0.0, alpha: 0.5),
       shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
       shadowOpacity: Float = 0.3,
       shadowRadius: CGFloat = 5) {
      
          layer.cornerRadius = cornerRadius
          layer.shadowColor = shadowColor.cgColor
          layer.shadowOffset = shadowOffset
          layer.shadowOpacity = shadowOpacity
          layer.shadowRadius = shadowRadius
    }
}

// MARK:- Color Etx.
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329 //color #999999 if string has wrong format
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(red: Int, green: Int, blue: Int, reqAlpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: reqAlpha)
    }
    static var peaGreen: UIColor { return UIColor(hexFromString: "#7dbf0d")}
}

// MARK:- Date Etx.
extension Date {
    func getCurrentDateString(_ format: String = "dd/MM/yyyy HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: Date())
    }
}
