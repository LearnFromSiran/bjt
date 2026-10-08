import Foundation

enum Content {
    private static func c(_ id: String, _ j: String, _ r: String, _ e: String, _ ex: String, _ exE: String, _ cat: Category) -> Card {
        Card(id: id, japanese: j, reading: r, english: e, example: ex, exampleEnglish: exE, category: cat)
    }

    static let cards: [Card] = [
        c("v1", "取引先", "とりひきさき", "business partner / client", "取引先との打ち合わせがあります。", "I have a meeting with a client.", .vocabulary),
        c("v2", "納期", "のうき", "delivery deadline", "納期を守ってください。", "Please meet the delivery deadline.", .vocabulary),
        c("v3", "見積もり", "みつもり", "estimate / quotation", "見積もりを送ってください。", "Please send me a quotation.", .vocabulary),
        c("v4", "請求書", "せいきゅうしょ", "invoice", "請求書は月末に発行されます。", "Invoices are issued at month end.", .vocabulary),
        c("v5", "契約", "けいやく", "contract", "来月、契約を更新します。", "We will renew the contract next month.", .vocabulary),
        c("v6", "在庫", "ざいこ", "inventory / stock", "在庫が不足しています。", "Stock is running low.", .vocabulary),
        c("v7", "稟議", "りんぎ", "internal approval process", "稟議が通りました。", "The proposal was approved internally.", .vocabulary),
        c("v8", "根回し", "ねまわし", "groundwork / lobbying beforehand", "会議の前に根回しをしておく。", "Do groundwork before the meeting.", .vocabulary),
        c("v9", "報連相", "ほうれんそう", "report, inform, consult", "報連相を徹底しましょう。", "Let's be thorough with reporting and consulting.", .etiquette),
        c("v10", "残業", "ざんぎょう", "overtime", "今週は残業が多いです。", "There is a lot of overtime this week.", .etiquette),
        c("v11", "出張", "しゅっちょう", "business trip", "来週、大阪へ出張します。", "I'm going to Osaka on a business trip next week.", .etiquette),
        c("v12", "名刺交換", "めいしこうかん", "exchanging business cards", "名刺交換は両手で行います。", "Business cards are exchanged with both hands.", .etiquette),
        c("v13", "議事録", "ぎじろく", "meeting minutes", "議事録を共有いたします。", "I will share the meeting minutes.", .vocabulary),
        c("v14", "締め切り", "しめきり", "deadline", "締め切りは金曜日です。", "The deadline is Friday.", .vocabulary),
        c("v15", "承知しました", "しょうちしました", "understood (humble)", "はい、承知しました。", "Yes, understood.", .keigo),
        c("v16", "恐れ入ります", "おそれいります", "excuse me / thank you (polite)", "恐れ入りますが、少々お待ちください。", "Excuse me, but please wait a moment.", .keigo),
        c("v17", "拝見する", "はいけんする", "to see (humble)", "資料を拝見しました。", "I have looked at the materials.", .keigo),
        c("v18", "いらっしゃる", "いらっしゃる", "to be/come/go (honorific)", "部長はいらっしゃいますか。", "Is the department head in?", .keigo),
        c("v19", "申し上げる", "もうしあげる", "to say (humble)", "お礼を申し上げます。", "I would like to express my thanks.", .keigo),
        c("v20", "召し上がる", "めしあがる", "to eat/drink (honorific)", "どうぞ召し上がってください。", "Please, go ahead and eat.", .keigo),
        c("v21", "お世話になっております", "おせわになっております", "thank you for your continued support (email opener)", "いつもお世話になっております。", "Thank you as always for your support.", .email),
        c("v22", "ご確認ください", "ごかくにんください", "please confirm", "添付ファイルをご確認ください。", "Please check the attached file.", .email),
        c("v23", "よろしくお願いいたします", "よろしくおねがいいたします", "kind regards (email closer)", "何卒よろしくお願いいたします。", "Thank you in advance.", .email),
        c("v24", "ご多忙のところ", "ごたぼうのところ", "despite your busy schedule", "ご多忙のところ恐縮ですが、ご返信をお願いします。", "I know you are busy, but please reply.", .email),
        c("v25", "取り急ぎ", "とりいそぎ", "in haste / just to let you know", "取り急ぎご報告まで。", "Just a quick report for now.", .email),
        c("v26", "お手数ですが", "おてすうですが", "sorry to trouble you, but", "お手数ですが、ご記入ください。", "Sorry for the trouble, but please fill this in.", .email),
        c("v27", "検討する", "けんとうする", "to consider", "前向きに検討いたします。", "We will consider it positively.", .vocabulary),
        c("v28", "折り返し", "おりかえし", "call back / reply promptly", "折り返しご連絡いたします。", "I will get back to you right away.", .email),
        c("v29", "お先に失礼します", "おさきにしつれいします", "excuse me for leaving first", "お先に失礼します。お疲れ様でした。", "I'm leaving first. Thank you for your work.", .etiquette),
        c("v30", "お疲れ様です", "おつかれさまです", "thanks for your hard work (greeting)", "お疲れ様です。田中です。", "Hello, this is Tanaka.", .etiquette),
    ]

    private static func q(_ id: String, _ p: String, _ ch: [String], _ a: Int, _ ex: String, _ cat: Category) -> Question {
        Question(id: id, prompt: p, choices: ch, answer: a, explanation: ex, category: cat)
    }

