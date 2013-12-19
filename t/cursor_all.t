#!/usr/bin/env perl

use Test::Spec;
use Mango;

use Test::Mock::Mango;
use Test::Mock::Mango::Cursor;

describe "Using cursor->all" => sub {

	my $cursor = Test::Mock::Mango::Cursor->new;

	describe "with blocking syntax" => sub {

		my $docs;

		before sub {
			$docs = $cursor->all;
		};

		it "should return an array ref" => sub {
			is(ref $docs, 'ARRAY');
		};

	};

	describe "with non-blocking syntax" => sub {

		$cursor->all( sub {
			my ($cursor, $err, $docs) = @_;
			it "should return an array ref" => sub {
				is(ref $docs, 'ARRAY');
			};
		});
	};

};

runtests unless caller;
