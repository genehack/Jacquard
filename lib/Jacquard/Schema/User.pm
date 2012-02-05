package Jacquard::Schema::User;
# ABSTRACT: Jacquard users
use Moose;
with qw/ KiokuX::User /;        # provides 'id' and 'password' attributes

use Class::Load                qw/ load_class /;
use Jacquard::Schema::Account;
use KiokuDB::Set;
use KiokuDB::Util              qw/ set /;
use MooseX::Aliases;
use MooseX::Types::Email       qw/ EmailAddress /;

use namespace::autoclean;

# we want to have our username be our unique ID in Kioku
alias username => 'id';

has email => (
  isa      => EmailAddress ,
  is       => 'ro' ,
  required => 1 ,
);

has accounts => (
  isa     => 'KiokuDB::Set',
  is      => 'ro',
  lazy    => 1 ,
  default => sub { set() },
);

has friends => (
  isa     => 'KiokuDB::Set' ,
  is      => 'ro' ,
  lazy    => 1 ,
  default => sub { set() },
);

sub BUILDARGS {
  my $class = shift;

  # let the default BUILDARGS deal with the whole hash/hashref thing.
  my $params = $class->next::method(@_);

  $params->{id} = delete $params->{username}
    if exists $params->{username};

  return $params;
}

sub add_account {
  my( $self , $service , %options ) = @_;

  ### FIXME need real exceptions
  try_load_class( "Jacquard::Schema::Account::$service" )
    or die "Failed to load class for $service";

  ### FIXME need real exceptions
  my $account = "Jacquard::Schema::Account::$service"->new(
    owner => $self ,
    %options ,
  ) or die "Failed to add $service account";

  $self->accounts->insert( $account );
}

sub add_friend {
  my( $self , $friend ) = @_;
  $self->friends->insert( $friend );
}

__PACKAGE__->meta->make_immutable;
1;
