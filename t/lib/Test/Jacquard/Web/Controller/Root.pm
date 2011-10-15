package Test::Jacquard::Web::Controller::Root;
use parent 'Test::BASE';

use strict;
use warnings;

use Test::Most;
use Test::WWW::Mechanize::Catalyst;

sub fixtures :Tests(startup) {
  my $test = shift;

  # load test config
  $ENV{CATALYST_CONFIG_LOCAL_SUFFIX} = 'test';

  $test->{mech} = Test::WWW::Mechanize::Catalyst->new( catalyst_app => 'Jacquard::Web' );
}

sub auth_test :Tests() {
  my $test = shift;
  my $mech = $test->{mech};

  $mech->get_ok( '/' , 'basic request works' );
  is( $mech->uri->path , '/' , 'at top page' );

  $mech->get_ok( '/hello_user' , 'request hello_user' );
  is( $mech->uri->path , '/login' , 'redirect to login' );

  $mech->submit_form_ok({
    form_id => 'login_form' ,
    fields  => {
      username => 'test_user' ,
      password => 'test_password' ,
    } ,
    button => 'submit' ,
  } , 'login' );

  is( $mech->uri->path , '/hello_user' , 'redirect to /hello_user' );
  $mech->text_contains( 'Hello, test_user!' , 'see expected greeting' );

  $mech->get_ok( '/' , 'basic request works' );
  is( $mech->uri->path , '/' , 'at home page' );

  $mech->get_ok( '/hello_user' , 'request hello_user' );
  is( $mech->uri->path , '/hello_user' , 'go directly to hello_user' );
  $mech->text_contains( 'Hello, test_user!' , 'still see expected greeting' );

  $mech->get_ok( '/logout' );
  is( $mech->uri->path , '/' , 'back at home page' );

  $mech->get_ok( '/hello_user' , 'request hello_user' );
  is( $mech->uri->path , '/login' , 'redirect to login' );
}


1;
