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
  @@a, @@b = 0, 1
  (1..N).each do 
    @@a, @@b = @@b, @@a + @@b
    pipe << @@a
  end

  # routine2: generator
  gen = Ractor.new pipe do |pipe|
    (1..N).each do
      n = pipe.take
      Ractor.yield n
    end
  end

  # routine3: extractor
  extr = (1..N).map {|i|
    r, n = Ractor.select(gen)
    [i, n]
  }.sort_by{|i, n| n}

  # p extr

end

Benchmark.bm do |x|
  x.report('seq') { Fibo }
end

#Fibo

# Ractorの並列処理の図解です。
#
#  routine1:fibo                     routine2: generator       routine3: extractor
# ----------------      channel      -------------------      -------------------- 
# | fibo routine | --->  pipe   ---> |  generator      | ---> |----------------->| ----> output n 
# ----------------                   -------------------      | |                |
#                                                             | --> ractor obj r |
#                                                             --------------------
#
