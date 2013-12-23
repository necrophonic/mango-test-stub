#!/usr/bin/env perl

use Test::More tests => 2;
use Mango;

use Test::Mock::Mango;
use Test::Mock::Mango::Cursor;

my $cursor = Test::Mock::Mango::Cursor->new;

subtest 'cursor->all with blocking syntax' => sub {
	is( ref $cursor->all, 'ARRAY', 'returns array ref' );
};

subtest 'cursor->all with non-blocking syntax' => sub {
	$cursor->all(sub {
		my ($cursor, $err, $docs) = @_;
		is( ref $docs, 'ARRAY', 'returns array ref' );
	});
};

done_testing();
