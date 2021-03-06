(* Moving through steps in the life cycle of an application *)

datatype activatedAs = NextStep | FastForward | Rewind

type metadata = {Label : string,
                 WhenEntered : activatedAs -> transaction unit}

style downArrow
style label

functor Make(M : sig
                 con steps :: {Unit}
                 val fl : folder steps

                 val mayChange : transaction bool
             end) : sig
    type step = variant (mapU unit M.steps)
    val step_eq : eq step
    val step_ord : ord step
    val current : transaction step

    functor MakeUi(N : sig
                       val steps : $(mapU metadata M.steps)
                   end) : Ui.S0
end
