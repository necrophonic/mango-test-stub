#!/usr/bin/env perl

use Test::More;
use Mango;

use MojoX::Test::MangoStub;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

my $cursor = $mango->db('foo')->collection('bar')->find( {some => 'query'} );
isa_ok($cursor, 'MojoX::Test::MangoStub::Cursor', '"find" returns cursor');

done_testing();
