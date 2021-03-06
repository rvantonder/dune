open Import

module Kind = struct
  type t =
    | Optional
    | Required

  let merge a b =
    match a, b with
    | Optional, Optional -> Optional
    | _ -> Required
end

type t = Kind.t String.Map.t

let merge a b =
  String.Map.merge a b ~f:(fun _ a b ->
    match a, b with
    | None, None -> None
    | x, None | None, x -> x
    | Some a, Some b -> Some (Kind.merge a b))
