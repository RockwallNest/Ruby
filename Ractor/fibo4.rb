require 'benchmark'

class Fibo 
  def self.fib(n)  
     a, b = 0, 1
    if n < 2 
      1
    else
      (1..n).each do
        a, b = b, a + b
      end
      a
    end
  end

 pipe = Ractor.new do 
   loop do 
     Ractor.yield Ractor.recv 
   end
 end

 RN = 10000 

 (1..RN).each do |i|
   a = fib(i)
   pipe << a
 end

 gen = Ractor.new pipe do |pipe|
   (1..RN).each do
     x = pipe.take  
     Ractor.yield x
   end
 end 

 extr = (1..RN).each do |i|
   r, x = Ractor.select(*gen)
   [i, x] 
   # [i, x]の代わりに実行するとFibonacci数列を表示
   # p [i, x] 
 end

end 

Benchmark.bm do |x|
  x.report('par') {
    Fibo
  }
end

# Fibonacci数列表示用
# Fibo 