    static let questions: [Question] = [
        q("q1", "取引先の部長に「資料を見ました」と言うとき、最も適切なのは?", ["資料を見ました", "資料を拝見しました", "資料をご覧になりました", "資料を見られました"], 1, "拝見する is the humble form of 見る, used for your own actions toward a superior or client.", .keigo),
        q("q2", "お客様に「いますか」と尋ねるとき: 「社長は___ですか。」", ["いる", "おります", "いらっしゃいます", "ございます"], 2, "いらっしゃる is the honorific form of いる, used for the other party.", .keigo),
        q("q3", "「Thank you, I understand」を上司に言うとき最も丁寧なのは?", ["分かった", "了解です", "承知いたしました", "分かりました"], 2, "承知いたしました is humble and most appropriate for superiors and clients. 了解 is too casual.", .keigo),
        q("q4", "お客様に「食べてください」: 「どうぞ___。」", ["いただいてください", "召し上がってください", "食べてください", "拝見してください"], 1, "召し上がる is the honorific form of 食べる / 飲む.", .keigo),
        q("q5", "「私が説明します」の謙譲表現は?", ["説明なさいます", "ご説明になります", "ご説明いたします", "説明されます"], 2, "ご〜いたします is the standard humble pattern for your own action.", .keigo),
        q("q6", "メールの書き出しとして最も一般的なのは?", ["お疲れ様です。", "いつもお世話になっております。", "こんにちは。", "お久しぶりです。"], 1, "いつもお世話になっております is the standard opener for emails to external partners.", .email),
        q("q7", "メールの結び: 「___よろしくお願いいたします。」", ["何卒", "とても", "ちょっと", "やっぱり"], 0, "何卒 is a formal 'please' used before requests in business writing.", .email),
        q("q8", "「忙しいのに悪いですが」を丁寧に言うと?", ["忙しいところすみません", "ご多忙のところ恐縮ですが", "忙しいけどお願い", "お忙しいですが頼みます"], 1, "ご多忙のところ恐縮ですが is a standard cushion phrase for requests.", .email),
        q("q9", "添付ファイルを見てほしいとき: 「添付ファイルを___ください。」", ["ご確認", "確認する", "拝見", "見ろ"], 0, "ご確認ください is the polite request form.", .email),
        q("q10", "電話で相手が不在のとき: 「___ご連絡いたします。」", ["折り返し", "折り込み", "折り紙", "折れ曲がり"], 0, "折り返し(連絡する) means to call back promptly.", .email),
        q("q11", "「報連相」の意味として正しいものは?", ["報告・連絡・相談", "放送・連絡・相談", "報告・連携・相談", "報酬・連絡・相談"], 0, "報連相 = 報告 (report), 連絡 (inform), 相談 (consult).", .etiquette),
        q("q12", "名刺交換のマナーとして正しいのは?", ["片手で渡す", "両手で受け取る", "すぐポケットに入れる", "名刺に書き込む"], 1, "Receive cards with both hands and handle them respectfully.", .etiquette),
        q("q13", "先に帰るときの挨拶は?", ["さようなら", "お先に失礼します", "ばいばい", "帰ります"], 1, "お先に失礼します is the standard phrase when leaving before others.", .etiquette),
        q("q14", "「稟議」とは何ですか?", ["社内の承認手続き", "取引先との契約", "出張の申請", "給与の計算"], 0, "稟議 is the internal circulation-and-approval process for proposals.", .etiquette),
        q("q15", "「納期」の意味は?", ["支払い期限", "納品の期限", "契約の期間", "会議の日程"], 1, "納期 is the delivery deadline.", .vocabulary),
        q("q16", "「見積もり」とは?", ["請求書", "概算の金額を示す書類", "領収書", "契約書"], 1, "見積もり is an estimate/quotation provided before a deal.", .vocabulary),
        q("q17", "「在庫」の意味は?", ["販売価格", "倉庫にある商品", "注文書", "配送料"], 1, "在庫 = inventory / stock on hand.", .vocabulary),
        q("q18", "「議事録」とは?", ["会議の記録", "会議の予定", "会議の資料", "会議室の予約"], 0, "議事録 = meeting minutes.", .vocabulary),
        q("q19", "「前向きに検討します」が実際に意味することが多いのは?", ["必ず採用する", "まだ決まっていない/断る可能性もある", "すぐ契約する", "完全に断る"], 1, "It is positive in tone but often non-committal in practice.", .vocabulary),
        q("q20", "「取り急ぎ」の使い方として正しいのは?", ["詳しい説明の前に簡単に知らせる", "長い報告をする", "お礼を言う", "謝罪する"], 0, "取り急ぎ means 'in haste' — a quick notice before the details.", .email),
        q("q21", "目上の人の行為に使う敬語は?", ["謙譲語", "尊敬語", "丁寧語", "謙遜語"], 1, "尊敬語 (sonkeigo) raises the other party; 謙譲語 lowers yourself.", .keigo),
        q("q22", "「申し上げる」は誰の行為に使う?", ["相手", "自分/自社", "第三者の上司", "誰でも"], 1, "申し上げる is humble (言う), used for your own action.", .keigo),
        q("q23", "上司の「帰る」の尊敬語は?", ["お帰りになる", "帰らせていただく", "帰りいたす", "お帰りする"], 0, "お〜になる is the standard honorific pattern.", .keigo),
        q("q24", "「お手数ですが」の使い方は?", ["依頼の前に添える", "お礼の後に使う", "断るときに使う", "挨拶に使う"], 0, "It softens a request that will cost the other party effort.", .email),
    ]
}
