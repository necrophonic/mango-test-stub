#!/usr/bin/env perl

use Test::More;
use Mango;

use Test::Mock::Mango;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

my $collection = $mango->db('foo')->collection('bar');
isa_ok(
	$collection,
	'Test::Mock::Mango::Collection',
	'Test::Mock::Mango::DB creations collection'
);

done_testing();
