#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Mango;

use Test::Mock::Mango;

my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

subtest "Blocking syntax" => sub {
	plan tests => 3;

	subtest "Single insert - autogen id" => sub {
		plan tests => 2;
		my $oid = $mango->db('foo')->collection('bar')->insert({
			name => 'Ned Flanders',
			job	 => 'Neigdiddlyabour',
			dob  => '1942-01-01',
			hair => 'brown',
		});
		like $oid, qr/^\d{10}$/, "Single generated OID returnded as expected [$oid]";
		is scalar @{$Test::Mock::Mango::data->{collection}}, 6, 'Data inserted';
	};

	subtest "Single insert - known id" => sub {
		plan tests => 2;
		my $oid = $mango->db('foo')->collection('bar')->insert({
			_id	 => 'ABC1234',
			name => 'Ned Flanders',
			job	 => 'Neigdiddlyabour',
			dob  => '1942-01-01',
			hair => 'brown',
		});
		is $oid, 'ABC1234', "Single known OID returnded as expected [ABC1234]";
		is scalar @{$Test::Mock::Mango::data->{collection}}, 7, 'Data inserted';
	};

	subtest "Multiple insert - mix ids" => sub {
		plan tests => 4;
		my $oids = $mango->db('foo')->collection('bar')->insert([
			{
				_id	 => 'ABC9999',
				name => 'Ned Flanders',
				job	 => 'Neigdiddlyabour',
				dob  => '1942-01-01',
				hair => 'brown',
			},
			{				
				name => 'Todd Flanders',
				job	 => 'Annoyance',
				dob  => '1984-01-01',
				hair => 'brown',
			},
		]);
		is   ref $oids,  'ARRAY', 	   'Return array as expected';
		is   $oids->[0], 'ABC9999',    'First known OID returned as expected [ABC9999]';
		like $oids->[1], qr/^\d{10}$/, 'Second autogen OID returned as expected';
		is scalar @{$Test::Mock::Mango::data->{collection}}, 9, 'Data inserted';
	};
};

# ------------------------------------------------------------------------------

subtest "Non-blocking syntax" => sub {
	my $mango = Mango->new('mongodb://localhost:123456'); # FAKE!

	subtest "Single insert - autogen id" => sub {
		plan tests => 2;
		$mango->db('foo')->collection('bar')->insert({
			name => 'Ned Flanders',
			job	 => 'Neigdiddlyabour',
			dob  => '1942-01-01',
			hair => 'brown',
		}
		=> sub {
			my ($collection, $err, $oid) = @_;
			like $oid, qr/^\d{10}$/, "Single generated OID returnded as expected [$oid]";
			is scalar @{$Test::Mock::Mango::data->{collection}}, 10, 'Data inserted';
		});		
	};

	subtest "Single insert - known id" => sub {
		plan tests => 2;
		$mango->db('foo')->collection('bar')->insert({
			_id	 => 'ABC1235',
			name => 'Ned Flanders',
			job	 => 'Neigdiddlyabour',
			dob  => '1942-01-01',
			hair => 'brown',
		}
		=> sub {
			my ($collection, $err, $oid) = @_;
			is $oid, 'ABC1235', "Single known OID returnded as expected [ABC1234]";
			is scalar @{$Test::Mock::Mango::data->{collection}}, 11, 'Data inserted';
		});		
	};

	subtest "Multiple insert - mix ids" => sub {
		plan tests => 4;
		my $oids = $mango->db('foo')->collection('bar')->insert([
			{
				_id	 => 'ABC9998',
				name => 'Ned Flanders',
				job	 => 'Neigdiddlyabour',
				dob  => '1942-01-01',
				hair => 'brown',
			},
			{				
				name => 'Todd Flanders',
				job	 => 'Annoyance',
				dob  => '1984-01-01',
				hair => 'brown',
			},
		]
		=> sub {
			my ($collection, $err, $oids) = @_;
			is   ref $oids,  'ARRAY', 	   'Return array as expected';
			is   $oids->[0], 'ABC9998',    'First known OID returned as expected [ABC9998]';
			like $oids->[1], qr/^\d{10}$/, 'Second autogen OID returned as expected';
			is scalar @{$Test::Mock::Mango::data->{collection}}, 13, 'Data inserted';
		});		
	};

};

done_testing();
