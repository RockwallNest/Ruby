# message digestのHashの作成とFibonacci数列生成を
# 並列実行するコードを作成

require 'digest/sha2'

# module pipeを生成
module Pipe
    @@pipe = Ractor.new do
      loop do 
        Ractor.yield Ractor.recv
      end
    end
    N = 3
    M = 10
end

# Hashを作成
# クラスInitを継承
# Pipeが継承される
class HashDigest

  include Pipe 
  # hash_generator: Hashを生成　
  def hash_gen 
    # message digestを生成　
    ["Good", "Soso", "Not Good"].each do |str|
      digest = Digest::SHA2.new
      @@pipe << digest.hexdigest(str)
    end
   
    # generator: Racator objとして値Chを生成
    genHd = Ractor.new @@pipe do |pipe|
      (1..N).each do 
        hd = pipe.take
        Ractor.yield hd
      end
    end

    # extractor: 配列として値hdを抽出
    extrHd = ["Alice", "Bob", "Chris"].map do |name|
      r, hd = Ractor.select(*genHd)
      [name, hd]
    end

    # Hashを生成
    extrHd.each do |ary|
      Hash[*ary]
    end
  end
end

# Fibonacci数列を生成
# Pipeが継承される
class Fibo 
  include Pipe

  def fib
    @@a, @@b = 0, 1
    (1..M).each do 
      @@a, @@b = @@b, @@a + @@b
      @@pipe << @@a 
    end

    # generator Ractor obj として配列を生成
    genF = Ractor.new @@pipe do |pipe|
      (1..M).each do 
        f = pipe.take
        Ractor.yield f 
      end
    end

    # extractor 配列として値fを抽出
    extrF = (1..M).map do |i|
      r, f = Ractor.select(*genF)
      [i, f]
    end
  end

end


# 配列からHash値{key => value}を抽出
hd = HashDigest.new
(hd.hash_gen).each do |ary|
  p ary
end

# 配列からFibonacci数列を生成
fibo = Fibo.new 
(fibo.fib).each do |f|
  p f
end
