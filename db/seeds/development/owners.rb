names = %w(Taro2 Jiro2 Hana2 John2 Mike2 Sophy2 Bill2 Alex2 Mary2 Tom2)
fnames = ["伊藤", "渡辺", "山本","中村"]
gnames = ["たろう", "じろう", "はなこ"]

0.upto(9) do |idx|
    Owner.create(
        salon_id: idx+1,                                      #外部キー
        name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",      #名前
        email: "#{names[idx]}@example.com",                 #メールアドレス
        phone: "090-98#{idx}-12#{idx}",                     #電話番号
        sex: [1, 1, 2][idx % 3],                            #性別
        birthday: "1981-12-01"                              #生年月日
    )
end
