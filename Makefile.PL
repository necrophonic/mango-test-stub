use 5.010001;

use strict;
use warnings;

use Config;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME		=> 'Test::Mock::Mango',
	VERSION		=> '0.01.3',
	ABSTRACT 	=> 'Simple stubbing for Mango to allow unit tests for code that uses it',
	AUTHOR		=> 'J Gregory <john@johngregory.me.uk>',
	LICENSE		=> 'artistic_2',
	PREREQ_PM	=> {		
		'Mango'		   => '0.17',
	},
	BUILD_REQUIRES => {
		"Test::More" 	  => '0.99',
		"Test::Exception" => '0.32',
	},	
	META_MERGE => {
		requires  => {perl => '5.010001'},
		resources => {
			homepage	=> 'http://github.com/necrophonic/test-mock-mango',
			license     => 'http://www.opensource.org/licenses/artistic-license-2.0',
			repository	=> 'http://github.com/necrophonic/test-mock-mango',
			bugtracker	=> 'http://github.com/necrophonic/test-mock-mango/issues'
		},
		no_index => {directory => ['t']}
	},
	test => { TESTS	=> 't/*.t' },
	dist => { COMPRESS => "gzip -9", SUFFIX => "gz" },
);

