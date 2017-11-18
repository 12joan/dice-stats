# Dice

This is a tool for finding the probabilities of each desired outcome of a dice roll. For example, what is the probability of rolling exactly 17 from [5d6](https://en.wikipedia.org/wiki/Dice_notation)? According to his program, it's about one in ten. It can be extremely useful to know things like this in many tabletop games, such as Dungeons and Dragons: what is the probability of surviving a 50 ft. fall with only 17 hit points remaining?

Why would you want a computer to do this for you? Think about how you could work it out by hand. You could draw a tree diagram for 1d6 with six branches. On the end of each branch, you could draw another six branches... and another six branches on each new end... and another... and another... and one more lot of six. That's 7776 branch segments in total! Or, you could let a computer do it in milliseconds.

## Getting Started

Follow these instructions to get a working copy of the application. You are free to make improvements and redistribute the code as you wish - see the [LICENSE](LICENSE) file for details.

### Prerequisites

The majority of the application is written in Ruby, which can be installed from [here](https://www.ruby-lang.org/en/).

You will also need a way of compiling the roller executable, which is written in C. The makefile assumes the use of the [gcc compiler](https://gcc.gnu.org).

### Compiling and Setup

First, you need to compile the dice roller, which is responsible for finding the number of paths to each outcome. The best case is that you simply need to run the makefile:

````
$ cd roller/
$ make
````

If this does not work for whatever reason, you can use another method of compiling `roller/src/main.c`. Make sure you put the binary file in `roller/bin/rollpaths`. Also, please take the time to [create an issue](https://github.com/12joan/dice/issues) describing what went wrong.

Although I recommend running this through the ruby scripts (which will cache the results), you can invoke it directly like any other executable.

```
bin/rollpaths [number_of_dice] [sides]
```

The output will be a long list of numbers separated by new lines representing the number of ways of reaching each possible outcome.

Be careful with running this. Keep in mind that the complexity of the algoritm scales like O(a<sup>n</sup>) where a is the number of sides on each die and n is the number of dice to roll. This makes it quite impractical for processing more than around ten dice, but it can be done given enough time.

Next, install all the gems in the Gemfile, which are needed for the next step as well as for running the program. This is easy to do with [bundler](http://bundler.io), or you can read the Gemfile yourself and install everything manually using `gem install GEMNAME`.

```
$ cd ../dice_stats/
$ bundle install
```

Finally, you need to create the database used for caching dice rolls.

```
$ rake create_db
```

This creates a [sqlite3](https://sqlite.org) database with a table for storing caches. Keeping this table full of frequent rolls is very important. The rake task `rake fill_cache` will keep running and caching the results of increasing numbers of dice with 6 sides.

```
$ rake fill_cache
```

If allowed to run indefinitely, it will keep the CPU busy and fill up the database file with more records, which may have adverse effects on the performance of your computer. You can kill it using a keyboard interrupt, and it will resume next time you run it after quickly checking that all previous results are still cached. 

## Usage

If you are comfortable with Ruby, you can require the `src/main.rb` file in an IRB session and use it like this:

```
irb(main):002:0> DiceStats.distribution_for(5, 6).probability_of(17)
=> 0.10030864197530864
irb(main):003:0> DiceStats.distribution_for(5, 6).probability { |n| n > 20 }
=> 0.22145061728395063
```

Alternatively, you can start the dice console using `rake console`, and interact with the application like this:

```
> 5d6>20
0.22145061728395063
> 5d6=17
0.10030864197530864
```

You can also turn your computer (or a nearby [Raspberry Pi](https://www.raspberrypi.org)) into a dice server by running `rake server`. You can then point a [TCP client](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) at it on port 8000 and request probabilities in the same way.

With both of these methods, users cannot request uncached rolls more complex than 10d6, where complexity is assumed to be directly proportional to sides to the power of number of dice. You can change or remove this limitation by editing the `src/text_interface.rb` file.

## Authors

* **Joseph Anderson** - [12joan](https://github.com/12joan)

## License

This project is licensed under the Unlicence - see the [LICENSE](LICENSE) file for details

