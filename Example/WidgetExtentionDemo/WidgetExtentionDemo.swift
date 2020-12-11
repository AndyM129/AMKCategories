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

@main
struct WidgetExtentionDemo: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        WidgetExtentionDemo_1()
        WidgetExtentionDemo_2()
        WidgetExtentionDemo_3()
    }
}

struct WidgetExtentionDemo_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtentionDemoEntryView_1(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

//MARK: - 示例 1: 时间文本

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
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
        .configurationDisplayName("时间组件")
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
        switch family {
        case .systemSmall: // 小尺寸
            Text(entry.date, style: .time)
            Text(verbatim: "小尺寸")
        case .systemMedium: // 中尺寸
            Text(entry.date, style: .time)
            Text(verbatim: "中尺寸")
        default: // 大尺寸
            Text(entry.date, style: .time)
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
        .configurationDisplayName("时间组件")
        .description("This is an example widget.")
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
    }
}

struct WidgetExtentionDemo_3: Widget {
    let kind: String = "WidgetExtentionDemo_3"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView_3(entry: entry)
        }
        .configurationDisplayName("拍照搜题")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}
