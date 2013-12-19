#!/usr/bin/env perl

use Test::More;
use Mango;

use_ok 'Test::Mock::Mango';
my $mango = Mango->new;

isa_ok($mango->db, 'Test::Mock::Mango::DB', 'Get correct object');

done_testing();
