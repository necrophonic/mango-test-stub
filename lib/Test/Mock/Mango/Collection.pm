package Test::Mock::Mango::Collection;

use v5.10;
use strict;
use warnings;

use Test::Mock::Mango::Cursor;

sub new { bless {}, shift }

# find_one
#
# By default we return the first document from the fake data collection
#
sub find_one {
	my ($self, $query) = (shift,shift);

	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;
	
	# Return the first fake document
	my $doc = $Test::Mock::Mango::data->{collection}->[0];

	my $err = ''; # TODO

	unless($doc) {
		die "Fake find_one failed - need at least one document set in fake data collection\n\n";
	}
	
	return $cb->($self, $err, $doc) if $cb;	# Non blocking
	return $doc;							# Blocking
}

# ------------------------------------------------------------------------------

sub find {	
	return Test::Mock::Mango::Cursor->new; # Not actually passing any values
												# through as we're not using them :-p
}

# ------------------------------------------------------------------------------

sub full_name {
	return $Test::Mock::Mango::data->{collection_name};	
}

# ------------------------------------------------------------------------------

sub insert {
	my ($self, $docs) = (shift,shift);

	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;

	# Get how many docs we're "inserting" so we can return the right number of oids
	my $num_docs = 1;
	if (ref $docs eq 'ARRAY') {
		$num_docs = scalar @$docs;
	}

	my $err = '';  # TODO

	# TODO insert the given docs into the current fake data
	# ...
	# ...

	# TODO customise format of returned ID?
	my $oids = [];
	for (1..$num_docs) {
		push @$oids, int rand(100000000000);
	}

	my $return_oids = $num_docs==1 ? $oids->[0] : $oids;

	return $cb->($self,$err,$return_oids) if $cb;
	return $return_oids;
}

1;

__END__

=head1 TITLE

Test::Mock::Mango::Collection - fake Mango::Collection

=head1 DESCRIPTION

Simulated mango collection for unit testing as part of L<Test::Mock::Mango>.

=head1 SUPPORTED METHODS

=over

=item * find_one

=item * find

=back
