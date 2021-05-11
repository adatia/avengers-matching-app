import Foundation
import UIKit
struct Alerts {
    
    //Alert box with "OK" only and no action is required
    static func showBasicAlert (on vc: UIViewController, title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    //Alert box with "OK" and action is required
    static func showActionAlertWithOkayOnly (on vc: UIViewController, with title: String, message:String, okayAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: okayAction))
        vc.present(alert, animated: true)
    }
    
    //Alert box with "OK" and "Cancel" and action is required for "OK" only
    static func showActionAlertWithOkay (on vc: UIViewController, with title: String, message:String, okayAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: okayAction))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }

    //Alert box with "OK" and "Cancel" and action is required for both
    static func showActionAlertWithOkayAndCancel (on vc: UIViewController, with title: String, message:String, okayAction: @escaping (UIAlertAction) -> Void, cancelAction: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: okayAction))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: cancelAction))
        vc.present(alert, animated: true)
    }
    

}
