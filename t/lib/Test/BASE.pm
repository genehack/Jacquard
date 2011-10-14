package Test::BASE;
use parent 'Test::Class';

INIT { Test::Class->runtests }

1;
