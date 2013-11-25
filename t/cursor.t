#!/usr/bin/env perl

use Test::More;
use Mango;

use_ok 'MojoX::Test::MangoStub::Cursor';

my $cursor = MojoX::Test::MangoStub::Cursor->new;

can_ok( $cursor, qw|all next count|);

done_testing();
