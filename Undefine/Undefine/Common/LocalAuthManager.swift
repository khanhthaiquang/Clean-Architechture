//
//  LocalAuthManager.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import LocalAuthentication

class LocalAuthManager {
  enum BiometricType {
    case none
    case touchId
    case faceId
  }
  
  public static let shared = LocalAuthManager()
  private var error: NSError?

  /// return type biometrics device support
  func getTypeLocalAuthOfDevice() -> BiometricType {
    let authContext = LAContext()
    guard authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
      return .none
    }
    switch authContext.biometryType {
    case .none:
      return .none
    case .touchID:
      return .touchId
    case .faceID:
      return .faceId
    @unknown default:
      fatalError("Can not detect")
    }
  }
  
  // MARK: - AuthenticalBiometrics touch and face id
  func authenticalBiometrice(completion: @escaping (_ error: NSError?) -> Void) {
    let context = LAContext()
    var authError: NSError?
    context.localizedFallbackTitle = " "
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: " ") { (success, evaluateError) in
        if success {
          DispatchQueue.main.async {
            completion(nil)
          }
          
        } else {
          if let error = evaluateError as NSError? {
            DispatchQueue.main.async {
              completion(error)
            }
          }
        }
      }
    } else {
      if let error = authError {
        DispatchQueue.main.async {
          completion(error)
        }
      }
    }
  }
  
  static func getStatusBiometrics() -> LAError.Code? {
    let context = LAContext()
    var authError: NSError?
    context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)
    if let error = authError as? LAError {
      return error.code
    }
    return nil
  }
}

