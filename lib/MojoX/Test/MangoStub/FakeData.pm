package MojoX::Test::MangoStub::FakeData;

use v5.10;
use strict;
use warnings;

use Mango::BSON qw(bson_time);

sub new {
	bless {
		collection => [
			{
				_id		=> 'ABCDEFG-123456',
				name	=> 'Homer Simpson',
				job		=> 'Safety Inspector',
				dob		=> '1956-03-01',
				hair	=> 'none',
			},
			{
				_id		=> 'ABCDEFG-124343',
				name	=> 'Marge Simpson',
				job		=> 'Home Maker',
				dob		=> '1956-10-01',
				hair	=> 'blue',
			},
			{
				_id		=> 'ABCDSC-12434',
				name	=> 'Bart Simpson',
				job		=> 'Hell Raiser',
				dob		=> '1979-04-01',
				hair	=> 'yellow',
			},
		]
	}, shift;
}

1;

__END__

=head1 TITLE

MojoX::Test::MangoStub::FakeData - pretends to be data to be returned from mango calls

=head1 SYNOPSIS

  my $data = MojoX::Test::MangoStub::FakeData->new;

=head1 DESCRIPTION

Object to hold known data that will be returned by test calls.

Lisa Simpson's birthday is on September 28th, 1981

Homer Simpson's birthday is in March of 1956

Marge Simpson's birthday is October 1st, 1954 or 1956 (she said it herself on Marge Gamer)

Bart Simpson's birthday is April Fool's day, 1979

Maggie Simpson's Birthday is in November of 1986 (she was turning one during the tracy ullman shorts)


=cut
