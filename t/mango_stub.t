#!/usr/bin/env perl

use Test::More;
use Mango;

use_ok 'MojoX::Test::MangoStub';
my $mango = Mango->new;

isa_ok($mango->db, 'MojoX::Test::MangoStub::DB', 'Get correct object');

done_testing();
