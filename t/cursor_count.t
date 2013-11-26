#!/usr/bin/env perl

use Test::Spec;
use Mango;

use MojoX::Test::MangoStub;
use MojoX::Test::MangoStub::Cursor;

describe 'Using cursor->count()' => sub {

	my $cursor = MojoX::Test::MangoStub::Cursor->new;

	describe 'with blocking syntax' => sub {
		it 'should return 5' => sub {
			is($cursor->count, 5);
		};
	};

	describe 'with non-blocking syntax' => sub {
		it 'should return 5' => sub {
			$cursor->count( sub {
				my ($cursor, $err, $count) = @_;
				is($count, 5);
			});
		};
	};

};


runtests;
