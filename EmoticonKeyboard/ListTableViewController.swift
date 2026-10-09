import SwiftUI
import UIKit

enum EmoticonLibrary {
    static let all = [
        "¯\\_(ツ)_/¯",
        "(งಠ_ಠ)ง",
        "(╯°益°)╯彡┻━┻",
        "(ヘ＿　＿)ヘ",
        "[ ± _ ± ]",
        "( ͡° ͜ʖ ͡°)",
        "(͡° ͜ʖ ͡°)",
        "ಠ_ಠ",
        "٩(͡๏̯͡๏)۶",
        "(⊙_☉)",
        "(っ- ‸ – ς)",
        "(∪｡∪)｡｡｡zzz",
        "＼(◎o◎)／",
        "┗(°0°)┛",
        "(-_ゞ",
        "(◑́_◑᷅ )",
        "u_u",
        "(◕‿◕)",
        "＼(＾▽＾)／",
        "(ノ*ﾟ▽ﾟ*)",
        "(￢_￢)",
        "(¬‿¬ )",
        "(⊙_⊙)",
        "(・▽・)/♫•*¨*•.¸¸♪",
        "(￣^￣)ゞ",
        "(　･ω･)☞",
        "╭∩╮(Ο_Ο)╭∩╮",
        "🖕",
        "▄︻̷̿┻̿═━一",
        "༼ つ ◕_◕ ༽つ",
        "(づ￣ ³￣)づ",
        "[̲̅$̲̅(̲̅5̲̅)̲̅$̲̅]",
        "ʕ•ᴥ•ʔ",
        "(▀̿Ĺ̯▀̿ ̿)",
        "(ಥ﹏ಥ)",
        "(☞ﾟヮﾟ)☞ ☜(ﾟヮﾟ☜)",
        "┬┴┬┴┤(･_├┬┴┬┴",
        "ᕙ( ︡'︡益'︠)ง",
        "ᕙ(⇀‸↼‶)ᕗ",
        "ヽ(⌐▀̿_▀̿)ノ♪♬"
    ]
}

struct EmoticonListView: View {
    var body: some View {
        List(EmoticonLibrary.all, id: \.self) { emoticon in
            Button {
                UIPasteboard.general.string = emoticon
            } label: {
                Text(emoticon)
                    .foregroundStyle(.primary)
            }
        }
        .navigationTitle("Tap an Emoji to Copy It")
    }
}
