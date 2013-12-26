#!/usr/bin/env perl

use Test::More tests => 2;
use Mango;

use Test::Mock::Mango;

my $collection = Test::Mock::Mango::Collection->new;

subtest 'collection->aggregate with blocking syntax' => sub {
	is( ref $collection->aggregate, 'ARRAY', 'returns array ref' );
};

subtest 'collection->aggregate with non-blocking syntax' => sub {
	$collection->aggregate(sub {
		my ($cursor, $err, $docs) = @_;
		is( ref $docs, 'ARRAY', 'returns array ref' );
	});
};

done_testing();
