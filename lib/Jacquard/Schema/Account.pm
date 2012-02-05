package Jacquard::Schema::Account;
# ABSTRACT: Base 'account' object
use Moose;
use namespace::autoclean;

use KiokuDB::Set;
use KiokuDB::Util              qw/ set /;

has name => (
  isa      => 'Str' ,
  is       => 'ro' ,
  required => 1 ,
);

has owner => (
  isa      => 'Jacquard::Schema::User' ,
  is       => 'ro' ,
  required => 1 ,
);

has posts => (
  isa     => 'KiokuDB::Set',
  is      => 'rw',
  lazy    => 1 ,
  default => sub { set() },
);

__PACKAGE__->meta->make_immutable;
1;
