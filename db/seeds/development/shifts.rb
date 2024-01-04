#この変数はreservation_newビューでも用いた。
start = DateTime.new(2024,1,7,0,0,0)

0.upto(9) do |idx|
    0.upto(14*48) do |time|
        Shift.create!(
            stylist_id: idx + 1,
            reservation_id: 1,
            date_time: start.since(30.minutes*time)
        )
    end
end


