#! perl
use strict;
use warnings;

use lib './lib';
use Jacquard::Web;

my $app = Jacquard::Web->apply_default_middlewares(Jacquard::Web->psgi_app);
$app;
