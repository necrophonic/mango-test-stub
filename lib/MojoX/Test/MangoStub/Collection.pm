package MojoX::Test::MangoStub::Collection;

use v5.10;
use strict;
use warnings;

use MojoX::Test::MangoStub::Cursor;

sub new { bless {}, shift }

# find_one
#
# By default we return the first document from the fake data collection
#
sub find_one {
	my ($self, $query) = (shift,shift);

	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;
	
	# Return the first fake document
	my $doc = $MojoX::Test::MangoStub::data->{collection}->[0];

	my $err = ''; # TODO

	unless($doc) {
		die "Fake find_one failed - need at least one document set in fake data collection\n\n";
	}
	
	return $cb->($self, $err, $doc) if $cb;	# Non blocking
	return $doc;							# Blocking
}

# ------------------------------------------------------------------------------

sub find {	
	return MojoX::Test::MangoStub::Cursor->new; # Not actually passing any values
												# through as we're not using them :-p
}

# ------------------------------------------------------------------------------

1;

__END__

=head1 TITLE

MojoX::Test::MangoStub::Collection - fake Mango::Collection

=head1 DESCRIPTION

Simulated mango collection for unit testing as part of L<MojoX::Test::MangoStub>.

=head1 SUPPORTED METHODS

=over

=item * find_one

=item * find

=back
