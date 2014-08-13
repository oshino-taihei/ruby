$N = 6
$S = "ACDBCB"

def min_str
  t = ""
  while $S.size > 0 do
    thead = t + $S.slice(0)
    tbottom = t + $S.slice(-1)
    if thead < tbottom then
      t = thead
      $S.slice!(0)
    else
      t = tbottom
      $S.slice!(-1)
    end
  end
  
  return t
end

ret = min_str
puts ret
