use 5.010001;

use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'Test-Mock-Mango',
	VERSION_FROM	=> 'lib/Test/Mock/Mango.pm',
	ABSTRACT	=> 'Simple stubbing for Mango to allow unit tests for code that uses it',
	AUTHOR		=> 'J Gregory <john@johngregory.me.uk>',
	LICENSE		=> 'artistic_2',
	PREREQ_PM	=> {
		'Readonly' 	   => '1.03',
		'Mango'		   => '0.17',
	},
	CONFIGURE_REQUIRES => {
		"Test::More" 	  => '0.99',
		"Test::Exception" => '0.32',
		"Test::Spec"	  => '0.47',
	},
	test 			=> {
		TESTS	=> 't/*.t'
	},
	'dist'          => { COMPRESS => "gzip -9", SUFFIX => "gz" },
);

