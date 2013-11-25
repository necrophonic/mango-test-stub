#!/usr/bin/env perl

use Test::More;
use Mango;

use MojoX::Test::MangoStub;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

my $collection = $mango->db('foo')->collection('bar');
isa_ok(
	$collection,
	'MojoX::Test::MangoStub::Collection',
	'MojoX::Test::MangoStub::DB creations collection'
);

done_testing();
