#! perl
use strict;
use warnings;

# silence debug output
BEGIN { $ENV{CATALYST_DEBUG} = 0; }

use Test::Class::Load qw<t/lib>;
