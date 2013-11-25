package MojoX::Test::MangoStub;

use v5.10;
use strict;
use warnings;

our $VERSION = 0.1;

use Mango; # Bit useless if you don't actually have mango
use MojoX::Test::MangoStub::FakeData;
use MojoX::Test::MangoStub::DB;
use MojoX::Test::MangoStub::Collection;

$MojoX::Test::MangoStub::data = MojoX::Test::MangoStub::FakeData->new;

{
	no warnings 'redefine';
	eval( q|*Mango::db = sub{state $db = MojoX::Test::MangoStub::DB->new}| );
}

1;

__END__

=head1 TITLE

MojoX::Test::MangoStub

=head1 DESCRIPTION

Simple stubbing of mango methods. Methods ignore actual queries being entered and
simply return the data set in the FakeData object. To run a test you need to set
up the data you expect back first - this module doesn't test your queries, it allows
you to test around mango calls with known conditions.

Non-blocking ops are not actually non blocking but simply execute your callback
straight away as there's nothing to actually go off and do on an event loop.

=cut
