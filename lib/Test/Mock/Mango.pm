package Test::Mock::Mango;

use v5.10;
use strict;
use warnings;

our $VERSION = 0.1;

require 'Mango.pm'; # Bit useless if you don't actually have mango
use Test::Mock::Mango::FakeData;
use Test::Mock::Mango::DB;
use Test::Mock::Mango::Collection;

$Test::Mock::Mango::data = Test::Mock::Mango::FakeData->new;

# If we're running with Test::Spec and in appropriate context
# then use Test::Spec::Mocks to do our monkey patching.
if (exists $INC{'Test/Spec.pm'} && Test::Spec->current_context) {
	use warnings 'redefine';
	Mango->expects('db')->returns( state $db = Test::Mock::Mango::DB->new);
}
else {
 	no warnings 'redefine';
 	eval( q|*Mango::db = sub{state $db = Test::Mock::Mango::DB->new}| );
}

1;

__END__

=head1 TITLE

Test::Mock::Mango

=head1 SYNOPSIS

  # Using Test::More
  #
  use Test::More;
  use Test::Mock::Mango; # Stubs in effect!
  # ...
  done_testing();


  # Using Test::Spec (uses Test::Spec::Mocks)
  #
  use Test::Spec;

  describe "Whilst stubbing Mango" => {
    require Test::Mock::Mango; # Stubs in effect in scope!
    # ...
  };
  runtests unless caller;


=head1 DESCRIPTION

Simple stubbing of mango methods. Methods ignore actual queries being entered and
simply return the data set in the FakeData object. To run a test you need to set
up the data you expect back first - this module doesn't test your queries, it allows
you to test around mango calls with known conditions.

Non-blocking ops are not actually non blocking but simply execute your callback
straight away as there's nothing to actually go off and do on an event loop.

=cut
