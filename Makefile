all: calctl

calctl: calendar.ml
    ocamlc -o calctl unix.cma calendar.ml

clean:
    rm -f calctl *.cmi *.cmo

run: calctl
    ./calctl
