package MojoX::Test::MangoStub::DB;

use v5.10;
use strict;
use warnings;

use MojoX::Test::MangoStub::Collection;

sub new { bless {}, shift }
sub collection { state $collection = MojoX::Test::MangoStub::Collection->new }

1;