//
//  LocalNotificationHelper.swift
//  LastCoffee
//
//  Created by 이수현 on 2/28/25.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() {}

    // 푸시 알림 권한 설정
    func setAuthorization() {
        // 필요한 알림 권한을 설정
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions) { granted, error in
                if granted {
                    print("알림 권한이 허용되었습니다.")
                } else {
                    print("알림 권한이 거부되었습니다.")
                }
        }
    }
    
    // 푸시 알림 보내기 (특정 시간 후 반복)
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
        // 1. 알림 내용 설정
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        // 2. 조건 (시간, 반복)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        // 3. 요청
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        
        // 4. 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: \(error)")
            }
        }
    }
    
    // 특정 날짜(시점)에 실행하기
    func pushReservedNotification(title: String, body: String, date: Date, identifier: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        let triggerComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error {
                print("Notification Error: \(error)")
            }
        }
    }
    
    // 하루 중 특정 시간에 실행
    func pushScheduledNotification(title: String, body: String, hour: Int, identifier: String) {

        assert(hour >= 0 || hour <= 24, "시간은 0이상 24이하로 입력해주세요.")

        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body

        var dateComponents = DateComponents()
        dateComponents.hour = hour  // ✅ 알림을 보낼 시간 (24시간 형식)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // ✅ true
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    /// 대기중인 Push Notification을 출력합니다.
    func printPendingNotification() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Title: \(request.content.title)")
                print("Body: \(request.content.body)")
                print("Trigger: \(String(describing: request.trigger))")
            }
            
            print("---")
        }
    }
    
    // 예약된 알림 삭제
    func removePendingNotification(identifiers: [String]){
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    // 이미 전달된 알림 삭제
    func removeDeliveredNotification(identifiers: [String]){
        UNUserNotificationCenter
            .current()
            .removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    // 모든 알림 삭제
    func removeAllNotification(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
