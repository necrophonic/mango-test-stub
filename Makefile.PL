use 5.010001;

use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'MojoX-Test-MangoStub',
	VERSION_FROM	=> 'lib/MojoX/Test/MangoStub.pm',
	ABSTRACT	=> 'Simple stubbing for Mango to allow unit tests for code that uses it',
	AUTHOR		=> 'J Gregory <john@johngregory.me.uk>',
	LICENSE		=> 'artistic_2',
	PREREQ_PM	=> {
		'Readonly' 	   => '1.03',
		'Mango'		   => '0.17',
	},
	TEST_REQUIRES => {
		"Test::More" 	  => '0.99',
		"Test::Exception" => '0.32'
	},
	test 			=> {
		TESTS	=> 't/*.t'
	},
	'dist'          => { COMPRESS => "gzip -9", SUFFIX => "gz" },
);
