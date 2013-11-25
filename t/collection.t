#!/usr/bin/env perl

use Test::More;
use Mango;

use_ok 'MojoX::Test::MangoStub::Collection';

my $collection = MojoX::Test::MangoStub::Collection->new;

can_ok( $collection, qw|find find_one|);

done_testing();
