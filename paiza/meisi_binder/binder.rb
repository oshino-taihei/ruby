line = gets.chomp.split(" ")
pocketnum = line[0].to_i
card = line[1].to_i

# solve page number
page = (card / (pocketnum * 2))
page += 1 unless (card % (pocketnum * 2)) == 0

# solve sum
sum = 2 * (2 * page - 1) * pocketnum + 1

# solve
ans = sum - card

puts ans