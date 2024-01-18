default_date = DateTime.now.ago(3.days)
year = default_date.year.to_i
month = default_date.month.to_i

0.upto(19) do |idx|
    0.upto(13) do |days|
        #初期データは9時開業の12時間営業
        day = default_date.since(days.days).day.to_i
        start = DateTime.new(year,month,day,9,0,0)
        0.upto(23) do|minute|
            Shift.create!(
                stylist_id: idx + 1,
                date_time: start.since(30.minutes*minute)
            )
        end
    end
end


