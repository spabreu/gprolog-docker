:- unit(lists).

app([], X, X).
app([A|As], X, [A|Bs]) :- app(As, X, Bs).
