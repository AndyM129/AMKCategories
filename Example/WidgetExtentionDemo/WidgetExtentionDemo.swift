//
//  WidgetExtentionDemo.swift
//  WidgetExtentionDemo
//
//  Created by 孟昕欣 on 2020/12/11.
//  Copyright © 2020 AndyM129. All rights reserved.
//

import WidgetKit
import SwiftUI

//MARK: - 通用部分: 多Widget组件实现

@main // 组件包这里最多提供 5 个 Widget，也就是最多可以存在 15 个小组件。
struct WidgetExtentionDemo: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        WidgetExtentionDemo_1()
        WidgetExtentionDemo_2()
        WidgetExtentionDemo_3()
        WidgetExtentionDemo_4()
    }
}

struct WidgetExtentionDemo_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtentionDemoEntryView_1(entry: SimpleEntry(date: Date(), text: UserDefaults(suiteName: "group.io.github.andym129.AMKCategories")?.string(forKey: "widget") ?? ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

//MARK: - 示例 1: 时间文本

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: UserDefaults(suiteName: "group.io.github.andym129.AMKCategories")?.string(forKey: "widget") ?? "")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), text: UserDefaults(suiteName: "group.io.github.andym129.AMKCategories")?.string(forKey: "widget") ?? "")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), text: UserDefaults(suiteName: "group.io.github.andym129.AMKCategories")?.string(forKey: "widget") ?? "")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct WidgetExtentionDemoEntryView_1 : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct WidgetExtentionDemo_1: Widget {
    let kind: String = "WidgetExtentionDemo_1"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView_1(entry: entry)
        }
        .configurationDisplayName("Example")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//MARK: - 示例 2: 针对不同尺寸的 Widget 设置不同的 View

struct WidgetExtentionDemoEntryView_2 : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family // 尺寸环境变量
    
    @ViewBuilder
    var body: some View {
        Text(entry.date, style: .time)
        Text(entry.text)
        
        switch family {
        case .systemSmall: // 小尺寸
            Text(verbatim: "小尺寸")
        case .systemMedium: // 中尺寸
            Text(verbatim: "中尺寸")
        default: // 大尺寸
            Text(verbatim: "大尺寸")
        }
    }
}

struct WidgetExtentionDemo_2: Widget {
    let kind: String = "WidgetExtentionDemo_2"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView_2(entry: entry)
        }
        .configurationDisplayName("定制UI")
        .description("针对不同尺寸的 Widget 设置不同的 View")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//MARK: - 示例 3: supportedFamilies

struct WidgetExtentionDemoEntryView_3 : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Image("拍照搜题")
                .resizable()
                .frame(minWidth: 169, maxWidth: .infinity, minHeight: 169, maxHeight: .infinity, alignment: .center)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
        }
        .widgetURL(URL(string: "amkcategories://categories.andym129.github.io?func=photo_search"))
    }
}

struct WidgetExtentionDemo_3: Widget {
    let kind: String = "WidgetExtentionDemo_3"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView_3(entry: entry)
        }
        .configurationDisplayName("文库大学生版")
        .description("搜题快人一步，轻松解决问题")
        .supportedFamilies([.systemSmall])
    }
}

//MARK: - 示例 4: 金刚位

struct WidgetExtentionDemoEntryView_4 : View {
    var entry: Provider.Entry
    var imageSize = CGSize(width: 70, height: 70)
    var title = Font.subheadline
    var titleOffsetY :CGFloat = -5
    
    var body: some View {
        HStack{
            Spacer()
            Link(destination: URL(string: "amkcategories://categories.andym129.github.io?func=sign&title=签到打卡".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!){
                VStack{
                    Image("wkn_online_topitem_sign")
                        .resizable()
                        .frame(maxWidth: imageSize.width, maxHeight: imageSize.height, alignment: .center)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    
                    Text("签到打卡").font(.subheadline).offset(y: titleOffsetY)
                }
            }
            Spacer()
            Link(destination: URL(string: "amkcategories://categories.andym129.github.io?func=scan&title=扫扫看看".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!){
                VStack{
                    Image("wkn_online_topitem_scan")
                        .resizable()
                        .frame(maxWidth: imageSize.width, maxHeight: imageSize.height, alignment: .center)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    Text("扫扫看看").font(.subheadline).offset(y: titleOffsetY)
                }
            }
            Spacer()
            Link(destination: URL(string: "amkcategories://categories.andym129.github.io?func=vip&title=文库会员".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!){
                VStack{
                    Image("wkn_online_topitem_vip")
                        .resizable()
                        .frame(maxWidth: imageSize.width, maxHeight: imageSize.height, alignment: .center)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                    Text("文库会员").font(.subheadline).offset(y: titleOffsetY)
                }
            }
            Spacer()
        }
    }
}

struct WidgetExtentionDemo_4: Widget {
    let kind: String = "WidgetExtentionDemo_4"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView_4(entry: entry)
        }
        .configurationDisplayName("百度文库")
        .description("专业权威资料库")
        .supportedFamilies([.systemMedium])
    }
}
