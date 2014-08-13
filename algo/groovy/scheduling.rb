$n = 5
$s = [1, 2, 4, 6, 8]
$t = [3, 5, 7, 9, 10]

def schedule
  # 仕事をペアにし、終了時間でソート
  tasks = []
  0.upto($n - 1) {|i|
    tasks.push([$s[i],$t[i]])
  }
  tasks.sort! { |a,b| a[1] <=> b[1] }

  # 最終時間の早いものを選択
  time = 0
  ans = []
  0.upto($n - 1) {|i|
    starttime = tasks[i][0]
    endtime = tasks[i][1]
    if time <= starttime then
      ans.push(tasks[i])
      time = endtime
    end
  }
  return ans  
end

tasks = schedule
p tasks.size
