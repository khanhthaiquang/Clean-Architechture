//
//  GMONotificationsManager.swift
//  Undefine
//
//  Created by KhánhTQ on 28/10/2022.
//

import Foundation
import FirebaseMessaging
import Firebase

// Tham khảo: https://firebase.google.com/docs/cloud-messaging/ios/client

class GMONotificationsManager: NSObject {
  static let shared = GMONotificationsManager()
  private var application = UIApplication.shared
  
  func configFirebase(application: UIApplication) {
      let filePath = Bundle.main.path(forResource: "GoogleService-Info",
                                      ofType: "plist", inDirectory: nil) ?? ""
      guard let firebaseOptions = FirebaseOptions.init(contentsOfFile: filePath) else {
          print("Can not config firebase")
          return
      }
      FirebaseApp.configure(options: firebaseOptions)
      registerNotification(application: application)
      self.application = application
  }
  
  private func registerNotification(application: UIApplication) {
      if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: {_, _ in })
      } else {
          let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()
      Messaging.messaging().delegate = self
      Messaging.messaging().isAutoInitEnabled = true
  }

  func registerForRemoteNotifications() {
    if #available(iOS 10.0, *) {
      // For iOS 10 display notification (sent via APNS)
      UNUserNotificationCenter.current().delegate = self

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }

    application.registerForRemoteNotifications()
  }
  
}

extension GMONotificationsManager: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([.alert, .badge, .sound])
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo
      guard let data = userInfo as? [String: Any?] else {
          return
      }
      handleDataNotification(data: data)
      completionHandler()
  }

  func handleDataNotification(data: [String: Any?]) {
    // TODO somethings
  }
}

extension GMONotificationsManager: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("FCM token: \(fcmToken ?? "")")
  }
  
  func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
    print("FCM token: \(fcmToken)")
  }
  
  func application(application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken as Data
  }
}
