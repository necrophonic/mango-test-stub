package MojoX::Test::MangoStub::Cursor;

use v5.10;
use strict;
use warnings;

sub new { bless {index=>0}, shift }

sub all {
	my ($self, $cb) = @_;

	my $err = ''; # TODO
	my $docs = $MojoX::Test::MangoStub::data->{collection};

	return $cb->($self,$err,$docs) if $cb;
	return $docs;
}

# ------------------------------------------------------------------------------

# Naive "next" - simply iterate through the docs in the defined test data
sub next {
	my ($self, $cb) = @_;

	my $err = ''; # TODO
	my $doc = $MojoX::Test::MangoStub::data->{collection}->[$self->{index}++];

	return $cb->($self,$err,$doc) if $cb;
	return $doc;
}

# ------------------------------------------------------------------------------

sub count {
	my ($self,$cb) = @_;

	my $err = ''; # TODO
	my $count = scalar @{$MojoX::Test::MangoStub::data->{collection}};

	return $cb->($self,$err,$count) if $cb;
	return $count;
}

# ------------------------------------------------------------------------------

1;

__END__

=head1 TITLE

MojoX::Test::MangoStub::Cursor - fake Mango::Cursor

=head1 DESCRIPTION

Simulated mango cursor for unit testing as part of L<MojoX::Test::MangoStub>.

=head1 SUPPORTED METHODS

=over

=item * all

=item * next

=item * count

=back
