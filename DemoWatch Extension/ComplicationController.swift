//
//  ComplicationController.swift
//  DemoWatch Extension
//
//  Created by ChenDong on 2018/12/6.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        var entry : CLKComplicationTimelineEntry?
        let now = Date()
        
        // Create the template and timeline entry.
        switch complication.family {
        case .modularSmall:
            // 如果 current 返回为 nil，则使用 placeholder
            break
        case .circularSmall:
            let tmp = CLKComplicationTemplateCircularSmallStackImage()
            tmp.line1ImageProvider = image(of: .circularSmall)!
            tmp.line2TextProvider = dateText()
            entry = CLKComplicationTimelineEntry(date: now, complicationTemplate: tmp)
        default:
            break
        }
        
        // Pass the timeline entry back to ClockKit.
        handler(entry)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Sample Templates
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // 1. Extension Target 中 Assets 是用来在 iPhone 上来占位显示的，也是 Watch App 的占位图
        // 2. 如果 sample template 方法返回的不为 nil，则使用返回值作为在 Watch 上的占位使用，iPhone 上的占位不会变化
        // 3. 每次安装 Watch App 时的才会调用，调用结果会被缓存下来。
        // 4. 如果通过 get current 方法返回的 entry 不为 nil，则使用返回值作为显示，否则由 1、2 逻辑判断占位显示
        guard let image = image(of: complication.family) else { return handler(nil) }
        
        var t: CLKComplicationTemplate?
        
        switch complication.family {
        case .modularSmall:
            let tmp = CLKComplicationTemplateModularSmallSimpleImage()
            tmp.imageProvider = image
            t = tmp
        case .circularSmall:
            let tmp = CLKComplicationTemplateCircularSmallSimpleImage()
            tmp.imageProvider = image
            t = tmp
        default:
            break
        }
        handler(t)
    }
    
    // 把 Placeholder 的图拿过来当 Sample 用
    private func image(of family: CLKComplicationFamily) -> CLKImageProvider? {
        switch family {
        case .circularSmall:
            if let image = UIImage(named: "Complication/Circular") {
                return CLKImageProvider(onePieceImage: image)
            }
        case .modularSmall:
            if let image = UIImage(named: "Complication/Modular") {
                return CLKImageProvider(onePieceImage: image)
            }
        default:
            break
        }
        return nil
    }

    private func dateText() -> CLKTextProvider {
        let pro = CLKTimeTextProvider(date: Date())
        return pro
    }
}
