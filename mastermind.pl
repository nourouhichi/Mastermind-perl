#!/usr/bin/perl

sub truecode() {
    my $string = shift;
    my $colors = shift;
    @six = ("R","G","W","B","O","Y");
    @four = ("R", "G", "B", "W");
    @two = ("B", "W");

    for $i (0..length($string)-1){
        $char = substr($string, $i, 1);
        if ($colors == 6){
            if (($char ~~ @six) == false){
            return 0;
            }
        }
        if ($colors == 4){
            if (($char ~~ @four) == false){
            return 0;
            }
        }
        if ($colors == 2){
            if (($char ~~ @two) == false){
            return 0;
            }
        }
    }
    return 1;
}
print "Choose Game Mode:\n(1): Single player, (2): Multiplayer\n";
$m = <STDIN>;
while ($m != 1 and $m != 2){
print "Wrong input\n";
$m = <STDIN>;
}
print "Choose number of tries (6, 8, 10, 12) and number of colors (2, 4, 6):\n";
$tries = <STDIN>;
while (($tries ~~ [6, 8, 10, 12]) == false) {
    print "Wrong input\n";
    $tries = <STDIN>;
}
$colors = <STDIN>;
while (($colors ~~ [2, 4, 6]) == false){
    print "Wrong input\n";
    $colors = <STDIN>;
}
@six = ("B", "W", "O", "G", "R", "Y");
@four = ("R", "G", "B", "W");
@two = ("B", "W");
my @rand;
if ($m == 1){
    if ($colors == 2){
        for (1 ..  4){
            push @rand, $two[ rand @two ]; 
        }
    }
    if ($colors == 4){
        for (1 ..  4){
            push @rand, $four[ rand @four ]; 
        }
    }
    if ($colors == 6){
        for (1 ..  4){
            push @rand, $six[ rand @six ]; 
        }
    }
}

if ($m == 2){
    print "Input code\n";
    $code = <STDIN>;
    chomp($code);
    while (length $code != 4 or &truecode($code, $colors) == 0){
        print "Wrong input\n";
        print "Example: BWGB\n";
        $code = <STDIN>;
        chomp($code);
    }
}

for $i (1 .. $tries){
    print "Guess code\n";
    $guess = <STDIN>;
    chomp($guess);
    while (length $guess != 4 or &truecode($guess, $colors) == 0){
        print "Wrong input\n";
        print "Example: BWGB\n";
        $guess = <STDIN>;
        chomp($guess);
    }
    if ($guess eq $code){
        print " U ARE A MASTERMIND ! \n";
        last;
    }
    my @matches =();
    for $i (0 .. length(guess) - 2){
        $char1 = substr($guess, $i, 1);
        $char2 = substr($code, $i, 1);
        my $count = 0;
        if (($char1 ~~ $code) == true){
            $count += 1;
            if (($char1 eq $char2)){
                push(@matches, 2);
            }
            else if ($count != 1){
                push(@matches, 1);
            }
            else {
            push(@matches, 0);
        } 
        }
        else {
            push(@matches, 0);
        } 
    }
    print @matches, "\n";
    if (@matches == (2, 2, 2, 2)) {
        print "Congrats";
        last;
    }
}
