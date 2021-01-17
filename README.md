# Ruby
自作rubyのプログラムなど、Ractorの探索など。

# Abstract
### RactorをつかったFibonacci数列を掃き出すプログラムを作成
fibo1.rb, fibo2.rb, fibo3.rb <br />
### Ractorを使った、Hash作成とFibonacci数列生成を並列実行するプログラムを作成
concurrency.rb <br />

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

# Requirement 
ruby 3.0.0p0 [x86_64-darwin20]
で動作確認済み。

# Usage 
$ git clone https://github.com/RockwallNest/Ruby-.git <br />
$ cd Ruby/Ractor/ <br />
- ##### fibo1.rbを実行
$ ruby fibo1.rb <br />
- ##### fibo2.rbを実行
$ ruby fibo2.rb <br />

(※)fibo1.rbのコメントアウトを除けば、Fibonacci数列を10000項まで表示できます。

# Benchmark result
### fibo1.rb
|     |   user   |  system  |   total  |     real     | 
|---  |---       |---       |---       |---           |
| seq | 0.000009 | 0.000004 | 0.000013 | (  0.000005) |

### fibo2.rb
|     |  user    |  system  |   total  |     real     |
|---  |---       |---       |---       |---           |
| seq | 0.005141 | 0.000727 | 0.005868 | (  0.005866) |

### fibo3.rb
|     |  user     |  system  |  total   |    real      |
|---  |---        |---       |---       |---           |
| seq | 0.083409  | 0.076613 | 0.160022 | (  0.091872) |

# Copyright
Copyright &copy; 2020 RockwallNest. This software is released under the MIT License. <br>

