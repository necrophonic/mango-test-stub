package Test::Mock::Mango;

use v5.10;
use strict;
use warnings;

our $VERSION = "0.02";

require 'Mango.pm'; # Bit useless if you don't actually have mango
use Test::Mock::Mango::FakeData;
use Test::Mock::Mango::DB;
use Test::Mock::Mango::Collection;

$Test::Mock::Mango::data  = Test::Mock::Mango::FakeData->new;
$Test::Mock::Mango::error = undef;
$Test::Mock::Mango::n     = undef;

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

=encoding utf8

=head1 NAME

Test::Mock::Mango - Simple stubbing for Mango to allow unit tests for code that uses it

=for html
<a href="https://travis-ci.org/necrophonic/test-mock-mango"><img src="https://travis-ci.org/necrophonic/test-mock-mango.png?branch=master"></a>

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


=head1 STUBBED METHODS

The following methods are available on each faked part of the mango. We
describe here briefly how far each actually simulates the real method.

Each method supports blocking and non-blocking syntax if the original
method does. Non-blocking ops are not actually non blocking but simply
execute your callback straight away as there's nothing to actually go off
and do on an event loop.

All methhods by default execute without error state.


=head2 Collection

L<Test::Mock::Mango::Collection>

=head3 aggregate

Ignores query. Returns current collection documents to simulate an
aggregated result.

=head3 create

Doesn't really do anything.

=head3 drop

Doesn't really do anything.

=head3 find_one

Ignores query. Returns the first document from the current fake collection
given in L<Test::Mock::Mango::FakeData>. Returns undef if the collection
is empty.

=head3 find

Ignores query. Returns a new L<Test::Mock::Mango::Cursor> instance.

=head3 full_name

Returns full name of the fake collection.

=head3 insert

Naively inserts the given doc(s) onto the end of the current fake collection.

Returns an C<oid> for each inserted document. If an C<_id> is specifiec
in the inserted doc then it is returned, otherwise a new
L<Mango::BSON::ObjectID> is returned instead.

=head3 update

Doesn't perform a real update. You should set the data state in
C<$Test::Mock::Mango::data> before making the call to be what
you expect after the update.

=head3 remove

Doesn't remove anything.



=head2 Cursor

L<Test::Mock::Mango::Cursor>

=head3 all

Return array ref containing all the documents in the current fake collection.

=head3 next

Simulates a cursor by (beginning at zero) iterating through each document
on successive calls. Won't reset itself. If you want to reset the
cursor then set C<Test::Mock::Mango->index> to zero.

=head3 count

Returns the number of documents in the current fake collection.

=head3 backlog

Arbitarily returns 'C<2>'


=head1 TESTING ERROR STATES

L<Test::Mock::Mango> gives you the ability to simulate errors from your
mango calls.

Simply set the C<error> var before the call:

  $Test::Mock::Mango::error = 'oh noes!';

The next call will then run in an error state as if a real error has occurred.
The C<error> var is automatically cleared with the call so you don't need
to C<undef> it afterwards.


=head1 TESTING UPDATE/REMOVE FAILURES ETC

By default, L<Test::Mock::Mango> is optimistic and assumes that any operation
you perform has succeeded.

However, there are times when you want to do things in the event of a
failure (e.g. when you attempt to update and the doc to update doesn't exist
- this differs from an L<error|"\TESTING ERROR STATES"> in that nothing
is wrong with the call, and technically the operation has "succeeded" [mongodb
is funny like that ;) ])

Mongodb normally reports this by a magic parameter called C<n> that it passes
back in the resultant doc. This is set to the number of documents that have
been affected (e.g. if you remove two docs, it'll be set to 2, if you update
4 docs successfully it'll be set to 4).

In it's optimistic simulation, L<Test::Mock::Mango> automaticaly sets the
C<n> value in return docs to 1. If your software cares about the C<n> value
and you want it set specifically (especially if you want to simulate say a "not
updated" case) you can do this via the C<n> value of $Test::Mock::MangoL

  $Test::Mock::Mango::n = 0; # The next call will now pretend no docs were updated

In the same way as using C<$Test::Mock::Mango::error>, this value will be
automatically cleared after the next call. If you want to reset it yourself
at any point then set it to C<undef>.

B<Examples>

  my $doc = $mango->db('family')->collection('simpsons')->update(
    { name => 'Bart' },
    { name => 'Bartholomew' }
  );
  # $doc->{n} will be 1

  $Test::Mock::Mango::n = 0;
  my $doc = $mango->db('family')->collection('simpsons')->update(
    { name => 'Bart' },
    { name => 'Bartholomew' }
  );
  # $doc->{n} will be 0


=head1 AUTHOR

J Gregory <JGREGORY@CPAN.ORG>

=head1 SEE ALSO

L<Mango>

=cut
