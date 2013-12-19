package Test::Mock::Mango::DB;

use v5.10;
use strict;
use warnings;

use Test::Mock::Mango::Collection;

sub new { bless {}, shift }
sub collection { state $collection = Test::Mock::Mango::Collection->new }

1;