use strict;
use warnings;

use Test::More;

use_ok('MyDate', "Can load MyDate.pm");

my %is_leap_year = (
    1896 => 1,
    1897 => 0,
    1899 => 0,
    1900 => 0,
    1904 => 1,
    2000 => 1,
    2001 => 0,
    2002 => 0,
    2003 => 0,
    2004 => 1,
    2005 => 0,
    2006 => 0,
    2007 => 0,
    2008 => 1,
    2009 => 0,
);

for my $year (sort {$a <=> $b} keys %is_leap_year) {
    my $is = 'is not';
    if ($is_leap_year{$year}) {
        $is = 'is';
    }
    is(!!MyDate->is_leap_year($year), !!$is_leap_year{$year},
       "$year $is a leap year");
}

# How about array returns?

ok(@{ [ MyDate->is_leap_year(2000)]}, "In array context, returns true for 2000");
ok(!@{ [ MyDate->is_leap_year(1900)]}, "In array context, returns false for 1900");

done_testing(18);
