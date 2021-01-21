# Ruby
自作rubyのプログラムなど、Ractorの探索など。

# Abstract
### RactorをつかったFibonacci数列を掃き出すプログラムを作成
fibo1.rb, fibo2.rb, fibo3.rb <br />
### Ractorを使った、Hash作成とFibonacci数列生成を並列実行するプログラムを作成
concurrency.rb <br />

### characteristics
pipe というRactorで作成したチャンネルを用いて、コードブロック同志を結びつけます。<br />
###### pipe 作成例
```ruby
pipe = Ractor.new do
  loop do 
     Ractor.yield Ractor.recv
  end
end
```
このpipeチャンネルを用いて、メソッド間、クラス間のコードブロックを結びつけ、<br />
並列実行を行うようにコードを設計しました。<br />
###### 引用
[Ractor - Ruby's Actor-like concurrent abstraction　より](https://docs.ruby-lang.org/en/master/doc/ractor_md.html)


# Report
fibo1.rb, fibo2.rb <br />
Ractorを使ったプログラムは、使ってないプログラムより、<br />
Ractorを使わないプログラムだと、時間が1190倍余計にかかります... <br />
クラスメソッドを用いたプログラムfibo3.rbも追加しました。<br />
pipeをinitializerにして、メソッド間で共有できた。 <br/>
Ractorを用いないものより、すごく遅いですが... <br />
concurrency.rb <br />
pipeをモジュール化したのが通ったので、ほっとした。<br />
class同士の間でpipe共有ができるので、実行がはやくなったかな...　<br />
fib(n)関数をRactorで処理してFibonacci数列を生成するコードを書いた。fibo4.rb <br />
benchmarkは速いが、実際は遅い。<br />
竹内関数を処理するpipeを用いたコードを書いた。意外に速かった。<br />
引用：[ruby-lang.org Ruby 3.0.0 リリース　より](https://www.ruby-lang.org/ja/news/2020/12/25/ruby-3-0-0-released/)

# Requirement 
ruby 3.0.0p0 [x86_64-darwin20]
で動作確認済み。

# Usage 
```
$ git clone https://github.com/RockwallNest/Ruby-.git 
$ cd Ruby/Ractor/ 
```
- ##### fibo1.rbを実行
```
$ ruby fibo1.rb 
```
- ##### fibo2.rbを実行
```
$ ruby fibo2.rb 
```
(※)fibo1.rbのコメントアウトを除けば、Fibonacci数列を10000項まで表示できます。

# Benchmark result
### fibo1.rb
|     |   user   |  system  |   total  |     real     | 
|:---:|  :---:   |  :---:   |  :---:   |    :---:     |
| par | 0.000009 | 0.000004 | 0.000013 | (  0.000005) |

### fibo2.rb
|     |  user    |  system  |   total  |     real     |
|:---:|  :---:   |  :---:   |   :---:  |     :---:    |
| seq | 0.005141 | 0.000727 | 0.005868 | (  0.005866) |

### fibo3.rb
|     |  user     |  system  |  total   |    real      |
|:---:|  :---:    |  :---:   |  :---:   |    :---:     |
| par | 0.083409  | 0.076613 | 0.160022 | (  0.091872) |

### fibo4.rb

|     |  user     |  system  |   total  |    real      |
|:---:|  :---:    |  :---:   |  :---:   |   :---:      |
| par | 0.000008  | 0.000004 | 0.000012 | (  0.000004) |

### tarai.rb
|     |  user     |  system  |   total  |    real      |
|:---:|  :---:    |  :---:   |   :---:  |   :---:      |
| par | 0.000007  | 0.000003 | 0.000010 | (  0.000004) |

# Copyright
Copyright &copy; 2020 RockwallNest. This software is released under the MIT License. <br>

