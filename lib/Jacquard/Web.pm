package Jacquard::Web;
# ABSTRACT: Jacquard web application
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
    -Debug
    ConfigLoader
    +CatalystX::SimpleLogin
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
    Static::Simple
/;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config( 'Plugin::ConfigLoader' => { file => 'jacquard.yaml' } );

# Start the application
__PACKAGE__->setup();

1;
