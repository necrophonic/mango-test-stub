#!/usr/bin/env perl

use Test::More tests => 2;
use Mango;

use Test::Mock::Mango;
use Test::Mock::Mango::Cursor;

my $cursor = Test::Mock::Mango::Cursor->new;

subtest 'cursor->count() with blocking synatx' => sub {
	is ( $cursor->count, 5, 'returns expected number of results' );
};

subtest 'cursor->count() with non-blocking syntax' => sub {
	$cursor->count( sub {
		my ($cursor, $err, $count) = @_;
		is($count, 5, 'returns expdected number of results');
	});
};

done_testing();
