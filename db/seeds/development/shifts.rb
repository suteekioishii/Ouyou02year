0.upto(9) do |idx|
    0.upto(13) do |days|
        #初期データは9時開業の12時間営業
        start = DateTime.new(2024,1,7+days,9,0,0)
        0.upto(23) do|minute|
            Shift.create!(
                stylist_id: idx + 1,
                date_time: start.since(30.minutes*minute)
            )
        end
    end
end


