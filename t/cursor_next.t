#!/usr/bin/env perl

use Test::More;
use Mango;

use Test::Mock::Mango;
use Test::Mock::Mango::Cursor;

subtest "Blocking syntax" => sub {
	my $cursor = Test::Mock::Mango::Cursor->new;
	is($cursor->next->{name}, 'Homer Simpson', 'Get next doc');
	is($cursor->next->{name}, 'Marge Simpson', 'Get next doc');
	is($cursor->next->{name}, 'Bart Simpson',  'Get next doc');
	is($cursor->next->{name}, 'Lisa Simpson',  'Get next doc');
	is($cursor->next->{name}, 'Maggie Simpson','Get next doc');
	is($cursor->next, undef, 'Out of docs');
};


subtest "Non blocking syntax" => sub {
	my $cursor = Test::Mock::Mango::Cursor->new;

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc->{name}, 'Homer Simpson', 'Get next doc');
	});

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc->{name}, 'Marge Simpson', 'Get next doc');
	});

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc->{name}, 'Bart Simpson', 'Get next doc');
	});

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc->{name}, 'Lisa Simpson',  'Get next doc');
	});

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc->{name}, 'Maggie Simpson',  'Get next doc');
	});

	$cursor->next( sub {
		my ($self,$err,$doc) = @_;
		is($doc, undef, 'Out of docs');
	});	
};


done_testing();