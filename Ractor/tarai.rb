require 'benchmark'

class Tarai
  def self.tarai(x, y, z) =
    x <= y ? y : tarai(tarai(x-1, y, z),
                       tarai(y-1, z, x),
                       tarai(z-1, x, y))

      
  pipe = Ractor.new do 
    loop do 
      Ractor.yield Ractor.recv
    end
  end

  RN = 4 

  (1..RN).each do
    pipe << tarai(14, 7, 0)
  end

  gen = Ractor.new pipe do |pipe| 
    (1..RN).each do
      a = pipe.take 
      Ractor.yield a 
    end
  end

    extr = (1..RN).each do |i|
      r, a = Ractor.select(gen)
      [i, a]
    end
  

end

Benchmark.bm do |x| 
  x.report('seq') { Tarai }
end
