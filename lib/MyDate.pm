package MyDate;

use strict;
use warnings;
use Carp;

use feature ':5.10';

=head3 is_leap_year

    my $is_leap_year = MyDate->is_leap_year($year)

Returns whether $year is a leap year.

=cut

sub is_leap_year {
    my $class = shift;
    my $year = shift;
    
    if (($year % 4 == 0 and not $year % 100 == 0) or $year % 400 == 0) {
        return 1;
    }
    return;
}

=head3 day_of_week

    my $day = MyDate->day_of_week($year, $month, $day);

Returns the named $dow for the $year, $month, and $day

    MyDate->day_of_week(2009, 6, 25); # Thursday

May not work for dates prior to 1753 or after 2699.  If out of the
allowable range, will throw an exception.

=cut

my @day_for_num = qw{Sunday Monday Tuesday Wednesday Thursday Friday Saturday};

sub day_of_week {
    my ($class, $year, $month, $day) = @_;
    
    my $century_day   = _century_day($year, $month, $day);
    my $year_number   = $year % 100;
    my $year_offset   = _year_offset($year, $month, $day);
    my $months_offset = _months_offset($year, $month, $day);

    my $offset = $century_day + $year_number + $year_offset +
        $months_offset + $day;

    return $day_for_num[$offset % 7];
}

sub _century_day {
    my ($year, $month, $day) = @_;

    given ($year) {
        when ( [1753..1799] ) { return 4 }
        when ( [1800..1899] ) { return 2 }
        when ( [1900..1999] ) { return 0 }
        when ( [2000..2099] ) { return 6 }
        when ( [2100..2199] ) { return 4 }
        when ( [2200..2299] ) { return 2 }
        when ( [2300..2399] ) { return 0 }
        when ( [2400..2499] ) { return 6 }
        when ( [2500..2599] ) { return 4 }
        when ( [2600..2699] ) { return 2 }
        default { croak "$year is outside allowable range 1753..2699" }
    }
}

sub _months_offset {
    my ($year, $month, $day) = @_;

    my $ly = __PACKAGE__->is_leap_year($year);
    
    my @offset = (
        $ly ? 6 : 0, # January
        $ly ? 2 : 3, # February
        3,           # March
        6,           # April
        1,           # May
        4,           # June
        6,           # July
        2,           # August
        5,           # September
        0,           # October
        3,           # November
        5,           # December
    );

    return $offset[$month - 1];
}

sub _year_offset {
    my ($year, $month, $day) = @_;

    my $year_number = $year % 100;
    
    return int($year_number / 4);
}

1;
