package Test::Jacquard::Model::KiokuDB;
use parent 'Test::BASE';

use strict;
use warnings;

use Test::Most;

use Jacquard::Model::KiokuDB;
use Jacquard::Schema::User;

use KiokuX::User::Util qw/ crypt_password /;

sub fixtures :Tests(startup) {
  my $test = shift;

  $test->{model} = Jacquard::Model::KiokuDB->new( dsn => 'hash' );
}

sub test_insert_user :Tests(3) {
  my $test = shift;
  my $m    = $test->{model};

  {
    my $s = $m->new_scope;

    my $id = $m->insert_user(
      Jacquard::Schema::User->new(
        username => 'user1' ,
        email    => 'user1@example.com' ,
        password => crypt_password( 'bad_password' ) ,
      ),
    );


    ok( $id , 'got id' );

    my $user = $m->lookup( $id );

    isa_ok( $user , 'Jacquard::Schema::User' , 'looked up user' );
    is( $user->username , 'user1' , 'expected name' );
  }
}

1;
