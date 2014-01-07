use 5.010001;

use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME			=> 'Test::Mock::Mango',
	VERSION			=>  '0.01.1',
	ABSTRACT_FROM	=> 'lib/Test/Mock/Mango.pm',
	AUTHOR			=> 'J Gregory <john@johngregory.me.uk>',
	LICENSE			=> 'artistic_2',
	PREREQ_PM	=> {		
		'Mango'		   => '0.17',
	},
	BUILD_REQUIRES => {
		"Test::More" 	  => '0.99',
		"Test::Exception" => '0.32',
	},	
	test 			=> {
		TESTS	=> 't/*.t'
	},
	'dist'          => { COMPRESS => "gzip -9", SUFFIX => "gz" },
);

