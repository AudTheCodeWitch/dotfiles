function run_mock_server(){
    local port="$1"
    local usage=$(cat <<-END
    Running mock server in the background always responding with 200.
    More info: https://fabianlee.org/2016/09/26/ubuntu-simulating-a-web-server-using-netcat/
    Test:
        $ curl localhost:${port}
        > 200 Tue 22 Oct 2019 19:38:57 BST
    To exit the program:
    1. Press 'ctrl+z' (linux) or 'control+z' (mac) which puts the job in the backround.
    2. Print all jobs and kill the loop:
         $ jobs
         $ kill %1
    Listening on localhost:${port}...

END
)
    echo -e "${usage}"
    while true; do
      echo -e "HTTP/1.1 200 OK\n\n200 $(date)" | nc -l localhost ${port};
    done
}

alias mockserver='run_mock_server 9000'
