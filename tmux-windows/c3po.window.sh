window_root "~/private_projects/c3po"

new_window "vim"
select_window "vim"
run_cmd "vim ."

new_window "zeus master"
select_window "zeus master"
run_cmd "rm -f .zeus.sock"
run_cmd "zeus start"

new_window "server"
new_window "console"

select_window "zeus master"
