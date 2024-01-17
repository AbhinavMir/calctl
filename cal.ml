type time = int * int
type schedule_item = ((time * time) * string)

let make_time (hour, minute) = (hour, minute)

let schedule = [
  ((make_time (0, 0), make_time (23, 59)), "You haven't scheduled anything for today yet!");
]

let current_time () =
  let open Unix in
  let tm = localtime (time ()) in
  (tm.tm_hour, tm.tm_min)

let time_in_range (start_hour, start_min) (end_hour, end_min) (hour, min) =
  let start = (start_hour * 60) + start_min in  let ending = if end_hour < start_hour then (end_hour + 24) * 60 + end_min else end_hour * 60 + end_min in
  let current = (hour * 60) + min in
  current >= start && current < ending

let rec find_activity time = function
  | [] -> "Free time"
  | ((start, end_), activity) :: rest ->
      if time_in_range start end_ time then activity else find_activity time rest

let rec main_loop () =
  let time = current_time () in
  let activity = find_activity time schedule in
  Printf.printf "\rCurrent time: %02d:%02d - Activity: %s%!" (fst time) (snd time) activity;
  Unix.sleep 60;
  main_loop ()

let () = main_loop ()

