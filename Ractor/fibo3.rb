require 'benchmark'

class Fibo
  # initializer 
  # pipe, m項を初期化した。
  def initialize(m)
    @n = m
    @pipe = Ractor.new do 
      loop do 
        Ractor.yield Ractor.recv
      end
    end
  end

  def fib 
    # Fibonacci calculating routine
    @@a, @@b = 0, 1
    (1..@n).each do 
      @@a, @@b = @@b, @@a+@@b
      @pipe << @@a
    end
  
    # Fibonacci generator: Fibonacci数列を生成 
    gen =  Ractor.new @pipe do |pipe|
      (1..@n).each do 
        x = pipe.take 
        Ractor.yield x
      end
    end

    # Fibonacci extractor: Fibonacci数列を抽出
    # Ractor objectを捨てる。
    extr = (1..@n).map do |i|
      r, x = Ractor.select(gen)
      [i, x]
    end

  end

end

# N などの定数を利用するよりも遅くなったけど... 一応できた。
Benchmark.bm do |x|
  x.report('par') {
    fibo = Fibo.new(10000)
    fibo.fib
  }
end

"""  
fibo = Fibo.new(10000)
(fibo.fib).each do |ary|
  p ary
end
"""
