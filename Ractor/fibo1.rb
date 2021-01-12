require 'benchmark'

class Fibo 
  N = 10000

  # channel
  pipe = Ractor.new do 
    loop do 
      Ractor.yield Ractor.recv
    end
  end

  # routine1
  $a, $b = 0, 1
  (1..N).each do 
    $a, $b = $b, $a+$b
    pipe << $a
  end

  # routine2
  workers = Ractor.new pipe do |pipe|
    (1..N).each do
      n = pipe.take
      Ractor.yield n
    end
  end

  # routine3
  *sequence = (1..N).map {|i|
    r, n = Ractor.select(*workers)
    [i, n]
  }.sort_by{|i, n| n}

  # p *sequence

end

Benchmark.bm do |x|
  x.report('seq') { Fibo }
end

# Fibo

# Ractor並列処理の図解です。 私見ですが...
#
#  routine1                           routine2              routine3
# ----------------                   ----------------      ------------------ 
# | fibo routine | ---> channel ---> | take routine | ---> | select routine | ---> output
# ----------------                   ----------------      ------------------
#
# 通常のFibo関数の約1140倍の処理速度です｡
