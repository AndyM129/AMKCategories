//
//  WidgetExtentionDemo.swift
//  WidgetExtentionDemo
//
//  Created by 孟昕欣 on 2020/12/11.
//  Copyright © 2020 AndyM129. All rights reserved.
//

import WidgetKit
import SwiftUI

// 切换生效的代码
let WidgetExtentionDemoEntryView = WidgetExtentionDemoEntryView_2.self

//MARK: - 通用部分

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

struct SimpleEntry: TimelineEntry {
    let date: Date
}

@main
struct WidgetExtentionDemo: Widget {
    let kind: String = "WidgetExtentionDemo"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtentionDemoEntryView.init(entry: entry)
        }
        .configurationDisplayName("AMKCategories")
        .description("This is an example widget.")
    }
}

struct WidgetExtentionDemo_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtentionDemoEntryView.init(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

//MARK: - 示例 1: 文本

struct WidgetExtentionDemoEntryView_1 : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
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
            ZStack{
                Image("拍照搜题")
                    .resizable()
                    .frame(minWidth: 169, maxWidth: .infinity, minHeight: 169, maxHeight: .infinity, alignment: .center)
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                //Text("")
                //    .foregroundColor(Color.white)
                //    .lineLimit(4)
                //    .font(.system(size: 14))
                //    .padding(.horizontal)
            }
            .widgetURL(URL(string: "跳转链接"))
        case .systemMedium: // 中尺寸
            Text(entry.date, style: .time)
            Text(verbatim: "中尺寸")
        default: // 大尺寸
            Text(entry.date, style: .time)
            Text(verbatim: "大尺寸")
        }
    }
}
