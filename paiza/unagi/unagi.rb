# -- coding: utf-8
line = gets.chomp.split(" ")
max_seats = line[0].to_i
group_num = line[1].to_i

# 座席シート配列: nilなら空席、trueなら座っている
seats = Array.new(max_seats)
group_num.times {
  line = gets.chomp.split(" ")
  member_num = line[0].to_i
  position = line[1].to_i

  # シートに人数分座れるかどうか確認
  sittable = true
  member_num.times { |i|
    if seats[(position + i) % max_seats] then
      sittable = false
      break
    end
  }
  # 座れるならば、座る
  if sittable then
    member_num.times { |i|
      seats[(position + i) % max_seats] = true
    }
  end
    
}

# trueの数が座っている人の数
p seats.count(true)


