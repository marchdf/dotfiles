#!/usr/local/bin/MathematicaScript -script

(*#!/usr/local/bin/WolframScript -script*)
(*#!/usr/local/bin/MathematicaScript -script*)
(*This runs a mathematica command (fed to it by Python in this case)*)
(*Taken from http://mathematica.stackexchange.com/questions/4643/how-to-use-mathematica-functions-in-python-programs*)

(* This command prints the whole command line passed to the script *)
(* Print[$ScriptCommandLine] *)

value=ToExpression[$ScriptCommandLine[[2]]];

(*The next line prints the script name.*)
(*Print[$ScriptCommandLine[[1]]];*)

Print[value];