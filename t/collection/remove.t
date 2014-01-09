#!/usr/bin/env perl

use strict;
use Test::More;
use Test::Exception;
use Mango;

use Test::Mock::Mango;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

subtest "Blocking syntax" => sub {
	
	subtest "basic call" => sub {
		my $doc = $mango->db('foo')->collection('bar')->remove({foo=>'bar'});
		is $doc->{n}, '1', 'docs updated set';
	};

	subtest "error state" => sub {
		$Test::Mock::Mango::error = 'oh noes';
		$mango->db('foo')->collection('bar')->remove({foo=>'bar'});		
		is $Test::Mock::Mango::error, undef, 'error reset';
	};

	# TODO test support of flags syntax
};


subtest "Non-blocking syntax" => sub {	

	subtest "basic call" => sub {
		$mango->db('foo')->collection('bar')->remove( {foo=>'bar'} => sub {			
			my ($collection, $err, $doc) = @_;			
			is $doc->{n}, '1', 'docs updated set';
			is $err, undef, 'no error returned';
		});
	};

	subtest "error state" => sub {
		$Test::Mock::Mango::error = 'oh noes';
		$mango->db('foo')->collection('bar')->remove({foo=>'bar'} => sub {
			my ($collection, $err, $doc) = @_;
			is $doc, undef, 'returns undef as expected';
			is $err, 'oh noes', 'returns error as expected';
			is $Test::Mock::Mango::error, undef, 'error reset';
		});
	};

	# TODO test support of flags syntax
};

done_testing();
