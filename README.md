# Ruby
自作rubyのプログラムなど

## RactorをつかったFibonacciプログラムを作成
Ractorを使ったプログラムは、使ってないプログラムより、<br />
Ractorを使わないプログラムだと、時間が1140倍余計にかかります...<br />

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


# Copyright
Copyright &copy; 2020 RockwallNest. This software is released under the MIT License. <br>

