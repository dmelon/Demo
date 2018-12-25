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
        let t = template(for: complication.family)
        let entry = t.flatMap({
            CLKComplicationTimelineEntry(date: Date(), complicationTemplate: $0)
        })
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
        print("return template for \(complication.family)")
        handler(template(for: complication.family))
    }
    
    private func template(for family: CLKComplicationFamily) -> CLKComplicationTemplate? {
        
        let image = family.assetImage()
        print("image for family \(family.assetName), size: \(image.size)")

//        image = UIImage.image(with: .red, size: image.size)
        let template: CLKComplicationTemplate
        
        switch family {
        case .circularSmall:
            let tmp = CLKComplicationTemplateCircularSmallSimpleImage()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.tintColor = .red
            template = tmp
        case .extraLarge:
            let tmp = CLKComplicationTemplateExtraLargeSimpleImage()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.tintColor = .orange
            template = tmp
            
        case .modularSmall:
            let tmp = CLKComplicationTemplateModularSmallSimpleImage()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.tintColor = .yellow
            template = tmp
            
        case .modularLarge:
            let tmp = CLKComplicationTemplateModularLargeStandardBody()
            tmp.headerTextProvider = CLKSimpleTextProvider(text: "Header")
            tmp.headerImageProvider = CLKImageProvider(onePieceImage: image)
            tmp.body1TextProvider = CLKSimpleTextProvider(text: "Body 1")
            tmp.body2TextProvider = CLKSimpleTextProvider(text: "Body 2")
            tmp.tintColor = .green
            template = tmp
        case .utilitarianSmall:
            let tmp = CLKComplicationTemplateUtilitarianSmallSquare()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.tintColor = .cyan
            template = tmp
            
        case .utilitarianLarge:
            let tmp = CLKComplicationTemplateUtilitarianLargeFlat()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.textProvider = CLKSimpleTextProvider(text: "U Large")
            tmp.tintColor = .blue
            template = tmp
        case .utilitarianSmallFlat:
            let tmp = CLKComplicationTemplateUtilitarianSmallFlat()
            tmp.imageProvider = CLKImageProvider(onePieceImage: image)
            tmp.textProvider = CLKSimpleTextProvider(text: "U Small Flat")
            tmp.tintColor = .purple
            template = tmp
            
        case .graphicCircular:
            if #available(watchOSApplicationExtension 5.0, *) {
                let tmp = CLKComplicationTemplateGraphicCircularImage()
                tmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                tmp.tintColor = .brown
                template = tmp
            } else {
                fatalError()
            }
        case .graphicCorner:
            if #available(watchOSApplicationExtension 5.0, *) {
                let tmp = CLKComplicationTemplateGraphicCornerCircularImage()
                tmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                tmp.tintColor = .magenta
                template = tmp
            } else {
                fatalError()
            }
        case .graphicBezel:
            if #available(watchOSApplicationExtension 5.0, *) {
                let circularTemplate = CLKComplicationTemplateGraphicCircularImage()
                circularTemplate.imageProvider = CLKFullColorImageProvider(fullColorImage: image)

                let tmp = CLKComplicationTemplateGraphicBezelCircularText()
                tmp.circularTemplate = circularTemplate
                tmp.textProvider = CLKSimpleTextProvider(text: "G Bezel")
                tmp.tintColor = .lightGray
                template = tmp
            } else {
                fatalError()
            }
        case .graphicRectangular:
            if #available(watchOSApplicationExtension 5.0, *) {
                let tmp = CLKComplicationTemplateGraphicRectangularLargeImage()
                tmp.imageProvider = CLKFullColorImageProvider(fullColorImage: image)
                tmp.textProvider = CLKSimpleTextProvider(text: "G Rect")
                tmp.tintColor = .darkGray
                template = tmp
            } else {
                fatalError()
            }
        }
        return template
    }

    private func dateText() -> CLKTextProvider {
        let pro = CLKTimeTextProvider(date: Date())
        return pro
    }
}


extension CLKComplicationFamily {
    
    // Assets 中对应的图片名
    var assetName: String {
        let name: String
        switch self {
        case .circularSmall:
            name = "Circular"
        case .extraLarge:
            name = "Extra Large"
        case .graphicBezel:
            name = "Graphic Bezel"
        case .graphicCorner:
            name = "Graphic Corner"
        case .graphicCircular:
            name = "Graphic Circular"
        case .graphicRectangular:
            name = "Graphic Large Rectangular"
        case .modularSmall, .modularLarge:
            name = "Modular"
        case .utilitarianSmall,
             .utilitarianSmallFlat,
             .utilitarianLarge:
            name = "Utilitarian"
        }
        return "Complication/" + name
    }
    
    // Assets 中对应的图片
    func assetImage() -> UIImage {
        let image = UIImage(named: assetName)
        return image!
    }
}


extension UIImage {
    
    static func image(with color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 2)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return colorImage!
        }
        fatalError()
    }
}

