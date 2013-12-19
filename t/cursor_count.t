#!/usr/bin/env perl

use Test::Spec;
use Mango;

use Test::Mock::Mango;
use Test::Mock::Mango::Cursor;

describe 'Using cursor->count()' => sub {

	my $cursor = Test::Mock::Mango::Cursor->new;

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
