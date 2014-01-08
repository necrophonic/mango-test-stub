package Test::Mock::Mango::Collection;

use v5.10;
use strict;
use warnings;

use Test::Mock::Mango::Cursor;

sub new { bless {}, shift }

# aggregate
#
# Fake an "aggregated result" by returning the current fake collection
#
sub aggregate {
	my $self = shift;
	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;

	my $docs = undef;
	my $err  = undef;

	if (defined $Test::Mock::Mango::error) {
		$err 					  = $Test::Mock::Mango::error;
		$Test::Mock::Mango::error = undef;
	}
	else {
		$docs = $Test::Mock::Mango::data->{collection};
	}

	return $cb->($self,$err,$docs) if $cb;
	return $docs;
}

# ------------------------------------------------------------------------------

# create
#
# Doesn't do anything. Just return with or without error as specified
#
sub create {
	my $self = shift;
	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;

	my $err = undef;
	if (defined $Test::Mock::Mango::error) {
		$err 					  = $Test::Mock::Mango::error;
		$Test::Mock::Mango::error = undef;
	}

	return $cb->($self,$err) if $cb;
	return;
}

# ------------------------------------------------------------------------------

# drop
#
# Doesn't do anything. Just return with or without error as specified
#
sub drop {
	my $self = shift;
	my $cb = ref $_[-1] eq 'CODE' ? pop : undef;

	my $err = undef;
	if (defined $Test::Mock::Mango::error) {
		$err 					  = $Test::Mock::Mango::error;
		$Test::Mock::Mango::error = undef;
	}

	return $cb->($self,$err) if $cb;
	return;	
}

# ------------------------------------------------------------------------------

# find_one
#
# By default we return the first document from the fake data collection
#
sub find_one {
	my ($self, $query) = (shift,shift);
	
	my $cb  = ref $_[-1] eq 'CODE' ? pop : undef;
	my $doc = undef;
	my $err = undef;
	
	if (defined $Test::Mock::Mango::error) {		
		$err 					  = $Test::Mock::Mango::error;
		$Test::Mock::Mango::error = undef;
	}
	else {
		# Return the first fake document
		$doc = $Test::Mock::Mango::data->{collection}->[0] || undef;
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

	my $oids 		= [];
	my $err  		= undef;
	my $return_oids = '';

	if (defined $Test::Mock::Mango::error) {
		$return_oids 			  = undef;
		$err 					  = $Test::Mock::Mango::error;
		$Test::Mock::Mango::error = undef;
	}
	else {
		# Get how many docs we're "inserting" so we can return the right number of oids
		my $num_docs = 1;
		if (ref $docs eq 'ARRAY') {
			$num_docs = scalar @$docs;
			for (0..$num_docs-1) {
				push @$oids, $docs->[$_]->{_id} ||= sprintf("%010s", int rand(1000000000));
				push @{$Test::Mock::Mango::data->{collection}}, $docs->[$_];
			}
			$return_oids = $oids;
		}
		else {
			push @$oids, $docs->{_id} ||= sprintf("%010s", int rand(1000000000));
			push @{$Test::Mock::Mango::data->{collection}}, $docs;
			$return_oids = $oids->[0];
		}
	}
	
	return $cb->($self,$err,$return_oids) if $cb;
	return $return_oids;	
}

1;

=encoding utf8

=head1 NAME

Test::Mock::Mango::Collection - fake Mango::Collection

=head1 DESCRIPTION

Simulated mango collection for unit testing as part of L<Test::Mock::Mango>.

=cut
