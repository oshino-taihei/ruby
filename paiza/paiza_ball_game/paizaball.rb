line = gets.chomp.split(" ")
frame_num = line[0].to_i
pin_num = line[1].to_i
ball_num = line[2].to_i
game = gets.chomp.gsub("G", "0").split(" ").map(&:to_i)

total_score = 0
frame_score = 0
frame = 0
frame_index = 0
0.upto(ball_num - 1) { |i|
	frame += 1
	frame_score += game[i]
	# check strike
	if frame == 1 && frame_score == pin_num then
		frame_score += game[i+1] if i+1 < ball_num
		frame_score += game[i+2] if i+2 < ball_num
		next_frame = true
	# check spare
	elsif frame == 2 && frame_score == pin_num then
		frame_score += game[i+1] if i+1 < ball_num
		if i != ball_num - 2 then
			next_frame = true
		end
	end

	# check last frame
	next_frame = true if i == ball_num - 1

	# check next frame
	if (frame % 2 == 0 && i != ball_num - 1) || next_frame then
		total_score += frame_score
		frame_score = 0
		frame = 0
		frame_index += 1
	end

}
puts total_score