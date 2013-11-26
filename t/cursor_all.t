#!/usr/bin/env perl

use Test::Spec;
use Mango;

use MojoX::Test::MangoStub;
use MojoX::Test::MangoStub::Cursor;

describe "Using cursor->all" => sub {

	my $cursor = MojoX::Test::MangoStub::Cursor->new;

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
