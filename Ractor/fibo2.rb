require 'benchmark'

N = 10000

def fib 
  i = 0
  a, b = 0, 1
  (1..N).each {
    i += 1
    a, b = b, a+b
    # p "[#{i}, #{a}]"
  }
end

Benchmark.bm do |x|
  x.report('seq:') { fib }
end

#fibo
