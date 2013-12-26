#!/usr/bin/env perl

use Test::More;
use Mango;

use_ok 'Test::Mock::Mango::Collection';

subtest 'Collection' => sub {

	my $collection = Test::Mock::Mango::Collection->new;

	can_ok $collection, (qw|
		aggregate create drop
		find find_one full_name insert
	|);

};

done_testing();
