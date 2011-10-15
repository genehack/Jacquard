package Test::Jacquard::Schema::User;
use strict;
use warnings;

use parent 'Test::BASE';

use Test::Most;

use KiokuX::User::Util qw/ crypt_password /;

use Jacquard::Schema::User;

sub test_constructor :Tests(7) {
  my $test = shift;

  my $user = Jacquard::Schema::User->new(
    id       => 'user1' ,
    email    => 'user1@example.com' ,
    password => crypt_password( 'bad_password' ) ,
  );

  isa_ok( $user , 'Jacquard::Schema::User' );

  is( $user->id       , 'user1'             , 'id' );
  is( $user->username , 'user1'             , 'name delegated to id' );
  is( $user->email    , 'user1@example.com' , 'email' );

  ok( $user->check_password( 'bad_password' ) , 'check password' );
  ok( ! $user->check_password( 'wrong password' ), 'check wrong password' );

  is_deeply( [ $user->accounts->members ] , [] , 'no accounts' );
}

1;


# package Test::Jacquard::Schema::User;
# use strict;
# use warnings;

# use parent 'Test::BASE';

# use Test::Most;

# use KiokuX::User::Util qw/ crypt_password /;

# use Jacquard::Schema::User;

# sub fixtures :Tests(startup) {
#   my $test = shift;

#   $test->{user} = Jacquard::Schema::User->new(
#     username => 'John Smith',
#     id       => 'rambo1971' ,
#     password => crypt_password( 'password' ) ,
#   );
# }

# sub test_constructor_and_add_friend :Tests(10) {
#   my $test = shift;
#   my $user = $test->{user};

#   isa_ok( $user , 'Jacquard::Schema::User' );
#   is( $user->username , 'John Smith' , 'username' );
#   is( $user->id       , 'rambo1971' , 'id' );

#   ok( $user->check_password( 'password' ) , 'check password' );
#   ok( ! $user->check_password( 'bad' ) , 'bad password' );

#   is_deeply( [ $user->friends->members ]  , [] , 'no friends'  );
#   is_deeply( [ $user->accounts->members ] , [] , 'no accounts' );

#   my $other_user = Jacquard::Schema::User->new(
#     username => 'Bob' ,
#     id       => 'boboborino' ,
#     password => crypt_password( 'bobpass' ),
#   );

#   $user->add_friend( $other_user );

#   is_deeply( [ $user->friends->members ] , [ $other_user ] , '1 friend' );
#   is_deeply( [ $other_user->friends->members ] , [ ] , 'not inherently reciprocal' );

#   $other_user->add_friend( $user );
#   is_deeply( [ $other_user->friends->members ] , [ $user ] , 'but can be' );
# }

# 1;

