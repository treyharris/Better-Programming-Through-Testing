package MyDate;

use strict;
use warnings;

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

1;
