female(elizabeth).
female(ann).
male(charles).
male(andrew).
male(edward).
parent_of(elizabeth,charles).
parent_of(elizabeth,ann).
parent_of(elizabeth,andrew).
parent_of(elizabeth,edward).
older_than(charles,ann).
older_than(ann,andrew).
older_than(andrew,edward).
youngest(edward).

old_succ(X,Y):-(parent_of(Y,X),male(X),((older_than(X,Z),parent_of(Y,Z));youngest(X)));(parent_of(Y,X),female(X),((older_than(X,Z),parent_of(Y,Z));youngest(X))).
new_succ(X,Y):-parent_of(Y,X),((older_than(X,Z),parent_of(Y,Z));youngest(X)),(male(X);female(X)).