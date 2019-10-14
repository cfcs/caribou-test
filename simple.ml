
module Example = struct
  type item = {pid : int; cwd : string; progress : int * int}
  let sexp_of_item {pid;cwd;progress=(pg1,pg2)} =
    Printf.sprintf "(item (pid %d) (cwd %S) (progress %d %d))"
      pid cwd pg1 pg2

  let list =
    [ {pid = 1; cwd = "~/test"; progress = (5, 5324)}
    ; {pid = 0; cwd = "~/code"; progress = (2, 5324)}
    ; {pid = 1; cwd = "~/write"; progress = (5, 5324)}
    ; {pid = 2; cwd = "~/build"; progress = (23, 5324)} ]

  let list () = list

  let show m ~selected =
    let attr =
      if selected then Notty.A.(fg black ++(bg @@ rgb_888 ~r:53 ~g:242 ~b:160))
      else Notty.A.empty
    in
    Notty.I.string attr (sexp_of_item m)

  let inspect _m =
    let text =
      "pretend we executed ls with system()"
    in
    let attr = Notty.A.(bg blue) in
    Caribou.Notty_helpers.image_of_string attr text
end

module App = Caribou.Make (Example) (Caribou.Tty_display)

let () = Lwt_main.run (App.run ())
