coins = [1, 5, 10, 50, 100, 500]
v = 1280

# 貪欲法
def count_coin(coins, v)
  # 結果ハッシュ初期化
  # 結果ハッシュ: [<硬貨の種類>: <枚数>]
  ret = Hash.new
  coins.each do |c|
    ret[c.to_s.to_sym] = 0
  end

  balance = v
  sorted_coints = coins.sort
  current_coin = sorted_coints.pop
  while balance > 0 do
    if (balance >= current_coin) then
      balance -= current_coin
      ret[current_coin.to_s.to_sym] += 1
    else
      current_coin = sorted_coints.pop
    end
  end

  return ret
end

ret = count_coin(coins, v)
puts "Total: #{v}"
puts "Coins: #{coins}"
puts "Result: #{ret}"
