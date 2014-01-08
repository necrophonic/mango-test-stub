#!/usr/bin/env perl

use strict;
use Test::More;
use Mango;

use Test::Mock::Mango;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

subtest "Blocking syntax" => sub {
	
	my $doc = undef;

	subtest "basic call" => sub {
		$doc = $mango->db('foo')->collection('bar')->update(
			{foo=>'bar'},
			{foo=>'baz'}
		);
		is_deeply $doc, {foo=>'baz'}, 'returns doc ok';
	};

	subtest "error state" => sub {
		$Test::Mock::Mango::error = 'oh noes';
		$doc = $mango->db('foo')->collection('bar')->update(
			{foo=>'bar'},
			{foo=>'baz'}
		);
		is $doc, undef, 'returns undef as expected';
		is $Test::Mock::Mango::error, undef, 'error reset';
	};
};


subtest "Non-blocking syntax" => sub {	

	subtest "basic call" => sub {
		$mango->db('foo')->collection('bar')->update(
			{foo=>'bar'},
			{foo=>'baz'}
			=> sub {
				my ($collection, $err, $doc) = @_;
				is_deeply $doc, {foo=>'baz'}, 'returns doc ok';
				is $err, undef, 'no error returned';
			}
		);
	};

	subtest "error state" => sub {
		$Test::Mock::Mango::error = 'oh noes';
		$mango->db('foo')->collection('bar')->update(
			{foo=>'bar'},
			{foo=>'baz'}
			=> sub {
				my ($collection, $err, $doc) = @_;
				is $doc, undef, 'returns undef as expected';
				is $err, 'oh noes', 'returns error as expected';
				is $Test::Mock::Mango::error, undef, 'error reset';
			}
		);
	};
};

done_testing();
