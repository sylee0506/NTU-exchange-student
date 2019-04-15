/*
Assignment 2: Kids day at school
Assume that the prolog script is a parent, trying to know about a kids day at school. The prolog script should converse intelligently with the kid as follows. The prolog script should ask a question to the kid that kid can answer in yes or no. Depending on whether the answer is yes or no, prolog script should ask a related question or another random question.
*/

% Declare dynamic variables. "did" and "didnot" has different value each
% time, and it stores old values.
:- dynamic did/1.
:- dynamic didnot/1.

% You can start program by "ask(0)." query. Kid will be asked the mood
% of the day. In this query, kid can only answer y./n. (not q.).

% 1) If kid answers y, it means kid did activities that he/she likes at
% school. Those activities are clarified as "like([])" fact below. You
% will first ask if kid played at school.

% 2) If kid answers n, it means kid did activities that he/she does not
% like at school. Those activities are clarified as "dislike([])" fact
% below. You will first ask if kid tested at school.
ask(0):-
	write("Welcome Home! Was it a good day at school?  (y./n.:) "),read(KidAns),
	(KidAns==y -> validate_and_query_options([play]);KidAns==n -> validate_and_query_options([test])).

% You can keep asking according to conditions clarified in
% generate_options and validate_and_query_options.
ask(Y):-
	generate_options(Y,L),validate_and_query_options(L).


% Parameter Y is passed from validate_and_query_options. It means kid
% was asked if he/she did activity Y.

% 1) If kid answered he/she did Y, then check facts to find next
% question. If kid did play/eat/test/make/watch/exercise, ask relevant
% question by returning list of each facts. If kid did other activities,
% print proper response depending on kid's mood and ask random question.

% 2) If kid answered he/she not did Y, ask other random activities
% depend on kid's mood. For example, if kid's mood is good, you only
% allowed to ask activities which kid likes. If kid's mood is bad, you
% only allowed to ask activities which kid does not like.

% To find out activities related to kid's mood, we need to look up
% "like" and "dislike" facts. Each activity fact stores main behavior as
% first element. For example, play([play, train, ...]).
% So we first get activity's name by using total_related(X,Y).
% Then we get head of the activity list, and search if the activities is
% in "like" fact or in "dislike" fact.
generate_options(Y,L):-
	did(Y),((play(PlayList),member(Y,PlayList),findall(X,play_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you play "));
	(eat(EatList),member(Y,EatList),findall(X,eat_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you eat "));
	(test(TestList),member(Y,TestList),findall(X,test_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you test "));
	(make(MakeList),member(Y,MakeList),findall(X,make_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you make "));
	(watch(WatchList),member(Y,WatchList),findall(X,watch_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you watch "));
	(exercise(ExerciseList),member(Y,ExerciseList),findall(X,exercise_related(X,Y),L1),random_permutation(L1,L),write("Okay, did you do "));		(like(LikeList),member(Y,LikeList),findall(X,like_related(X,Y),L1),random_permutation(L1,L),write("You must had a great day! Did you "));
	(dislike(DislikeList),member(Y,DislikeList),findall(X,dislike_related(X,Y),L1),random_permutation(L1,L),write("I'm sorry to hear that... Did you ")));
	didnot(Y),findall(X,total_related(X,Y),L1),[H|T]=L1,write("Then... Did you "),((like(LikeList),member(H,LikeList),findall(X,like_related(X,H),L));
(dislike(DislikeList),member(H,DislikeList),findall(X,dislike_related(X,H),L))).


% To avoid asking same questions, created list named "Valid" by
% subtracting Input list from History. Able to make History list by
% union DidList, which is all(old and new) values of did(X), and
% DidnotList, which is all values of didnot(X).
% If Valid is empty list, it means you can't ask questions no more(used
% all facts, etc.). Then stop excution using abort.

% Then get a random element X from Valid list.
% 1) If X is 'play', that means it is right after mood question and kid
% mood was good. Print proper response and ask if kid played.
% 2) If X is 'test', that means it is right after mood question and kid
% mood was not good. Print proper response and ask if kid tested.
% 3) Else, that means it is not a first question. In this case, already
% printed proper response at generated_options above. So just ask what
% kid did by using print(X).

% Kid can answer y./n./q. from now on.
% 1) If kid answers y, it means kid did the activity. Store X as did(X)
% using assert().
% 2) If kid answers n, it means kid not did the activity. Store X ans
% didnot(X) using assert().
% 3) If kid answers q, stop execution using abort.
validate_and_query_options(L):-
	findall(X,did(X),DidList),findall(X,didnot(X),DidnotList),append(DidList,DidnotList,History),list_to_set(L,S),list_to_set(History,H),subtract(S,H,Valid),(length(Valid,0) -> abort;random_member(X,Valid)),(
			        X==play -> (write("Awesome! Did you "),print(X));
			        X==test -> (write("What's the matter? Did you "),print(X));
				print(X)),write("?  (y./n./q.:) "), read(KidAns),(KidAns==q -> abort;KidAns==y -> assert(did(X));
					KidAns==n -> assert(didnot(X))), ask(X).

% Clarify related facts to find all X element which is related with Y.
total_related(X,Y):-
	like(L),member(X,L),member(Y,L);
	dislike(L),member(X,L),member(Y,L);
	play(L),member(X,L),member(Y,L);
	eat(L),member(X,L),member(Y,L);
	test(L),member(X,L),member(Y,L);
	make(L),member(X,L),member(Y,L);
	watch(L),member(X,L),member(Y,L);
	exercise(L),member(X,L),member(Y,L).

like_related(X,Y):-
	like(L),member(X,L),member(Y,L).

dislike_related(X,Y):-
	dislike(L),member(X,L),member(Y,L).

play_related(X,Y):-
	play(L),member(X,L),member(Y,L).

eat_related(X,Y):-
	eat(L),member(X,L),member(Y,L).

test_related(X,Y):-
	test(L),member(X,L),member(Y,L).

make_related(X,Y):-
	make(L),member(X,L),member(Y,L).

watch_related(X,Y):-
	watch(L),member(X,L),member(Y,L).

exercise_related(X,Y):-
	exercise(L),member(X,L),member(Y,L).

% Declared facts.
% "like" has activities that kid likes. If he/she did those things,
% kid's mood is good.
% "dislike" has activities that kid does not like. If he/she did those
% things, kid's mood is not good.
% Each "play","eat","test","make","watch","exercise" activities has its
% own facts which will be used to ask relevant questions.
like([play,eat,watch,swim,take_nap,talk_friends,read_book,play_game,take_rest]).
dislike([test,exercise,make,study,clean_up,do_assignment,check_test_score,draw_picture,memorize_words]).
play([play,sandbox,toys,trains,dolls,half_hour,one_hour,with_friends,with_teacher]).
eat([eat,cake,candy,sandwich,pizza,fries,with_spoon,with_fork,after_washing_hands,and_clean_up]).
test([test,math,science,alphabets,open_book,online,easy_level,hard_level]).
make([make,bread,doll,cookie,with_friend,for_dad,for_mom,for_sister]).
watch([watch,movie,animation,musical,boring_one,interesting_one,scary_one,two_hours,three_hours]).
exercise([exercise,running,soccer,basketball,well,win,hurt]).

% Initialize dynamic variables.
did(nothing).
didnot(nothing).

a.












