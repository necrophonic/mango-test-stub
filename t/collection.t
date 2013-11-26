#!/usr/bin/env perl

use Test::Spec;
use Mango;

use_ok 'MojoX::Test::MangoStub::Collection';

describe 'Collection' => sub {

	my $collection = MojoX::Test::MangoStub::Collection->new;

	it 'should define "find", "find_one", "full_name" and "insert" methods' => sub {
		can_ok( $collection, qw|find find_one full_name insert|);
	};
};

runtests;
