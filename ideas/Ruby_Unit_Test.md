# Встановлення RSpec

## Встановлення Ruby
First, click on the button below and download the installer for Ruby v2.0.0 that matches your system’s architecture (x86 / x64).

(Get Ruby for Windows)[http://rubyinstaller.org/downloads/]

Execute the installer and go through the steps of the installation. When you get to the screen below, make sure to check the “Add Ruby executables to your PATH” box.

## Встановлення Ruby DevKit

Jekyll has some dependencies which, out of the box, only provide raw source code. To make them into fully functional executables, you’ll probably need to install the Development Kit.

Click the button below and download the DevKit archive that corresponds to your Ruby installation and system architecture. For Ruby v2.0.0, the file name will begin with DevKit-mingw64. Choose the 32bits or 64bits version depending on your system.

(Get the Ruby DevKit)[http://rubyinstaller.org/downloads/]

The download is a self-extracting archive. When you execute the file, it’ll ask you for a destination for the files. Enter a path that has no spaces in it. We recommend something simple, like C:\RubyDevKit\. Click Extract and wait until the process is finished.

Next, you need to initialize the DevKit and bind it to your Ruby installation. Open your favorite command line tool and navigate to the folder you extracted the DevKit into.

```
cd C:\RubyDevKit
```

Auto-detect Ruby installations and add them to a configuration file for the next step.

```
ruby dk.rb init
```

Встановлення the DevKit, binding it to your Ruby installation.

```
ruby dk.rb install
```


## Вирішення проблем при встановленні gem

Встановлення gem з використанням проксі:
```
gem install --http-proxy http://<user>:<password>@wsproxy.alfa.bank.int:3128 ruby-oci8
```

Може виникнути помилка сертифікатів:
```
ERROR:  Could not find a valid gem 'ruby-oci8' (>= 0), here is why:
          Unable to download data from https://rubygems.org/ - SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (https://api.rubygems.org/latest_specs.4.8.gz)
```

Скрипт для скачування сертифікатів (не враховує, що скачування відбувається за проксі):
``` ruby
# win_fetch_cacerts.rb
require 'net/http'

# create a path to the file "C:\Temp\cacert.pem"
cacert_file = File.join(%w{c: Temp cacert.pem})

Net::HTTP.start("curl.haxx.se") do |http|
  resp = http.get("/ca/cacert.pem")
  if resp.code == "200"
    open(cacert_file, "wb") { |file| file.write(resp.body) }
    puts "\n\nA bundle of certificate authorities has been installed to"
    puts "C:\\Temp\\cacert.pem\n"
    puts "* Please set SSL_CERT_FILE in your current command prompt session with:"
    puts "     set SSL_CERT_FILE=C:\\Temp\\cacert.pem"
    puts "* To make this a permanent setting, add it to Environment Variables"
    puts "  under Control Panel -> Advanced -> Environment Variables"
  else
    abort "\n\n>>>> A cacert.pem bundle could not be downloaded."
  end
end
```
Можна просто з браузера скачати сертифікат https://curl.haxx.se/ca/cacert.pem, записати його в якийсь каталог і прописати збережений файл в змінну оточення ОС SSL_CERT_FILE

А тоді знову спробувати поставити
```
gem install --http-proxy http://<user>:<password>@wsproxy.alfa.bank.int:3128 ruby-plsql-spec
```


# Using RSpec

В робочому каталозі має бути підкаталог spec, де розміщені файли типу filename_spec.rb.

Для тестування в робочому каталозі потрібно запустити команду **rspec**.

The word **describe** is an RSpec keyword.  It is used to define an “Example Group”.  You can think of an “Example Group” as a collection of tests. 
Tests  are  known  in  RSpec as “Examples”. 

The **context** keyword is similar to describe. The idea of **context** is that it encloses tests of a certain type. 

Samples:

``` ruby
context “When passing bad parameters to the foobar() method” 
context “When passing valid parameters to the foobar() method” 
context “When testing corner cases with the foobar() method” 
```

The  **context**  keyword  is  not  mandatory,  but  it  helps  to  add  more  details  about  the examples that it contains. 

The word **it** is another RSpec keyword which is used to define an “Example”.

The string  argument  often  uses  the  word  **“should”**  and  is  meant  to  describe  what  specific behavior should happen inside the **it** block.  In other words, it describes that expected outcome is for the Example.

An Example is not just a test, it’s also a  specification  (a  spec).    In  other  words,  an  Example  both  documents  and  tests  the 
expected behavior of your Ruby code. 

The **expect** keyword is used to define an “Expectation” in RSpec.  This is a verification step where we check, that a specific expected condition has been met. 

The **to** keyword is used as part of **expect** statements.  Note that you can also use the **not_to** keyword to express the opposite, when you want the Expectation to be false. 

The **eql** keyword is a special RSpec keyword called a Matcher.  You use Matchers to specify what type of condition you are testing to be true (or false). 

## RSPEC – MATCHERS

| Column 1 | Column 2 |
| ------------- | ------------- |
| Cell 1-1 | Cell 1-2 |
| Cell 2-1 | Cell 2-2 |

| Matcher | Description | Example |
| ------- | ----------- | ------- |
| eq | Passes when actual == expected | expect(actual).to eq expected |
| eql | Passes when actual.eql?(expected) | expect(actual).to eql expected |
| be | Passes when actual.equal?(expected) | expect(actual).to be expected |
| equal | Also passes when 
actual.equal?(expected) | expect(actual).to equal 
expected |

## Використання before i after (послідовність відпрацювання)

``` ruby
# encoding: utf-8

require 'rspec'

describe "Before and after hooks" do
  before(:each) do
    puts "Describe before each"
  end
  after(:each) do
    puts "Describe after each"
  end
  before(:all) do
    puts "Describe before all"
  end
  after(:all) do
    puts "Describe after all"
  end
  context 'Context' do
    before(:each) do
      puts "Context before each"
    end
    after(:each) do
      puts "Context after each"
    end
    before(:all) do
      puts "Context before all"
    end
    after(:all) do
      puts "Context after all"
    end

    it 'is the first Example in this spec file' do
      puts 'Running the first Example'
    end
    it 'is the second Example in this spec file' do
      puts 'Running the second Example'
    end

  end
end
```

Результат:
```
Run options: include {:full_description=>/hooks/}
Describe before all
Context before all
Describe before each
Context before each
Running the first Example
Context after each
Describe after each
.Describe before each
Context before each
Running the second Example
Context after each
Describe after each
.Context after all
Describe after all


Finished in 0.083 seconds (files took 0.983 seconds to load)
2 examples, 0 failures
```

## let() vs before()

[When to use RSpec let()?](http://stackoverflow.com/questions/5359558/when-to-use-rspec-let?rq=1):

> I always prefer let to an instance variable for a couple of reasons:
> - Instance variables spring into existence when referenced. This means that if you fat finger the spelling of the instance variable, a new one will be created and initialized to nil, which can lead to subtle bugs and false positives. Since let creates a method, you'll get a NameError when you misspell it, which I find preferable. It makes it easier to refactor specs, too.
> - A before(:each) hook will run before each example, even if the example doesn't use any of the instance variables defined in the hook. This isn't usually a big deal, but if the setup of the instance variable takes a long time, then you're wasting cycles. For the method defined by let, the initialization code only runs if the example calls it.
> - You can refactor from a local variable in an example directly into a let without changing the referencing syntax in the example. If you refactor to an instance variable, you have to change how you reference the object in the example (e.g. add an @).
> - This is a bit subjective, but as Mike Lewis pointed out, I think it makes the spec easier to read. I like the organization of defining all my dependent objects with let and keeping my it block nice and short.

## Виявлення самих повільних тестів

Якщо тести виконуються довго, то можна виявити які з тестів виконуються найдовше.

Для цього використовується опція командного рядку **profile**.

Наприклад, так:
```
rspec ./spec/fma_spec.rb --profile
```

## Нюанси select

Вибірки можна виконувати використовуючи синтаксис:
``` ruby
aaccount_first = plsql.select(:first,<<-SQL
    select *
      from Aaccount
     where rownum = 1
SQL
)
-- або
aaccount_all = plsql.select(:all,<<-SQL
    select *
      from Aaccount
     where rownum = 1
SQL
)
```

При цьому перший синтаксис повертає об'єкт типу хеш, а другий масив хешів

``` ruby
aaccount_first = plsql.select(:first,<<-SQL
    select *
      from Aaccount
     where rownum = 1
SQL
)
puts aaccount_first.class

aaccount_all = plsql.select(:all,<<-SQL
    select *
      from Aaccount
     where rownum = 1
SQL
)
puts aaccount_all.class
```

поверне:
```

```

## Звіти

**html:**
```
plsql-spec run --html
```

**code coverage report**

```
plsql-spec run --coverage
```

Як працює не зрозуміло.

Кілька форматерів:

```
rspec --format progress \
      --format nested:path/to/my/report.txt \
      --format html:path/to/my/report.html
```