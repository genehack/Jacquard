package Jacquard::Model::KiokuDB;
# ABSTRACT: KiokuX::Model wrapper for Jacquard
use Moose;
extends qw/ KiokuX::Model /;

sub insert_user {
  my( $self , $user ) = @_;

  my $id = $self->txn_do(sub {
      $self->store( $user )
  });

  return $id;
}

__PACKAGE__->meta->make_immutable;
1;
