package Jacquard::Web::Model::KiokuDB;
use Moose;

use Jacquard::Model::KiokuDB;

BEGIN { extends qw(Catalyst::Model::KiokuDB) }

has '+model_args'  => ( default => sub { { extra_args => { create => 1 }}});
has '+model_class' => ( default => 'Jacquard::Model::KiokuDB' );

__PACKAGE__->meta->make_immutable;
1;
