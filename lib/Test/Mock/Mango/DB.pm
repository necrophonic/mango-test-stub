package Test::Mock::Mango::DB;

use v5.10;
use strict;
use warnings;

use Test::Mock::Mango::Collection;

sub new {
	my $class = shift;

	bless {
		name 	=> shift
	}, $class;
}
sub collection { state $collection = Test::Mock::Mango::Collection->new(shift,shift) }

1;

=encoding utf8

=head1 NAME

Test::Mock::Mango::DB - fake Mango::DB

=head1 DESCRIPTION

Simulated mango db for unit testing as part of L<Test::Mock::Mango>.

=cut
