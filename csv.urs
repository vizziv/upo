(* Support for parsing comma-separated text files *)

val importTable : fs ::: {Type} -> cs ::: {{Unit}}
                  -> $(map sql_injectable fs) -> $(map read fs) -> folder fs
                  -> sql_table fs cs
                  -> int (* the number of header lines to skip *)
                  -> string
                  -> transaction unit

val parse : fs ::: {Type}
            -> $(map sql_injectable fs) -> $(map read fs) -> folder fs
            -> int (* the number of header lines to skip *)
            -> string
            -> list $fs

(* And we can also generate CSV data: *)
functor Generate1(M : sig
                      con fs :: {Type}
                      con tab :: Name
                      val query : sql_query [] [] [tab = fs] []
                      val fl : folder fs
                      val shows : $(map show fs)
                      val labels : $(map (fn _ => string) fs)

                      val mayAccess : transaction bool
                      val filename : string (* Tell browsers this is the name of the file being downloaded. *)
                  end) : Ui.S0
